function x = i_rate(zeta, emme, esse, alph, gammma)
% function for extracting spread between 
% policy interest rate and nominal one in the 
% models contained in dtc_full.mod file
% repo: 
x= esse.*(((exp(zeta) - exp(emme)).^(1-gammma))./...
    ((exp(zeta) - exp(emme)).^(1-gammma) - exp(emme).^(1-alph)));
    
end