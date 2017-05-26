function [residual, g1, g2, g3] = DTC_AR_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(7, 1);
T21 = y(12)^(-params(1))*params(2);
T26 = 1/y(7)/T21+1/(1+y(13));
T86 = params(2)*getPowerDeriv(y(12),(-params(1)),1);
lhs =y(5);
rhs =y(1)/(1+y(13));
residual(1)= lhs-rhs;
lhs =y(6)^(-params(1));
rhs =T21*T26+y(10);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(7))-1/y(7);
rhs =(-(y(13)*T21*params(3)))/(1+y(13));
residual(3)= lhs-rhs;
lhs =y(8);
rhs =y(13)*params(6)+params(4)*(y(6)-y(9))+y(11);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =(1-params(7))*params(10)+params(7)*y(2)+x(it_, 3);
residual(5)= lhs-rhs;
lhs =y(11);
rhs =params(8)*y(4)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =params(9)*y(3)+x(it_, 1);
residual(7)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(7, 16);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(1/(1+y(13))));
  g1(1,5)=1;
  g1(1,13)=(-((-y(1))/((1+y(13))*(1+y(13)))));
  g1(2,6)=getPowerDeriv(y(6),(-params(1)),1);
  g1(2,12)=(-(T26*T86+T21*(-(1/y(7)*T86))/(T21*T21)));
  g1(2,7)=(-(T21*(-1)/(y(7)*y(7))/T21));
  g1(2,13)=(-(T21*(-1)/((1+y(13))*(1+y(13)))));
  g1(2,10)=(-1);
  g1(3,1)=(-1)/((y(1)-y(7))*(y(1)-y(7)));
  g1(3,12)=(-((-(y(13)*params(3)*T86))/(1+y(13))));
  g1(3,7)=1/((y(1)-y(7))*(y(1)-y(7)))-(-1)/(y(7)*y(7));
  g1(3,13)=(-(((1+y(13))*(-(T21*params(3)))-(-(y(13)*T21*params(3))))/((1+y(13))*(1+y(13)))));
  g1(4,6)=(-params(4));
  g1(4,8)=1;
  g1(4,13)=(-params(6));
  g1(4,9)=params(4);
  g1(4,11)=(-1);
  g1(5,2)=(-params(7));
  g1(5,9)=1;
  g1(5,16)=(-1);
  g1(6,4)=(-params(8));
  g1(6,11)=1;
  g1(6,15)=(-1);
  g1(7,3)=(-params(9));
  g1(7,10)=1;
  g1(7,14)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],7,256);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],7,4096);
end
end
