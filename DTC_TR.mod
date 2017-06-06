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
var z				%${z}$						(longname='total liquidity')
	c 	 			%${c}$						(longname='consumption')
	m 				%${m}$						(longname='money')
	infl			%${\pi}$						(longname='inflation')
	y			    %${y}$						(longname='output')
	e_ee			%${\varepsilon^{EE}}$		(longname='Euler eqn shock')
	e_pc			%${\varepsilon^{PS}}$		(longname='Phillips curve shock')
	//%s 				%${s}$						(longname='Liquid bond yield and policy tool')
	% s is shifted to exo variable to accomodate pegs
;

predetermined_variables z;
% declares predetermined (state) variables

% exogeneous variables
varexo shock_e_ee	%${\nu^{EE}}$				(longname='EE AR shock')
	   shock_e_pc	%${\nu^{PC}}$				(longname='PC AR shock')
	   e_out		%${\nu^{y}}$					(longname='output shock')
@#if type_taylor == 1
	   shock_pol	%${\nu^{pol}}$				(longname='Shock to monpol rule on ')
@#endif
		s 			%${s}$						(longname='Int. rate peg level')
;


%%% DECLARING PARAMETER SET AND VALUES %%%

parameters eta			%${\eta}$				(longname='Relative risk aversion parameter')
		   bet			%${\beta}$				(longname='discount factor')
		   theta		%${\theta}$				(longname='Policy parameter, reaction to inflation in TR')
		   mu			%${\mu}$					(longname='Policy parameter, reaction to real slack')
		   sigm			%${\sigma}$				(longname='Calvo price update frequency')		% this parameter is usually labelled kappa
		   chi			%${\chi}$				(longname='Persistence of output gap')
		   rho_ee_s		%${\rho_{\varepsilon_{EE}}}	(longname='Persistence of II order shock to EE')
		   rho_pc_s		%${\rho_{\varepsilon_{PC}}}	(longname='Persistence of II order shock to PC')
		   ybar			%${\bar{y}}$				(longname='Mean for output to mimic natural output level')
@#if type_taylor == 1
		   omega		%${\omega}$				(longname='TR real part when type_taylor=1')
		   rho 			%${\rho_{\pi}}$			(longname='policy rate smoothing when type_taylor=1')
@#endif
		   alp  % trying
;

% Parametrization/calibration
% core invariant parameters
eta =	1.39;
bet =	0.975;
mu =	0.93;

% optional parameters
@#if type_taylor == 1
	omega =  .75;
	rho =	 .5;
@#endif

chi = 	 .95;
ybar=	1;

% persistence for AR shock processes
% setting these to 0 reproduces original model
rho_ee_s =	0;%.95;
rho_pc_s =	0;%.85;


% tuning parameters
sigm	=  1.5; 
theta	=  1.5;

alp= .33;


%%% MODEL BLOCK %%%

model;
%% core equations %%

z(+1)=z/(1+infl(+1));
% total real liquidity

c^(-eta)=c(+1)^(-eta)*bet*((alp*m^(alp-1))/(bet*c(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;
% Euler equation for consumption -- with shock

infl=sigm*infl(+1) + mu*(c-y) + e_pc;
% Phillips curve / inflation evolution -- with shock

1/(z-m) - alp*m^(alp-1) = -(bet * c(+1)^(-eta) * s)/(1+infl(+1));
% implicit money demand

y = (1-chi)*ybar + chi*y(-1) + e_out;
% process for the output path


% AR structure for selected shocks
e_pc = rho_pc_s*e_pc(-1) + shock_e_pc;
e_ee = rho_ee_s*e_ee(-1) + shock_e_ee;

%% TR and depending eqns
//@#if type_taylor == 0
//	s=theta*infl(+1);
	//% policy rule as specified in the paper
//@#endif

@#if type_taylor == 1
    //% !!! -- EXPERIMENT & TUNING HERE -- !!!
	s=theta*infl(+1) + omega * (c-y) + rho * s(-1) + shock_pol;
	//% policy rule as specified in the paper
@#endif
end;

%%% STEADY STATE BLOCK %%%

steady_state_model;
infl=0;
y=ybar;
c=y;
%m=1/((1-bet)*c^(-eta));
m=((alp*c^eta)/(1-bet))^(1/(1-alp));
z=m + 1/(alp*m^(alp-1) - bet*s*c^(-eta));
%s=theta*infl;
e_pc=0;
e_ee=0;
end;

% alternatively, have the SS solved numerically
% !!! to improve !!!

% 1k iteration for searching SS, solving with Sims algo
% steady(maxit=1000, solve_algo=2);


%%% INITVAL BLOCK %%%
% declare initial value for s and then implement
% temporary shock at given period T and 
% permanent shock thorugh endval block
% To isolate effects of peg, all other shocks
% are shut off

initval;
s=1;
end;

//endval;
//s=5;
//end;

%%%% SHOCKS' MOMENTS %%%%
shocks;
var shock_e_ee; 		  stderr .0;
var shock_e_pc; 		  stderr .0;
var e_out;    	 		  stderr .01;
@#if type_taylor == 1
	var shock_pol; 		  stderr .1;
@#endif

% temporary shock at t=50, s jumps at 1 and then back to 0
var s;    periods 50;		values 1.05;

end;

% model status check, Sims algo, higher threshold for Jacobian matrix
%check(solve_algo=2, qz_zero_threshold=1e-10);

%%% SIMULATIONS %%%

simul(periods=100);


% stochastic simulations
//stoch_simul(order=1,			% order of Taylor expansion
//			nocorr,				% do not output correlation matrix
//			solve_algo=2,		% nonlinear solver: 0=fsolve, matlab's own; 1=Dynare's own; 2=Dynare's own but block-recursive; 3=Sim's...
//			irf=20,			% periods to include in IRFs' plots
//			periods=100,		% number of periods to use in the simulations
//			drop=0000,			% burn-in sample
//			replic=00			% number of series to compute IRFs
//			)  y m c infl z;

rplot c;
rplot y;
rplot m;
rplot z;
rplot infl;