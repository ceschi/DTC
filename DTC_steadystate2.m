function [ys_, params, info] = DTC_steadystate2(ys_, exo_, params)
% Steady state generated by Dynare preprocessor
    info = 0;
    ys_(4)=0;
    ys_(5)=1;
    ys_(2)=ys_(5);
    ys_(3)=1/((1-params(2))*ys_(2)^(-params(1)));
    ys_(1)=2*ys_(3);
    % Auxiliary equations
    check_=0;
end
