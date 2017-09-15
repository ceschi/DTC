% CALVO 2016 - NOMINAL ANCHORING WITH LIQUID MONETARY POLICY ASSETS
%
%
% Code for NKPC with explicit link with TFP shock 
% 
% Specific sticky prices, monopolistic competition, and liquidity
%
% 
% V0.5


var z y m infl s tfp;

predetermined_variables z;

varexo e_ee e_pc e_tfp;

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
;

eta = 1.39;				//riskaversion
bet = .9975;			//discount
theta= 1;				//policy!!!
alphC=3/4;				// Calvo updating
alph = 2/3;				//returns toscale money
rho_tfp=.85;			//shock persistence
epse= 6;				//elasticity of substi
xi=1;					//fisch elasticity
zet=.6;					//returns toscale production
tfpbar=1;



model;

#kappa=(((1-alphC)*(1-bet*alphC)*zet)/(alphC*(zet+epse*(1-zet))))*((1+xi+zet*(eta-1))/zet);
#flex=(xi+1)/(1+xi+zet*(eta-1));

z(+1)=z/(1+infl(+1));

y^(-eta)=y(+1)^(-eta)*bet*((m^(alph-1))/(bet*y(+1)^(-eta)) + 1/(1+infl(+1))) + e_ee;

1/(z-m) - m^(alph-1) = -(bet * y(+1)^(-eta) * s)/(1+infl(+1));

exp(infl)=exp(bet*infl(+1) + kappa*(y - flex*tfp)); // + e_pc;
/* this equation needs fixing possibly */

s=theta*infl(+1);

log(tfp)=(1-rho_tfp)*log(tfpbar) + rho_tfp*log(tfp(-1)) + e_tfp;

end;



steady_state_model;
infl=0;
s=infl;
y=tfpbar;
m=((y^(-eta))/(1-bet))^(1/(1-alph));
z=m + 1/(m^(alph-1) - bet*s*y^(-eta));

end;

shocks;

var e_ee; 	stderr .001;
var e_pc; 	stderr .001;
var e_tfp;	stderr .001;

end;

check;

stoch_simul(order=1, solve_algo=2, irf=30, periods=50000, drop=10000, replic=100) y m infl z;