% Code for NKPC with TFP shock 
% 
% Specific sticky prices, monopolistic competition, and liquidity
%
% 
% V0.6

%%%% Flags for conditional vars %%%%

@#define calibras = 1
% defines a macro-variable to select among 
% different specification of the TR: 
%  - 0 for standard model with TP
%  - 1 for model violating TP


%%%%% Variables declaration %%%%%

% full set of vars
var z y m infl s tfp e_mp b;

% declaring state variables
predetermined_variables z;

% exogenous variables
varexo e_ee e_pc e_tfp e_e_mp;

% Parameters of the model,
% to map into standard params
parameters	eta
			bet
			theta
			alph
			epse
			alphC
			xi
			zet
			rho_tfp
			tfpbar
			gammma
			rho_mp
;

%%%%% Calibration %%%%

%%%% core invariant params

% Relative risk aversion
eta = 5;
% Discount factor
bet = .975;
% intratemporal elasticity of subs
epse = 6;
% calvo price updating
alphC = .75;
% SS tfp
tfpbar = 1;
% returns to scale in goods production
zet = .6;
% Frisch elasticity
xi = 1;


%%%% persistences parameters

% Mon Pol shocks persistence
rho_mp = .65;
% TFP persistence
rho_tfp = .5;

%%%% fine tuning parameters
% part to outsource in other files

% Mon Pol reaction
	theta = 1.8;

% exp on bonds, must be lower than money!
gammma = .02;
% exp on money
alph = .05;


%%%%% Linearised Model Declaration %%%%%

model(linear);

% shorthand for linearised parameters
#kappa=(((1-alphC)*(1-bet*alphC)*zet)/(alphC*(zet+epse*(1-zet))))*((1+xi+zet*(eta-1))/zet);
#flex=(xi+1)/(1+xi+zet*(eta-1));
#mbar= ((flex^eta)/(1-bet))^(1/(1-alph));
#dbar= mbar^((alph-gammma)/(1-gammma));
#zbar=mbar + mbar^((1-alph)/(1-gammma));

% real liquidity evolution
z(+1) = z - infl(+1);

% euler eq / is curve
y = ((1-alph)/eta)*m + y(+1) +(1/eta)*infl(+1)+ e_ee;

% mon demand - implicit
((1-alph)/mbar^2)*m + (bet*(flex^(-eta))*mbar^(1-alph))*s - (1-gammma)*(z + (z-m)*dbar)=0;

% bond share in total liquidity
b = (zbar/(zbar-mbar))*z - (mbar/(zbar-mbar))*m;

% Phillips curve loglin'd
infl=bet*infl(+1) + kappa*(y - flex*tfp)+ e_pc;

% Monetary policy rule
s=theta*infl(+1) + e_mp;

% AR for technology
tfp=(1-rho_tfp)*tfpbar + rho_tfp*tfp(-1) + e_tfp;

% AR for Mon Pol shocks
e_mp=rho_mp*e_mp(-1) + e_e_mp;

end;


%%%%% Shocks declaration %%%%

shocks;

% Euler eq shock, off
var e_ee; 	stderr .000;

% Phillips curve shock,off
var e_pc; 	stderr .000;

% TFP shock
var e_tfp;	stderr 1;

% Mon Pol shock, 1% shock annualised (model in quarters)
var e_e_mp; 	stderr 0.25^2;

end;

%%%% Model simulations and IRFs %%%%%
check;

stoch_simul(order=1, 		% approx order			
			solve_algo=2, 	% solving algorithm			
			irf=30,			% IRFs horizon			
			periods=500000, % iterations to simulate
			drop=100000, 	% burn-in drop			
			replic=250)		% IRF iterations
			y m infl z b;   % vars to plot


/*
%%%%  Matlab commands  %%%%
verbatim;
min(m); % to verify whether m takes negative values
min(z); % to verify whether z takes negative values
nomin=i_rate(z, m, s, alph, gammma);
r_int=nomin - infl;
corr(nomin, infl)

figure('Name', 'Nominal interest rate');
plot(nomin((end-300):end));

figure('Name', 'Real interest rate');
plot(r_int((end-300):end));


%/* COMMENTS
%- the magnitude of m and z coefficients is disproportionate
%  it is sufficient to introduce b to appreciate this effect

%- should revise thoroughly the loglinearisation part to check whether some
%   parameter is ill-placed

%- code should get more elegant and complete, wrt dtc_full.mod

   @#if strict_targeting == 1
        @# include "strict_targeting_parameters.mod"
    @#else
        @# include "flexible_targeting_parameters.mod"
    @#endif
*/