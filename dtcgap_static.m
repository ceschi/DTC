function [residual, g1, g2, g3] = dtcgap_static(y, x, params)
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
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 6, 1);

%
% Model equations
%

kappa__ = (1-params(6))*(1-params(6)*params(2))*params(8)/(params(6)*(params(8)+params(5)*(1-params(8))))*(1+params(7)+params(8)*(params(1)-1))/params(8);
flex__ = (1+params(7))/(1+params(7)+params(8)*(params(1)-1));
T38 = y(2)^(-params(1));
T42 = y(3)^(params(4)-1);
lhs =y(1);
rhs =y(1)/(1+y(4));
residual(1)= lhs-rhs;
lhs =T38;
rhs =T42+params(2)*T38/(1+y(4))+x(1);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(3))-T42;
rhs =(-(params(2)*T38*y(5)))/(1+y(4));
residual(3)= lhs-rhs;
lhs =y(4);
rhs =params(2)*y(4)+kappa__*(exp(y(2))-exp(flex__*y(6)))+x(2);
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(4)*params(3);
residual(5)= lhs-rhs;
lhs =y(6);
rhs =(1-params(9))*params(10)+y(6)*params(9)+x(3);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

  %
  % Jacobian matrix
  %

T86 = getPowerDeriv(y(2),(-params(1)),1);
T96 = getPowerDeriv(y(3),params(4)-1,1);
  g1(1,1)=1-1/(1+y(4));
  g1(1,4)=(-((-y(1))/((1+y(4))*(1+y(4)))));
  g1(2,2)=T86-params(2)*T86/(1+y(4));
  g1(2,3)=(-T96);
  g1(2,4)=(-((-(params(2)*T38))/((1+y(4))*(1+y(4)))));
  g1(3,1)=(-1)/((y(1)-y(3))*(y(1)-y(3)));
  g1(3,2)=(-((-(y(5)*params(2)*T86))/(1+y(4))));
  g1(3,3)=1/((y(1)-y(3))*(y(1)-y(3)))-T96;
  g1(3,4)=(-(params(2)*T38*y(5)/((1+y(4))*(1+y(4)))));
  g1(3,5)=(-((-(params(2)*T38))/(1+y(4))));
  g1(4,2)=(-(kappa__*exp(y(2))));
  g1(4,4)=1-params(2);
  g1(4,6)=(-(kappa__*(-(flex__*exp(flex__*y(6))))));
  g1(5,4)=(-params(3));
  g1(5,5)=1;
  g1(6,6)=1-params(9);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,36);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,216);
end
end
end
end
