function [residual, g1, g2, g3] = dtcgap_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [M_.exo_nbr by nperiods] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
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
T42 = params(2)*y(9)^(-params(1));
T46 = y(5)^(params(4)-1);
T49 = T46/T42+1/(1+y(10));
T104 = params(2)*getPowerDeriv(y(9),(-params(1)),1);
lhs =y(3);
rhs =y(1)/(1+y(10));
residual(1)= lhs-rhs;
lhs =y(4)^(-params(1));
rhs =T42*T49+x(it_, 1);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(5))-T46;
rhs =(-(T42*y(7)))/(1+y(10));
residual(3)= lhs-rhs;
lhs =exp(y(6));
rhs =exp(params(2)*y(10)+kappa__*(y(4)-flex__*y(8)));
residual(4)= lhs-rhs;
lhs =y(7);
rhs =y(10)*params(3);
residual(5)= lhs-rhs;
lhs =log(y(8));
rhs =(1-params(9))*log(params(10))+params(9)*log(y(2))+x(it_, 3);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 13);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(1/(1+y(10))));
  g1(1,3)=1;
  g1(1,10)=(-((-y(1))/((1+y(10))*(1+y(10)))));
  g1(2,4)=getPowerDeriv(y(4),(-params(1)),1);
  g1(2,9)=(-(T49*T104+T42*(-(T46*T104))/(T42*T42)));
  g1(2,5)=(-(T42*getPowerDeriv(y(5),params(4)-1,1)/T42));
  g1(2,10)=(-(T42*(-1)/((1+y(10))*(1+y(10)))));
  g1(2,11)=(-1);
  g1(3,1)=(-1)/((y(1)-y(5))*(y(1)-y(5)));
  g1(3,9)=(-((-(y(7)*T104))/(1+y(10))));
  g1(3,5)=1/((y(1)-y(5))*(y(1)-y(5)))-getPowerDeriv(y(5),params(4)-1,1);
  g1(3,10)=(-(T42*y(7)/((1+y(10))*(1+y(10)))));
  g1(3,7)=(-((-T42)/(1+y(10))));
  g1(4,4)=(-(kappa__*exp(params(2)*y(10)+kappa__*(y(4)-flex__*y(8)))));
  g1(4,6)=exp(y(6));
  g1(4,10)=(-(params(2)*exp(params(2)*y(10)+kappa__*(y(4)-flex__*y(8)))));
  g1(4,8)=(-(exp(params(2)*y(10)+kappa__*(y(4)-flex__*y(8)))*kappa__*(-flex__)));
  g1(5,10)=(-params(3));
  g1(5,7)=1;
  g1(6,2)=(-(params(9)*1/y(2)));
  g1(6,8)=1/y(8);
  g1(6,13)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,169);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,2197);
end
end
