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
[x, w_in, w, w_out] = constructDR(NX, NC, LP);

fprintf('Sampling ...\n');

[M, T] = startTraining (x, d, w, w_back);
w_out = pinv(M) * T;

error = computeError(T, w_out, M);
fprintf('Sampling completed, the training error is %d ...\n', error);

%% generate unseen sin waves
generationTime = 50;
fprintf('Generating predictions ...\n');
d = exploit (w_out, w, w_back, M(200,:)', T(200), generationTime);
ds = generateSin(350);
error =  sum((ds(301:350) - d).^2) / generationTime;
fprintf('Generation completed, the testing error is %d ...\n', error);

subplot(2,2,4);
ts = 301:350;
plot(ts, d);
title('Generated sin wave for 50 time steps');
