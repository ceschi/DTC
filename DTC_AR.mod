% Model for simulations of Calvo 2016
%
%
% Discrete time version with additional implicit 
% equation to define money demand, 
%               money is not state var here



% DECLARING VARIABLES
% in the baseline version setting m as
% a predermined var does not satisfy rank condition
var z c m infl output e_ee e_pc;
predetermined_variables z; % m;
varexo shock_e_ee shock_e_pc e_out;

% DECLARING PARAMETERS SET AND VALUES

parameters eta bet theta mu rho sigm chi 
% persistence coefficients for AR shocks
rho_pc_s rho_ee_s
% mean for output
ybar
;

% core invariant parameters
eta =	1.39;	      % relative risk aversion parameter
bet =	0.975;	      % time preference parameter
mu =	0.93;	      % real part for simpler Taylor rule: estimate come from paper

% optional parameters
rho =	.97;	      % AR coefficient for inflation
chi = 	.95;		  % AR coefficient for output - in case
ybar=	1;			  % mean for output process

% persistence for AR shock processes
rho_ee_s = .85;
rho_pc_s = .85;

% tuning parameters
sigm	=  1.5;     	  	  % reaction to inflation param, Taylor (previously betheta, check and replace)
theta	= .1;		  	 	  % Policy parameter, interest rate as inflation function

% DECLARING MODEL EQUATIONS

model;
% core settled equations
z(+1)=z/(1+infl(+1));															  % evolution of liquidity
c^(-eta)=c(+1)^(-eta)*bet*((1/m)/(bet*c(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;	  % euler equation for consumption
1/(z-m) - 1/m = -(bet * c(+1)^(-eta) * theta * infl(+1))/(1+infl(+1));

% plug-in equations 
infl=sigm*infl(+1) + mu*(c-output) + e_pc;									  % evolution of inflation, phillips curve
output = (1-chi)*ybar + chi*output(-1) + e_out;										  % process for the output path

% AR structure for shocks
e_pc = rho_pc_s*e_pc(-1) + shock_e_pc;
e_ee = rho_ee_s*e_ee(-1) + shock_e_ee;

end;

% the block above determines the path of natural output, 
% so that it will be possible to have output gaps over
% the simulations, and let the real part of the Taylor 
% rule to kick in.


steady_state_model;
infl=0;
output=ybar;                                       % required since now output is a variable
c=output;
m=1/((1-bet)*c^(-eta));
z=2*m;
end;

% 1k iteration for searching SS, solving with Sims algo
% steady(maxit=1000, solve_algo=2); 

% Declaring shocks moments
shocks;
var shock_e_ee; 		  stderr .1;
var shock_e_pc; 		  stderr .1;
var e_out;    	 		  stderr .01;
end;

% Finding steady state, if any
%steady;


% model status check, Sims algo, lower threshold for Jacobian matrix
check(solve_algo=2, qz_zero_threshold=1e-10);

% simulation part, order 1 Taylor expansion

stoch_simul(order=1, nocorr, solve_algo=2, irf=40, periods=50000); % Stochastic sim.
%simul(periods = 10000);			% deterministic sim.

% TO PLOT INFLATION PATH
% in this version of the code, type 'plot(oo_.endo_simul[4:5, :])'
% where the row number identifies inflation variable (infl)
% and 5 is output gap path to check consistency
% as declared in the 'var' block order.