function [residual, g1, g2] = dtc_full_static(y, x, params)
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

residual = zeros( 8, 1);

%
% Model equations
%

T18 = y(2)^(-params(1))*params(2);
T23 = params(10)*y(3)^(params(10)-1);
T26 = T23/T18+1/(1+y(4));
T83 = params(2)*getPowerDeriv(y(2),(-params(1)),1);
lhs =y(1);
rhs =y(1)/(1+y(4));
residual(1)= lhs-rhs;
lhs =y(2)^(-params(1));
rhs =T18*T26+y(6);
residual(2)= lhs-rhs;
lhs =y(4);
rhs =y(4)*params(5)+params(4)*(y(2)-y(5))+y(7);
residual(3)= lhs-rhs;
lhs =1/(y(1)-y(3))-T23;
rhs =(-(T18*y(8)))/(1+y(4));
residual(4)= lhs-rhs;
lhs =y(5);
rhs =(1-params(6))*params(9)+y(5)*params(6)+x(3);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =y(7)*params(8)+x(2);
residual(6)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(7)+x(1);
residual(7)= lhs-rhs;
lhs =y(8);
rhs =y(4)*params(3)+(y(2)-y(5))*params(11)+y(8)*params(12)+x(4);
residual(8)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(8, 8);

  %
  % Jacobian matrix
  %

  g1(1,1)=1-1/(1+y(4));
  g1(1,4)=(-((-y(1))/((1+y(4))*(1+y(4)))));
  g1(2,2)=getPowerDeriv(y(2),(-params(1)),1)-(T26*T83+T18*(-(T23*T83))/(T18*T18));
  g1(2,3)=(-(T18*params(10)*getPowerDeriv(y(3),params(10)-1,1)/T18));
  g1(2,4)=(-(T18*(-1)/((1+y(4))*(1+y(4)))));
  g1(2,6)=(-1);
  g1(3,2)=(-params(4));
  g1(3,4)=1-params(5);
  g1(3,5)=params(4);
  g1(3,7)=(-1);
  g1(4,1)=(-1)/((y(1)-y(3))*(y(1)-y(3)));
  g1(4,2)=(-((-(y(8)*T83))/(1+y(4))));
  g1(4,3)=1/((y(1)-y(3))*(y(1)-y(3)))-params(10)*getPowerDeriv(y(3),params(10)-1,1);
  g1(4,4)=(-(T18*y(8)/((1+y(4))*(1+y(4)))));
  g1(4,8)=(-((-T18)/(1+y(4))));
  g1(5,5)=1-params(6);
  g1(6,7)=1-params(8);
  g1(7,6)=1-params(7);
  g1(8,2)=(-params(11));
  g1(8,4)=(-params(3));
  g1(8,5)=params(11);
  g1(8,8)=1-params(12);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,64);
end
end
