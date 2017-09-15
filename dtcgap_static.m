function [residual, g1, g2] = dtcgap_static(y, x, params)
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

residual = zeros( 6, 1);

%
% Model equations
%

kappa__ = (1-params(6))*(1-params(6)*params(2))*params(8)/(params(6)*(params(8)+params(5)*(1-params(8))))*(1+params(7)+params(8)*(params(1)-1))/params(8);
flex__ = (1+params(7))/(1+params(7)+params(8)*(params(1)-1));
T39 = params(2)*y(2)^(-params(1));
T43 = y(3)^(params(4)-1);
T46 = T43/T39+1/(1+y(4));
T88 = params(2)*getPowerDeriv(y(2),(-params(1)),1);
lhs =y(1);
rhs =y(1)/(1+y(4));
residual(1)= lhs-rhs;
lhs =y(2)^(-params(1));
rhs =T39*T46+x(1);
residual(2)= lhs-rhs;
lhs =1/(y(1)-y(3))-T43;
rhs =(-(T39*y(5)))/(1+y(4));
residual(3)= lhs-rhs;
lhs =exp(y(4));
rhs =exp(params(2)*y(4)+kappa__*(y(2)-flex__*y(6)));
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(4)*params(3);
residual(5)= lhs-rhs;
lhs =log(y(6));
rhs =(1-params(9))*log(params(10))+log(y(6))*params(9)+x(3);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

  %
  % Jacobian matrix
  %

  g1(1,1)=1-1/(1+y(4));
  g1(1,4)=(-((-y(1))/((1+y(4))*(1+y(4)))));
  g1(2,2)=getPowerDeriv(y(2),(-params(1)),1)-(T46*T88+T39*(-(T43*T88))/(T39*T39));
  g1(2,3)=(-(T39*getPowerDeriv(y(3),params(4)-1,1)/T39));
  g1(2,4)=(-(T39*(-1)/((1+y(4))*(1+y(4)))));
  g1(3,1)=(-1)/((y(1)-y(3))*(y(1)-y(3)));
  g1(3,2)=(-((-(y(5)*T88))/(1+y(4))));
  g1(3,3)=1/((y(1)-y(3))*(y(1)-y(3)))-getPowerDeriv(y(3),params(4)-1,1);
  g1(3,4)=(-(T39*y(5)/((1+y(4))*(1+y(4)))));
  g1(3,5)=(-((-T39)/(1+y(4))));
  g1(4,2)=(-(kappa__*exp(params(2)*y(4)+kappa__*(y(2)-flex__*y(6)))));
  g1(4,4)=exp(y(4))-params(2)*exp(params(2)*y(4)+kappa__*(y(2)-flex__*y(6)));
  g1(4,6)=(-(exp(params(2)*y(4)+kappa__*(y(2)-flex__*y(6)))*kappa__*(-flex__)));
  g1(5,4)=(-params(3));
  g1(5,5)=1;
  g1(6,6)=1/y(6)-params(9)*1/y(6);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,36);
end
end
