clear;
clc;
%% put everything together
% then learns from a teacher sin wave of 300 time steps
% and finally produce the sin wave from 301 to 350 time steps
fprintf('Constructing DR...\n');

%% parameters 
alpha = 1.2; % leaky rate
NC = 12; % number of input channels
NX = 250; % number of internal units
LP = 2; % class number

%% model construction
[u, y] = loadData;
% uncomment for custom signal
% [u, y] = simulate(20000);
[x, w_in, w] = constructDR(NX, NC);

fprintf('Traning ...\n');

[M, w_out, x] = startTraining(u, y, x, w, w_in, alpha);

% error = computeError(u, M, w_out, y);

% fprintf('Sampling completed, the training error is %d ...\n', error);

[y] = exploit (w_out, w_in, w, alpha, u, LP, x);

% visu classification 
% does it make sense to have w_out having symmetry
initP = 100;
endP = 10000;
visuClass(y, initP, endP);

