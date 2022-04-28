clc
clear

%% This script performs global minimization with respect to kinetic rate constants
%   using lsqcurvefit and then saves the raw data points, the fit data generated
%   from the optimized params, and the residuals of the fit to a .txt file.
%
% //ETU 2022 emeryusher95@gmail.com or @idpemery on Twitter

% Import text files from "1D_combiner" script containing
% list of monomethyl & dimethyl resonance intensity values
raw_data_mono = importdata('DiMT_monomethyl_example.txt');
raw_data_di = importdata('DiMT_dimethyl_example.txt');

% Import text file containing list of times (in minutes)
t = importdata('DiMT_time.txt');

% Scale down signal intensity data (no other normalization)
S1 = raw_data_mono ./ 10e8;
S2 = raw_data_di ./ 10e8;

% Store scaled intensity valuess in one array for global fit
int_array = [S1(:), S2(:)];

% Input initial guess values for lsqcurvefit
% initial conditions must be qualitatively correct
% ie, if monomethyl is visibly faster than dimethyl,
% k1 guess must be greater than k2 guess
    % k1 = params(1)
    % k2 = params(2)
    % C1 = params(3)
    % C2 = params(4)
    % C3 = params(5)
    % C4 = params(6)
guess = [0.0126, 0.02, 5, 0.03, 0.04, 0.5];

% Define anonymous function that calls integrated
% rate equation functions (within same directory)
    % nested mono and di functions yield shared
    % parameter output (global fit for k1 and k2)
fun = @(params, t) [DiMT_mono(params, t), DiMT_di(params, t)];

% Call least squares nonlinear fitting algorithm:
    % parameters (see lines 29-34) are stored in "outfit"
    % e.g., k1 is stored in outfit at params index 1
outfit = lsqcurvefit(fun, guess, t, int_array);

% Store rate constants as comphrensible variable
% and round to four decimal places
k1 = round(outfit(1), 4);
k2 = round(outfit(2), 4);

% Generate nonlinear fit from outfit parameters
% versus time for downstream plotting
mono_fit = DiMT_mono(outfit, t);
di_fit = DiMT_di(outfit, t);

% Determine goodness of fit with residuals
residuals_mono = S1 - mono_fit;
residuals_di = S2 - di_fit;

% Write text file containing 'data' array and store rate
% constant(s) in a paramter text file
data1 = [t, S1, mono_fit, residuals_mono];
data2 = [t, S2, di_fit, residuals_mono];
params  = [k1, k2];

save('mono_data_fit.txt', 'data1', '-ascii', '-tabs');
save('di_data_fit.txt', 'data2', '-ascii', '-tabs');
save('params.txt', 'params', '-ascii', '-tabs');
