function [residual, g1, g2, g3] = dtclin_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(8, 1);
kappa__ = (1-params(6))*(1-params(6)*params(2))*params(8)/(params(6)*(params(8)+params(5)*(1-params(8))))*(1+params(7)+params(8)*(params(1)-1))/params(8);
flex__ = (1+params(7))/(1+params(7)+params(8)*(params(1)-1));
mbar__ = (flex__^params(1)/(1-params(2)))^(1/(1-params(4)));
dbar__ = mbar__^((params(4)-params(11))/(1-params(11)));
zbar__ = mbar__+mbar__^((1-params(4))/(1-params(11)));
T66 = (1-params(4))/mbar__^2;
T72 = params(2)*flex__^(-params(1))*mbar__^(1-params(4));
lhs =y(4);
rhs =y(1)-y(13);
residual(1)= lhs-rhs;
lhs =y(5);
rhs =(1-params(4))/params(1)*y(6)+y(12)+y(13)*1/params(1)+x(it_, 1);
residual(2)= lhs-rhs;
residual(3) = y(6)*T66+T72*y(8)-(1-params(11))*(y(1)+dbar__*(y(1)-y(6)));
lhs =y(7);
rhs =params(2)*y(13)+kappa__*(y(5)-flex__*y(9))+x(it_, 2);
residual(4)= lhs-rhs;
lhs =y(8);
rhs =y(13)*params(3)+y(10);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =(1-params(9))*params(10)+params(9)*y(2)+x(it_, 3);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =params(12)*y(3)+x(it_, 4);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =zbar__/(zbar__-mbar__)*y(1)-y(6)*mbar__/(zbar__-mbar__);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 17);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-1);
  g1(1,4)=1;
  g1(1,13)=1;
  g1(2,5)=1;
  g1(2,12)=(-1);
  g1(2,6)=(-((1-params(4))/params(1)));
  g1(2,13)=(-(1/params(1)));
  g1(2,14)=(-1);
  g1(3,1)=(-((1-params(11))*(1+dbar__)));
  g1(3,6)=T66-(1-params(11))*(-dbar__);
  g1(3,8)=T72;
  g1(4,5)=(-kappa__);
  g1(4,7)=1;
  g1(4,13)=(-params(2));
  g1(4,9)=(-(kappa__*(-flex__)));
  g1(4,15)=(-1);
  g1(5,13)=(-params(3));
  g1(5,8)=1;
  g1(5,10)=(-1);
  g1(6,2)=(-params(9));
  g1(6,9)=1;
  g1(6,16)=(-1);
  g1(7,3)=(-params(12));
  g1(7,10)=1;
  g1(7,17)=(-1);
  g1(8,1)=(-(zbar__/(zbar__-mbar__)));
  g1(8,6)=mbar__/(zbar__-mbar__);
  g1(8,11)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,289);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,4913);
end
end
end
end
