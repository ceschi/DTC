% CALVO 2016 - NOMINAL ANCHORING WITH LIQUID MONETARY POLICY ASSETS
%
%
% Discrete tiem version of the model augmented with
% - explicit output gap
% - implicitly defined money demand
% - AR shocks 
% - options for Taylor Rule
% 
% V0.2

@#define type_taylor = 0
% defines a macro-variable to select among 
% different specification of the TR: 
%  - 0 for standard model 
%  - 1 for model with output gap in the TR


%%% VARIABLES DECLARATION %%%

% endogeneous variables
var z				${z}$						(longname='total liquidity')
	c 	 			${c}$						(longname='consumption')
	m 				${m}$						(longname='money')
	infl			${\pi}$						(longname='inflation')
	output			${y}$						(longname='output')
	e_ee			${\varepsilon^{EE}}$		(longname='Euler eqn shock')
	e_pc			${\varepsilon^{PS}}$		(longname='Phillips curve shock')
	s 				${s}$						(longname='Liquid bond yield')
;

predetermined_variables z;
% declares predetermined (state) variables

% exogeneous variables
varexo shock_e_ee	${\nu^{EE}}$				(longname='EE AR shock')
	   shock_e_pc	${\nu^{PC}}$				(longname='PC AR shock')
	   e_out		${\nu^{y}}$					(longname='output shock')
@#if type_taylor == 1
	   shock_pol	${\nu^{pol}}$				(longname='Shock to monpol rule on ')
@#endif
;


%%% DECLARING PARAMETER SET AND VALUES %%%

parameters eta			${\eta}$				(longname='Relative risk aversion parameter')
		   bet			${\beta}$				(longname='discount factor')
		   theta		${\theta}$				(longname='Policy parameter, reaction to inflation in TR')
		   mu			${\mu}$					(longname='Policy parameter, reaction to real slack')
		   sigm			${\sigma}$				(longname='Calvo price update frequency')		% this parameter is usually labelled kappa
		   chi			${\chi}$				(longname='Persistence of output gap')
		   rho_ee_s		${\rho_{\varepsilon_{EE}}}	(longname='Persistence of II order shock to EE')
		   rho_pc_s		${\rho_{\varepsilon_{PC}}}	(longname='Persistence of II order shock to PC')
		   ybar			${\bar{y}}$				(longname='Mean for output')
@#if type_taylor == 1
		   omega		${\omega}$				(longname='TR real part when type_taylor=1')
		   rho 			${\rho_{\pi}}$			(longname='policy rate smoothing when type_taylor=1')
@#endif
;

% Parametrization/calibration
% core invariant parameters
eta =	1.39;
bet =	0.975;
mu =	0.93;

% optional parameters
rho =	 .9;
chi = 	 .95;
ybar=	1;

% persistence for AR shock processes
% setting these to 0 reproduces original model
rho_ee_s = .95;
rho_pc_s = .85;


% tuning parameters
sigm	=  1.5;
theta	=  1.5;



%%% MODEL BLOCK %%%

model;
%% core equations %%

z(+1)=z/(1+infl(+1));
% total real liquidity

c^(-eta)=c(+1)^(-eta)*bet*((1/m)/(bet*c(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;
% Euler equation for consumption -- with shock

infl=sigm*infl(+1) + mu*(c-output) + e_pc;
% Phillips curve / inflation evolution -- with shock

1/(z-m) - 1/m = -(bet * c(+1)^(-eta) * s)/(1+infl(+1));
% implicit money demand

output = (1-chi)*ybar + chi*output(-1) + e_out;
% process for the output path


% AR structure for selected shocks
e_pc = rho_pc_s*e_pc(-1) + shock_e_pc;
e_ee = rho_ee_s*e_ee(-1) + shock_e_ee;

%% TR and depending eqns
@#if type_taylor == 0
	s=theta*infl(+1);
	% policy rule as specified in the paper

@#else  % !!! -- EXPERIMENT & TUNING HERE -- !!!
	s=theta*infl(+1) + omega * (c-output) + rho * s(-1) + shock_pol;
	% policy rule as specified in the paper
@#endif
end;

%%% STEADY STATE BLOCK %%%

steady_state_model;
infl=0;
output=ybar;
c=output;
m=1/((1-bet)*c^(-eta));
z=2*m;
s=theta*infl;
end;

% alternatively, have the SS solved numerically
% !!! to improve !!!

% 1k iteration for searching SS, solving with Sims algo
% steady(maxit=1000, solve_algo=2);

%%%% SHOCKS' MOMENTS %%%%
shocks;
var shock_e_ee; 		  stderr .1;
var shock_e_pc; 		  stderr .1;
var e_out;    	 		  stderr .01;
@#if type_taylor == 1
	var shock_pol; 		  stderr .1;
@#endif
end;

% model status check, Sims algo, higher threshold for Jacobian matrix
check(solve_algo=2, qz_zero_threshold=1e-10);

%%% SIMULATIONS %%%


% stochastic simulations
stoch_simul(order=1,			% order of Taylor expansion
			nocorr,				% do not output correlation matrix
			solve_algo=2,		% nonlinear solver: 0=fsolve, matlab's own; 1=Dynare's own; 2=Dynare's own but block-recursive; 3=Sim's...
			irf=100,			% periods to include in IRFs' plots
			periods=50000,		% number of periods to use in the simulations
			drop=10000,			% burn-in sample
			replic=50			% number of series to compute IRFs
			);