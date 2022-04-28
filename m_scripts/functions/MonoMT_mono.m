function mono_fit_fcn = MonoMT_mono(params, t)
%
%% CORRESPONDS TO EQUATION 4
%
% This function describes the pseudo-first order kinetics
%   of the monomethylation step by a monomethyltransferase
%   (terminal step)
%
% C1 and C2 are scaling/offset factors and k1 is the
%   monomethyl transfer rate constant
%
% C1 = params(1)
% k1 = params(2)
% C2 = params(3)

mono_fit_fcn = params(3) + (params(1) .* (1 - exp(-abs(params(2)) .* t)));

end
