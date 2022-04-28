function mono_fit_fcn = TriMT_PreMe1_mono(params, t)
%
%% CORRESPONDS TO EQUATION 26
%
% This function describes describes the accumulation of dimethyl species from
%   using the decaying monomethyl signal.
%
% C1, C2, C3, C4, C5, and C6 are scaling/offset factors (they are NOT all used
%   in this function) and k2 and k3 are the di- and tri-methyl
%   rate constants, respectively
%
% NB: this function works alongside "TriMT_PreMe1_di.m" and "TriMT_PreMe1_tri.m"
%
% k2 = params(1)
% C1 = params(2)
% k3 = params(3)
% C2 = params(4)
% C3 = params(5)
% C4 = params(6)
% C5 = params(7)
% C6 = params(8)

mono_fit_fcn = params(6) + (params(2) .* exp(-params(1)*t));

end
