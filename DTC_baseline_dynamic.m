function [residual, g1, g2, g3] = DTC_baseline_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(5, 1);
T21 = y(8)^(-params(1))*params(2);
T66 = 1/(1+y(9))+1/y(2)/T21;
T85 = params(2)*getPowerDeriv(y(8),(-params(1)),1);
lhs =y(4);
rhs =y(1)/(1+y(9));
residual(1)= lhs-rhs;
lhs =y(5)^(-params(1));
rhs =x(it_, 1)+T21*T66;
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(2))-1/y(2);
rhs =(-(y(9)*T21*params(3)))/(1+y(9));
residual(3)= lhs-rhs;
lhs =y(6);
rhs =x(it_, 2)+y(9)*params(6)+params(4)*(y(5)-y(7));
residual(4)= lhs-rhs;
lhs =log(y(7));
rhs =params(7)*log(y(3))+x(it_, 3);
residual(5)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(5, 12);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(1/(1+y(9))));
  g1(1,4)=1;
  g1(1,9)=(-((-y(1))/((1+y(9))*(1+y(9)))));
  g1(2,5)=getPowerDeriv(y(5),(-params(1)),1);
  g1(2,8)=(-(T66*T85+T21*(-(1/y(2)*T85))/(T21*T21)));
  g1(2,2)=(-(T21*(-1)/(y(2)*y(2))/T21));
  g1(2,9)=(-(T21*(-1)/((1+y(9))*(1+y(9)))));
  g1(2,10)=(-1);
  g1(3,1)=(-1)/((y(1)-y(2))*(y(1)-y(2)));
  g1(3,8)=(-((-(y(9)*params(3)*T85))/(1+y(9))));
  g1(3,2)=1/((y(1)-y(2))*(y(1)-y(2)))-(-1)/(y(2)*y(2));
  g1(3,9)=(-(((1+y(9))*(-(T21*params(3)))-(-(y(9)*T21*params(3))))/((1+y(9))*(1+y(9)))));
  g1(4,5)=(-params(4));
  g1(4,6)=1;
  g1(4,9)=(-params(6));
  g1(4,7)=params(4);
  g1(4,11)=(-1);
  g1(5,3)=(-(params(7)*1/y(3)));
  g1(5,7)=1/y(7);
  g1(5,12)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],5,144);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],5,1728);
end
end
