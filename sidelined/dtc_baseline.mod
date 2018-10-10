% Model for simulations of Calvo 2016
%
%
% Discrete time version with additional implicit 
% equation to define money demand, 
%               money is not state var here



% DECLARING VARIABLES
var z c m infl output;
predetermined_variables z m;
varexo e_ee e_pc e_out;

% DECLARING PARAMETERS SET AND VALUES

parameters eta bet theta mu rho sigm chi;

% core invariant parameters
eta =	1.39;	      % relative risk aversion parameter
bet =	0.975;	      % time preference parameter
mu =	0.93;	      % real part for simpler Taylor rule: estimate come from paper

% optional parameters
rho =	.97;	      % AR coefficient for inflatio
chi = 	.95;		  % AR coefficient for output - in case

% tuning parameters
sigm= 1.5;     	  	  % reaction to inflation param, Taylor (previously betheta, check and replace)
theta=.1;		  	  % Policy parameter, interest rate as inflation function

% DECLARING MODEL EQUATIONS

model;
% core settled equations
z(+1)=z/(1+infl(+1));															  % evolution of liquidity
c^(-eta)=c(+1)^(-eta)*bet*((1/m)/(bet*c(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;	  % euler equation for consumption
1/(z-m) - 1/m = -(bet * c(+1)^(-eta) * theta * infl(+1))/(1+infl(+1));

% plug-in equations 
infl=sigm*infl(+1) + mu*(-output+c) + e_pc;									  % evolution of inflation, phillips curve
log(output) = chi*log(output(-1)) + e_out;										  % process for the output path
end;

% the block above determines the path of natural output, 
% so that it will be possible to have output gaps over
% the simulations, and let the real part of the Taylor 
% rule to kick in.
%%%%%% DELETED BLOCK WITH INITVAL/ENDVAL %%%%%%%%%

steady_state_model;
infl=0;
output=1;                                       % required since now output is a variable
c=output;
m=1/((1-bet)*c^(-eta));
z=2*m;
end;

% 1k iteration for searching SS, solving with Sims algo
% steady(maxit=1000, solve_algo=2); 

% Declaring shocks moments
shocks;
var e_ee; 		  stderr .1;
var e_pc; 		  stderr .1;
var e_out;    	  stderr .1;
end;

% Finding steady state, if any
%steady;


% model status check, Sims algo, lower threshold for Jacobian matrix
check(solve_algo=2, qz_zero_threshold=1e-10);

% simulation part, order 1 Taylor expansion

stoch_simul(order=1, nocorr, solve_algo=2, irf=10); % Stochastic sim.
%simul(periods = 10000);			% deterministic sim.


%rplot infl;      % command does not work, neither in previous .mod files granted to work