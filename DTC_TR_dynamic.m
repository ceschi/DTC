function [residual, g1, g2, g3] = DTC_TR_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(8, 1);
T21 = y(14)^(-params(1))*params(2);
T26 = 1/y(8)/T21+1/(1+y(15));
T98 = params(2)*getPowerDeriv(y(14),(-params(1)),1);
lhs =y(6);
rhs =y(1)/(1+y(15));
residual(1)= lhs-rhs;
lhs =y(7)^(-params(1));
rhs =T21*T26+y(11);
residual(2)= lhs-rhs;
lhs =y(9);
rhs =y(15)*params(5)+params(4)*(y(7)-y(10))+y(12);
residual(3)= lhs-rhs;
lhs =1/(y(1)-y(8))-1/y(8);
rhs =(-(T21*y(13)))/(1+y(15));
residual(4)= lhs-rhs;
lhs =y(10);
rhs =(1-params(6))*params(9)+params(6)*y(2)+x(it_, 3);
residual(5)= lhs-rhs;
lhs =y(12);
rhs =params(8)*y(4)+x(it_, 2);
residual(6)= lhs-rhs;
lhs =y(11);
rhs =params(7)*y(3)+x(it_, 1);
residual(7)= lhs-rhs;
lhs =y(13);
rhs =y(15)*params(3)+(y(7)-y(10))*params(10)+params(11)*y(5)+x(it_, 4);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 19);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(1/(1+y(15))));
  g1(1,6)=1;
  g1(1,15)=(-((-y(1))/((1+y(15))*(1+y(15)))));
  g1(2,7)=getPowerDeriv(y(7),(-params(1)),1);
  g1(2,14)=(-(T26*T98+T21*(-(1/y(8)*T98))/(T21*T21)));
  g1(2,8)=(-(T21*(-1)/(y(8)*y(8))/T21));
  g1(2,15)=(-(T21*(-1)/((1+y(15))*(1+y(15)))));
  g1(2,11)=(-1);
  g1(3,7)=(-params(4));
  g1(3,9)=1;
  g1(3,15)=(-params(5));
  g1(3,10)=params(4);
  g1(3,12)=(-1);
  g1(4,1)=(-1)/((y(1)-y(8))*(y(1)-y(8)));
  g1(4,14)=(-((-(y(13)*T98))/(1+y(15))));
  g1(4,8)=1/((y(1)-y(8))*(y(1)-y(8)))-(-1)/(y(8)*y(8));
  g1(4,15)=(-(T21*y(13)/((1+y(15))*(1+y(15)))));
  g1(4,13)=(-((-T21)/(1+y(15))));
  g1(5,2)=(-params(6));
  g1(5,10)=1;
  g1(5,18)=(-1);
  g1(6,4)=(-params(8));
  g1(6,12)=1;
  g1(6,17)=(-1);
  g1(7,3)=(-params(7));
  g1(7,11)=1;
  g1(7,16)=(-1);
  g1(8,7)=(-params(10));
  g1(8,15)=(-params(3));
  g1(8,10)=params(10);
  g1(8,5)=(-params(11));
  g1(8,13)=1;
  g1(8,19)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,361);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,6859);
end
end