function [residual, g1, g2, g3] = dtcgap_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(6, 1);
kappa__ = (1-params(6))*(1-params(6)*params(2))*params(8)/(params(6)*(params(8)+params(5)*(1-params(8))))*(1+params(7)+params(8)*(params(1)-1))/params(8);
flex__ = (1+params(7))/(1+params(7)+params(8)*(params(1)-1));
T43 = y(5)^(params(4)-1);
T46 = params(2)*y(9)^(-params(1));
lhs =y(3);
rhs =y(1)/(1+y(10));
residual(1)= lhs-rhs;
lhs =y(4)^(-params(1));
rhs =T43+T46/(1+y(10))+x(it_, 1);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(5))-T43;
rhs =(-(T46*y(7)))/(1+y(10));
residual(3)= lhs-rhs;
lhs =y(6);
rhs =params(2)*y(10)+kappa__*(exp(y(4))-exp(flex__*y(8)))+x(it_, 2);
residual(4)= lhs-rhs;
lhs =y(7);
rhs =y(10)*params(3);
residual(5)= lhs-rhs;
lhs =y(8);
rhs =(1-params(9))*params(10)+params(9)*y(2)+x(it_, 3);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 13);

  %
  % Jacobian matrix
  %

T102 = params(2)*getPowerDeriv(y(9),(-params(1)),1);
T109 = getPowerDeriv(y(5),params(4)-1,1);
  g1(1,1)=(-(1/(1+y(10))));
  g1(1,3)=1;
  g1(1,10)=(-((-y(1))/((1+y(10))*(1+y(10)))));
  g1(2,4)=getPowerDeriv(y(4),(-params(1)),1);
  g1(2,9)=(-(T102/(1+y(10))));
  g1(2,5)=(-T109);
  g1(2,10)=(-((-T46)/((1+y(10))*(1+y(10)))));
  g1(2,11)=(-1);
  g1(3,1)=(-1)/((y(1)-y(5))*(y(1)-y(5)));
  g1(3,9)=(-((-(y(7)*T102))/(1+y(10))));
  g1(3,5)=1/((y(1)-y(5))*(y(1)-y(5)))-T109;
  g1(3,10)=(-(T46*y(7)/((1+y(10))*(1+y(10)))));
  g1(3,7)=(-((-T46)/(1+y(10))));
  g1(4,4)=(-(kappa__*exp(y(4))));
  g1(4,6)=1;
  g1(4,10)=(-params(2));
  g1(4,8)=(-(kappa__*(-(flex__*exp(flex__*y(8))))));
  g1(4,12)=(-1);
  g1(5,10)=(-params(3));
  g1(5,7)=1;
  g1(6,2)=(-params(9));
  g1(6,8)=1;
  g1(6,13)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,169);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,2197);
end
end
end
end
