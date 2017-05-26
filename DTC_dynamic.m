function [residual, g1, g2, g3] = DTC_dynamic(y, x, params, steady_state, it_)
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
T42 = params(2)*y(9)^(-params(1));
T74 = 1/(1+y(10))+1/y(2)/T42;
T84 = params(2)*getPowerDeriv(y(9),(-params(1)),1);
lhs =y(5);
rhs =y(1)/(1+y(10));
residual(1)= lhs-rhs;
lhs =y(7);
rhs =y(10)*params(6)+params(4)*(y(8)-y(6))+x(it_, 2)+.5*params(5)*y(3);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(2))-1/y(2);
rhs =(-(y(10)*T42*params(3)))/(1+y(10));
residual(3)= lhs-rhs;
lhs =y(6)^(-params(1));
rhs =x(it_, 1)+T42*T74;
residual(4)= lhs-rhs;
lhs =log(y(8));
rhs =params(5)*log(y(4))+x(it_, 3);
residual(5)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(5, 13);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(1/(1+y(10))));
  g1(1,5)=1;
  g1(1,10)=(-((-y(1))/((1+y(10))*(1+y(10)))));
  g1(2,6)=params(4);
  g1(2,3)=(-(.5*params(5)));
  g1(2,7)=1;
  g1(2,10)=(-params(6));
  g1(2,8)=(-params(4));
  g1(2,12)=(-1);
  g1(3,1)=(-1)/((y(1)-y(2))*(y(1)-y(2)));
  g1(3,9)=(-((-(y(10)*params(3)*T84))/(1+y(10))));
  g1(3,2)=1/((y(1)-y(2))*(y(1)-y(2)))-(-1)/(y(2)*y(2));
  g1(3,10)=(-(((1+y(10))*(-(T42*params(3)))-(-(y(10)*T42*params(3))))/((1+y(10))*(1+y(10)))));
  g1(4,6)=getPowerDeriv(y(6),(-params(1)),1);
  g1(4,9)=(-(T74*T84+T42*(-(1/y(2)*T84))/(T42*T42)));
  g1(4,2)=(-(T42*(-1)/(y(2)*y(2))/T42));
  g1(4,10)=(-(T42*(-1)/((1+y(10))*(1+y(10)))));
  g1(4,11)=(-1);
  g1(5,4)=(-(params(5)*1/y(4)));
  g1(5,8)=1/y(8);
  g1(5,13)=(-1);
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],5,169);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],5,2197);
end
end
