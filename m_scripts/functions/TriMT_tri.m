function tri_fit_fcn = TriMT_tri(params, t)
%
%% CORRESPONDS TO EQUATION 18
%
% This function describes the pseudo-first order kinetics
%   of the trimethyl step by a trimethyltransferase
%
% C1, C2, C3, C4, C5, and C6 are scaling/offset factors (they are NOT all used
%     in this function) and k1, k2, and k3 are the mono-, di-, and tri-methyl
%     rate constants, respectively
%
% NB: this function works alongside "TriMT_mono.m" and "TriMT_di.m"
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

tri_fit_fcn = params(8) + ((params(7) .* ((params(1).*params(2).^2.*exp(-params(3)*t))./((params(1) - params(2)).*(params(1) - params(3)).*(params(2) - params(3))) - (params(1) .* params(3)^2 .* exp(-params(2) * t)) ./ ((params(1) - params(2)) .* (params(1) - params(3)) .* (params(2) - params(3))) + (params(2) .* params(3)^2 .* exp(-params(1) * t)) ./ ((params(1) - params(2)) .* (params(1) - params(3)) .* (params(2) - params(3))) - (params(1) .^ 2 .* params(2) .* exp(-params(3) * t)) ./ ((params(1) - params(2)) .* (params(1) - params(3)) .* (params(2) - params(3))) + (params(1) .^2 .* params(3) .* exp(-params(2) * t)) ./ ((params(1) - params(2)) .* (params(1) - params(3)) .* (params(2) - params(3))) - (params(2) .^2 .* params(3) .* exp(-params(1) * t)) ./ ((params(1) - params(2)) .* (params(1) - params(3)) .* (params(2) - params(3))) + 1)));

end
