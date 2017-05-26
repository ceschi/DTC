function [residual, g1, g2] = DTC_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                     columns: variables in declaration order
%                                                     rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 5, 1);

%
% Model equations
%

T38 = params(2)*y(2)^(-params(1));
T48 = 1/(1+y(4))+1/y(3)/T38;
T62 = params(2)*getPowerDeriv(y(2),(-params(1)),1);
lhs =y(1);
rhs =y(1)/(1+y(4));
residual(1)= lhs-rhs;
lhs =y(4);
rhs =y(4)*params(6)+params(4)*(y(5)-y(2))+x(2)+y(4)*.5*params(5);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(3))-1/y(3);
rhs =(-(y(4)*T38*params(3)))/(1+y(4));
residual(3)= lhs-rhs;
lhs =y(2)^(-params(1));
rhs =x(1)+T38*T48;
residual(4)= lhs-rhs;
lhs =log(y(5));
rhs =params(5)*log(y(5))+x(3);
residual(5)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(5, 5);

  %
  % Jacobian matrix
  %

  g1(1,1)=1-1/(1+y(4));
  g1(1,4)=(-((-y(1))/((1+y(4))*(1+y(4)))));
  g1(2,2)=params(4);
  g1(2,4)=1-(params(6)+.5*params(5));
  g1(2,5)=(-params(4));
  g1(3,1)=(-1)/((y(1)-y(3))*(y(1)-y(3)));
  g1(3,2)=(-((-(y(4)*params(3)*T62))/(1+y(4))));
  g1(3,3)=1/((y(1)-y(3))*(y(1)-y(3)))-(-1)/(y(3)*y(3));
  g1(3,4)=(-(((1+y(4))*(-(T38*params(3)))-(-(y(4)*T38*params(3))))/((1+y(4))*(1+y(4)))));
  g1(4,2)=getPowerDeriv(y(2),(-params(1)),1)-(T48*T62+T38*(-(1/y(3)*T62))/(T38*T38));
  g1(4,3)=(-(T38*(-1)/(y(3)*y(3))/T38));
  g1(4,4)=(-(T38*(-1)/((1+y(4))*(1+y(4)))));
  g1(5,5)=1/y(5)-params(5)*1/y(5);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],5,25);
end
end
