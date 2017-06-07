% Model for simulations of Calvo 2016
%
%
% Discrete time version with additional implicit 
% equation to define money demand


% declaring the variables of the model

var z c m infl output;
predetermined_variables z m;
varexo e_ee e_pc e_out; % e_mon;

% declaring parameters and assigning values

parameters eta bet theta mu rho lambda ; %output;

eta =	1.39;	      % relative risk aversion parameter
bet =	0.975;	      % time preference parameter
theta=	.00008;		  % taylor parameter
mu =	.95;	      % real part for simpler Taylor rule
rho =	.5;	      % AR coefficient for output process
lambda= 1.9;     	  % Calvo parameter
%output=1;

% declaring the model equations

model;
z(+1)=z/(1+infl(+1));															  % evolution of liquidity
infl=lambda*infl(+1) + mu*(output-c) + e_pc + .5*rho*infl(-1);									  % evolution of inflation, phillips curve
1/(z-m) - 1/m = -(bet * c(+1)^(-eta) * theta * infl(+1))/(1+infl(+1));% + e_mon;			  % implicit money demand
c^(-eta)=c(+1)^(-eta)*bet*((1/m)/(bet*c(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;	  % euler equation for consumption
log(output) = rho*log(output(-1)) + e_out;										  % process for the output path
end;

% the block above determines the path of natural output, 
% so that it will be possible to have output gaps over
% the simulations, and let the real part of the Taylor 
% rule to kick in.
%%%%%% DELETED BLOCK wITH INITVAL/ENDVAL %%%%%%%%%

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
%var e_mon;        stderr .1;
end;

% Finding steady state, if any
%steady;


% model status check, Sims algo, lower threshold for Jacobian matrix,
% display results: BK condition, autocorr, etc
check(
	%solve_algo=2, 
	qz_zero_threshold=1e-10);

% simulation part, order 1 Taylor expansion

stoch_simul(order=1, nocorr, solve_algo=2, irf=40); % Stochastic sim.
%simul(periods = 10000);			% deterministic sim.


%rplot infl;      % command does not work, neither in previous .mod files granted to work


% model runs if m (money) is set as a state variable, so that it verifies the rank condition.
% Does it make sense to have money being a state variable? Since Z=B+M and Z and B are stock
% variables, it would seem leigitimate, but not necessarily.