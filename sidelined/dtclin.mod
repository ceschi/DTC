% Code for NKPC with TFP shock 
% 
% Specific sticky prices, monopolistic competition, and liquidity
%
% 
% V0.5


var z y m infl s tfp e_mp b;

predetermined_variables z;

varexo e_ee e_pc e_tfp e_e_mp;

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

eta = 5;				//riskaversion
bet = .975;			//discount
theta= 1.8;				//POLICY!!!
alphC=3/4;				// Calvo updating
alph = .05;				//returns toscale money
rho_tfp=.5;			//shock persistence
epse= 6;				//elasticity of substi
xi=1;					//fisch elasticity
zet=.6;					//returns toscale production
tfpbar=1;
gammma=.02;				//returns toscale bonds
rho_mp=.65;				// persistence of monpol shocks



model(linear);

#kappa=(((1-alphC)*(1-bet*alphC)*zet)/(alphC*(zet+epse*(1-zet))))*((1+xi+zet*(eta-1))/zet);
#flex=(xi+1)/(1+xi+zet*(eta-1));
#mbar= ((flex^eta)/(1-bet))^(1/(1-alph));
#dbar= mbar^((alph-gammma)/(1-gammma));
#zbar=mbar + mbar^((1-alph)/(1-gammma));

z(+1) = z - infl(+1);
% liquidity ev.

y = ((1-alph)/eta)*m + y(+1) +(1/eta)*infl(+1)+ e_ee;
% euler eq / is curve

((1-alph)/mbar^2)*m + (bet*(flex^(-eta))*mbar^(1-alph))*s - (1-gammma)*(z + (z-m)*dbar)=0;
% mon demand - implicit

infl=bet*infl(+1) + kappa*(y - flex*tfp)+ e_pc;
% Phillips curve loglin'd

s=theta*infl(+1) + e_mp;
% policy 

tfp=(1-rho_tfp)*tfpbar + rho_tfp*tfp(-1) + e_tfp;

e_mp=rho_mp*e_mp(-1) + e_e_mp;

b = (zbar/(zbar-mbar))*z - (mbar/(zbar-mbar))*m;

end;



shocks;

var e_ee; 	stderr .000;
var e_pc; 	stderr .000;
var e_tfp;	stderr 1;
var e_e_mp; 	stderr 1;

end;

check;

stoch_simul(order=1, solve_algo=2, irf=30, periods=500000, drop=100000, replic=100) y m infl z b;


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


%*/

