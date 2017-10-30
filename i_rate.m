function x = i_rate(zeta, emme, esse, alph)
% function for extracting spread between 
% policy interest rate and nominal one in the 
% models contained in dtc_full.mod file
% repo: 
x= -(esse.*(zeta - emme).*alph.*emme.^(alph-1))./...
    (1-(zeta - emme).*alph.*emme.^(alph-1));
end