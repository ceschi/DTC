function x = i_rate(zeta, emme, esse, alp)
% function for extracting spread between 
% policy interest rate and nominal one in the 
% models contained in dtc_full.mod file
% repo: 
x= -(esse.*(zeta - emme).*alp.*emme.^(alp-1))./...
    (1-(zeta - emme).*alp.*emme.^(alp-1));
end