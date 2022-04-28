function di_fit_fcn = TriMT_di(params, t)
%
%% CORRESPONDS TO EQUATION 17
%
% This function describes the pseudo-first order kinetics
%   of the dimethyl step by a trimethyltransferase
%
% C1, C2, C3, C4, C5, and C6 are scaling/offset factors (they are NOT all used
%     in this function) and k1, k2, and k3 are the mono-, di-, and tri-methyl
%     rate constants, respectively
%
% NB: this function works alongside "TriMT_mono.m" and "TriMT_tri.m"
%
% k1 = params(1)
% k2 = params(2)
% C1 = params(3)
% C2 = params(4)
% k3 = params(5)
% C3 = params(6)
% C4 = params(7)
% C5 = params(8)
% C6 = params(9)

di_fit_fcn = params(6) + (params(9) + ((exp(-params(5)*t).*((params(1)*params(2).*exp(params(5)*t - params(1)*t))./(params(1) - params(5)) - (params(1)*params(2).*exp(params(5)*t - params(2)*t))/(params(2) - params(5))))./(params(1) - params(2)) + (params(1)*params(2).*exp(-params(5)*t))./(params(1)*params(2) - params(1)*params(5) - params(2)*params(5) + params(5).^2)));

end
