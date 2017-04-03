clear;
clc;
%% put everything together
% then learns from a teacher sin wave of 300 time steps
% and finally produce the sin wave from 301 to 350 time steps
fprintf('Constructing DR...\n');

%% parameters 
alpha = 0.7; % leaky rate
NC = 1; % number of input channels
NX = 300; % number of internal units
LP = 2; % class number

%% model construction
% [u, y] = loadData;
% simple custom inputs
[u, y] = simulate(100000);

% uncomment for custom signal
% [u, y] = simulate(20000);
[x, w_in, w] = constructDR(NX, NC);

fprintf('Traning ...\n');

[M, w_out, x] = startTraining(u, y, x, w, w_in, alpha);

% error = computeError(u, M, w_out, y);
% fprintf('Sampling completed, the training error is %d ...\n', error);
% k = generateSin(1000)';
% [y_pre] = exploit(w_out, w_in, w, alpha, k, LP, x);

[y_pre] = exploit(w_out, w_in, w, alpha, u, LP, x);

% visu classification 
initP = 5000;
endP = 6000;
visuClass(u, y, y_pre, initP, endP);
visuUnits(M, initP, endP);

