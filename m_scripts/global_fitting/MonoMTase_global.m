clc
clear

% Import text file from "1D_combiner" script containing
% list of monomethyl resonance intensity values
raw_signal = importdata('MonoMT_monomethyl_example.txt');

% Import text file containing list of times (in minutes)
t = importdata('MonoMT_time.txt');

% Scale down signal intensity data (no other normalization)
S = raw_signal ./ 10e8;

% Input initial guess values for lsqcurvefit
    % C1 = params(1)
    % k1 = params(2)
    % C2 = params(3)
guess = [2, 0.0126, 0.3];

% Define anonymous function that calls integrated
% rate equation function (within same directory)
    % NB: the mono MTase fit is structured identically
    % to the global fit function; it is written to 
    % 'global fit' to one parameter (k1)
fun = @(params, t) MonoMT_mono(params, t);

% Call least squares nonlinear fitting algorithm:
    % parameters (see lines 15-17) are stored in "outfit"
    % e.g., k1 is stored in outfit at index 2
outfit = lsqcurvefit(fun, guess, t, S);

% Store rate constant as comphrensible variable
% and round to four decimal places
k1 = round(outfit(2), 4);

% Generate nonlinear fit from outfit parameters
% versus time for downstream plotting
mono_fit = MonoMT_mono(outfit, t);

% Determine goodness of fit with residuals
residuals = S - mono_fit;

% Write text file containing 'data' array and store rate
% constant(s) in a paramter text file
data = [t, S, mono_fit, residuals];
params  = k1;

save('data_fit.txt', 'data', '-ascii', '-tabs');
save('params.txt', 'params', '-ascii', '-tabs');

