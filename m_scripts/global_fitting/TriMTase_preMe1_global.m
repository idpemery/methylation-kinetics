clc
clear

%% This script performs global minimization with respect to kinetic rate constants
%   using lsqcurvefit and then saves the raw data points, the fit data generated
%   from the optimized params, and the residuals of the fit to a .txt file.
%
% //ETU 2022 emeryusher95@gmail.com or @idpemery on Twitter

% Import text files from "1D_combiner.py" script containing
% list of monomethyl & dimethyl resonance intensity values

raw_data_mono = importdata('TriMT_preMe1_monomethyl_example.txt');
raw_data_di = importdata('TriMT_preMe1_dimethyl_example.txt');
raw_data_tri = importdata('TriMT_preMe1_trimethyl_example.txt');

% Import text file containing list of times (in minutes)
t = importdata('TriMT_preMe1_time.txt');

% Scale down signal intensity data (no other normalization)
S1 = raw_data_mono ./ 10e8;
S2 = raw_data_di ./ 10e8;
S3 = raw_data_tri ./ 10e8;

% Store scaled intensity valuess in one array for global fit
int_array = [S1(:), S2(:), S3(:)];

% Input initial guess values for lsqcurvefit
% initial conditions must be qualitatively correct
% ie, if monomethyl is visibly faster than dimethyl,
% k1 guess must be greater than k2 guess
    % k2 = params(1)
    % C1 = params(2)
    % k3 = params(3)
    % C2 = params(4)
    % C3 = params(5)
    % C4 = params(6)
    % C5 = params(7)
    % C6 = params(8)
guess = [0.0126, 5, 0.02, 7, 6, 4, 5, 5];

% Define anonymous function that calls integrated
% rate equation functions (within same directory)
    % nested functions yield shared parameters
fun = @(params, t) [TriMT_PreMe1_mono(params, t), TriMT_PreMe1_di(params, t), TriMT_PreMe1_tri(params, t)];

% Call least squares nonlinear fitting algorithm:
    % parameters (see lines 32-39) are stored in "outfit"
    % e.g., k2 is stored in outfit at params index 1
outfit = lsqcurvefit(fun, guess, t, int_array);

% Store rate constants as comphrensible variable
% and round to four decimal places
k2 = round(outfit(1), 4);
k3 = round(outfit(3), 4);

% Generate nonlinear fit from outfit parameters
% versus time for downstream plotting
mono_fit = TriMT_PreMe1_mono(outfit, t);
di_fit = TriMT_PreMe1_di(outfit, t);
tri_fit = TriMT_PreMe1_tri(outfit, t);

% Determine goodness of fit with residuals
residuals_mono = S1 - mono_fit;
residuals_di = S2 - di_fit;
residuals_tri = S3 - tri_fit;

% Write text file containing 'data' array and store rate
% constant(s) in a paramter text file
data1 = [t, S1, mono_fit, residuals_mono];
data2 = [t, S2, di_fit, residuals_di];
data3 = [t, S3, tri_fit, residuals_tri];
params  = [k2, k3];

save('mono_data_fit.txt', 'data1', '-ascii', '-tabs');
save('di_data_fit.txt', 'data2', '-ascii', '-tabs');
save('tri_data_fit.txt', 'data3', '-ascii', '-tabs');
save('params.txt', 'params', '-ascii', '-tabs');
