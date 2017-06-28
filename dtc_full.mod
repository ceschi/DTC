% CALVO 2016 - NOMINAL ANCHORING WITH LIQUID MONETARY POLICY ASSETS
%
%
% Discrete time version of the model augmented with
% - explicit output gap
% - implicitly defined money demand
% - AR shocks 
% - options for Taylor Rule
% 
% V0.4.6

@#define flag_taylor = 1
% defines a macro-variable to select among 
% different specification of the TR: 
%  - 0 for standard model 
%  - 1 for model with output gap in the TR
%  - 2 for model with interest rate peg w\ temp shock
%  - 3 for model with interest rate peg w\ perm shock

@#define flag_start = 0
% relevant only for flag_taylor = 3, it
% stts some minor details of the 
% deterministic simulations
%  - 0 starting point is selected automatically by Dynare
%  - 1 system is initialised at SS values

%%% VARIABLES DECLARATION %%%

% endogeneous variables
var z				%${z}$						(longname='total liquidity')
	c 	 			%${c}$						(longname='consumption')
	m 				%${m}$						(longname='money')
	infl			%${\pi}$					(longname='inflation')
	y			    %${y}$						(longname='output')
	e_ee			%${\varepsilon^{EE}}$		(longname='Euler eqn shock')
	e_pc			%${\varepsilon^{PS}}$		(longname='Phillips curve shock')

	@#if flag_taylor == 0
		s 				%${s}$						(longname='Liquid bond yield and policy tool')
	@#endif

	@#if flag_taylor == 1
		s 				%${s}$						(longname='Liquid bond yield and policy tool')
	@#endif	
;

predetermined_variables z;
% declares predetermined (state) variables

% exogeneous variables
varexo shock_e_ee	%${\nu^{EE}}$				(longname='EE AR shock')
	   shock_e_pc	%${\nu^{PC}}$				(longname='PC AR shock')
	   e_out		%${\nu^{y}}$					(longname='output shock')
	@#if flag_taylor == 1
	   		shock_pol	%${\nu^{pol}}$				(longname='Shock to monpol rule on ')
	@#endif

	@#if flag_taylor == 2
			s 			%${s}$						(longname='Int. rate peg level')
	@#endif

	@#if flag_taylor == 3
			s 			%${s}$						(longname='Int. rate peg level')
	@#endif
;

/* % consider including varexo_det for models 2 & 3, check
   % dynare guide for more information -- end of pg 11
*/



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
		   alp			%${\alpha}$					(longname='Exponent for money utility function')
	@#if flag_taylor == 1
		   		omega		%${\omega}$				(longname='TR real part when flag_taylor=1')
		   		rho 		%${\rho_{\pi}}$			(longname='policy rate smoothing when flag_taylor=1')
	@#endif
;

% Parametrization/calibration
% core invariant parameters
eta =	1.39;
bet =	0.975;
mu =	0.93;
alp =	0.33;

% optional parameters
@#if flag_taylor == 1
	omega =  .75;
	rho =	 .5;
@#endif

chi = 	 .995;
ybar=	1;

% persistence for AR shock processes
% setting these to 0 reproduces original model
rho_ee_s =	0;%.95;
rho_pc_s =	0;%.85;


% tuning parameters
sigm	=  1.5; 
theta	=  1.5;



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
	@#if flag_taylor == 0
		s=theta*infl(+1);
		%/*  policy rule as specified in the paper */ 
	@#endif

	@#if flag_taylor == 1
    	%/*  !!! -- EXPERIMENT & TUNING HERE -- !!! */
		s=theta*infl(+1) + omega * (c-y) + rho * s(-1) + shock_pol;
		%/*  policy rule as specified in the paper  */ 
	@#endif

end;



%%% STEADY STATE BLOCK %%%

steady_state_model;
infl=0;
y=ybar;
c=y;
m=((alp*c^(-eta))/(1-bet))^(1/(1-alp));

	@#if flag_taylor == 0
		s=theta*infl;
	@#endif

	@#if flag_taylor == 1
		s=theta*infl;
	@#endif

z=m + 1/(alp*m^(alp-1) - bet*s*c^(-eta));
e_pc=0;
e_ee=0;
end;



