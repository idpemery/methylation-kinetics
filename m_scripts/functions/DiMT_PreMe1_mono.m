function mono_fit_fcn = DiMT_PreMe1_mono(params, t)
%
%% CORRESPONDS TO EQUATION 21
%
% This function describes describes the accumulation of dimethyl species from
%   treatment with a dimethyltransferase (terminal step) using the decaying
%   monomethyl signal.
%
% In Usher, ET, et al Biophys J (2021), this function was used to analyze
%   RT-NMR data from a "pre-methylated" H3K4Me1 sample treated with a dimethyltransferase
%
% C1, C2, C3, and C4 are scaling/offset factors (they are NOT all used
%     in this function) and k2 is the di-monomethyl rate constant.
%
% NB: this function works alongside "DiMT_PreMe1_di.m"
%
% k2 = params(1)
% C1 = params(2)
% C2 = params(3)
% C3 = params(4)
% C4 = params(5)


mono_fit_fcn = params(3) + (params(2) .* exp(-params(1)*t));

end
