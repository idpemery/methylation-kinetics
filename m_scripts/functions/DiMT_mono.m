function mono_params_fcn = DiMT_mono(params, t)
%
%% CORRESPONDS TO EQUATION 9
%
% This function describes the pseudo-first order kinetics
%   of the monomethyl step by a dimethyltransferase
%
% C1, C2, C3, and C4 are scaling/offset factors (they are NOT all used
%     in this function) and k1 and k2 are the mono- and di-monomethyl
%     rate constants, respectively
%
% NB: this function works alongside "DiMT_di.m"
%
% k1 = params(1)
% k2 = params(2)
% C1 = params(3)
% C2 = params(4)
% C3 = params(5)
% C4 = params(6)

mono_params_fcn = params(4) + (params(3) .* (((params(1).*exp(-params(2)*t))/(params(1) - params(2)) - (params(1).*exp(params(2)*t - params(1)*t).*exp(-params(2)*t))/(params(1) - params(2)))));

end
