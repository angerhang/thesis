clear;
clc;
%% put everything together
% this script first constructs a simple dr with input units
% then learns from a teacher sin wave of 300 time steps
% and finally produce the sin wave from 301 to 350 time steps
fprintf('Constructing DR...\n');

%% parameters 
alpha = 0.02; % leaky rate
NC = 12; % number of input channels
NX = 50; % number of internal units
LP = 2; % class number

%% model construction
[u, y] = loadData;
[x, w_in, w] = constructDR(NX, NC, LP);

fprintf('Traning ...\n');

[M, w_out] = startTraining(u, y, x, w, w_in, alpha);

error = computeError(u, M, w_out, y);

fprintf('Sampling completed, the training error is %d ...\n', error);