% alternatively, have the SS solved numerically
% !!! to improve !!!
% 1k iteration for searching SS, solving with Sims algo
/*
steady(maxit=1000, solve_algo=2);
*/



%%% INITVAL BLOCK %%%
% declare initial value for s and then implement
% temporary shock at given period T and 
% permanent shock through endval block
% To isolate effects of peg, all other shocks
% ought to be shut off

	@#if flag_taylor == 2
		initval;
		s=1;
		/* % Candidate values for initialisation
		   % coming from end values of free 
		   % simulations 
		*/
		y = 	1;
		c = 	1;
		z = 	45.9907361974626;
		m = 	47.0433677764099;
		infl = 	0;
		end;
	@#endif

	@#if flag_taylor == 3
		@#if flag_start == 0
			initval;
			s=1.00;
		@#endif

		@#if flag_start == 1
			/* 
			% Candidate values for initialisation:
			% interestingly, if the system is at SS
			% before the beginning of the simulations
			% it behaves slightly differently
			*/
			initval;
			s = 	1;
			y = 	1;
			c = 	1;
			z = 	46.0421162119544;
			m = 	47.0433677764099;
			infl = 	0;
		@#endif

			end;


			endval;
			s=1.05;
			end;
	@#endif



%%%% SHOCKS' MOMENTS %%%%
shocks;
	@#if flag_taylor == 0
		var shock_e_ee; 		  stderr .1;
		var shock_e_pc; 		  stderr .1;
		var e_out;    	 		  stderr .001;
	@#endif

	@#if flag_taylor == 1
		var shock_e_ee; 		  stderr .01;
		var shock_e_pc; 		  stderr .1;
		var e_out;    	 		  stderr .001;
		var shock_pol; 		  	  stderr .01;
	@#endif

	@#if flag_taylor == 2
		var s;    
		periods 50;		
		values 1.05;
		%/* 5% temporary shock at t=50 */
	@#endif

	@#if flag_taylor == 3
		var s;
		periods 0:50;
		values (repmat(1,51,1));
		%/* keeps s at 1 until t=50, then permanent increase of 5% */
	@#endif
end;



/*
% model status check, Sims algo, lower threshold for Jacobian matrix,
% display results: BK condition, autocorr, etc
check(
	solve_algo=2, 
	qz_zero_threshold=1e-10);
*/



%%% SIMULATIONS %%%

%/* stochastic simulations */
	@#if flag_taylor == 0
		stoch_simul(order=1,			% order of Taylor expansion
					%nocorr,				% do not output correlation matrix
					solve_algo=2,		% nonlinear solver: 0=fsolve, matlab's own; 1=Dynare's own; 2=Dynare's own but block-recursive; 3=Sim's...
					irf=30,				% periods to include in IRFs' plots
					periods=50000,		% number of periods to use in the simulations
					drop=10000,			% burn-in sample
					replic=100			% number of series to compute IRFs
					)  y m c infl z;
		dynasave (model_0_sims) y m c infl z;
	@#endif

	@#if flag_taylor == 1
		stoch_simul(order=1,			% order of Taylor expansion
					%nocorr,				% do not output correlation matrix
					solve_algo=2,		% nonlinear solver: 0=fsolve, matlab's own; 1=Dynare's own; 2=Dynare's own but block-recursive; 3=Sim's...
					irf=30,				% periods to include in IRFs' plots
					periods=50000,		% number of periods to use in the simulations
					drop=10000,			% burn-in sample
					replic=100			% number of series to compute IRFs
					)  y m c infl z;
		dynasave (model_1_sims) y m c infl z;
	@#endif

%/* deterministic simulations */
	@#if flag_taylor == 2
		simul(periods=100);				% 100 periods are simulated deterministically
		rplot c;
		rplot y;
		rplot m;
		rplot z;
		rplot infl;
		dynasave (model_2_sims) y m c infl z;
	@#endif

	@#if flag_taylor == 3
		simul(periods=100);				% 100 periods are simulated deterministically
		rplot c;						% c y m z infl paths are printed
		rplot y;
		rplot m;
		rplot z;
		rplot infl;
		dynasave (model_3_sims) y m c infl z;
	@#endif



%%%%  LaTeX outputting  %%%
/*
write_latex_parameter_table;
write_latex_dynamic_model;
write_latex_static_model;
collect_latex_files; 
*/