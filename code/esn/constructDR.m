function [x, w_in, w] = constructDR(NX, NC, LP)
% initilize the DR input, internal (x) and output (d) units
% and their corresponding weights W, W_out and W_back
% initialize DR parameters 
% NX : the number of internal states
% LP : the number of predictor classes
% NC: the number of input channels
% x: internal inputs
% w: weights from internal units to output layer
% w_in: input to internal units weights
% w_out: output weight matrix

% generate output 
w_in = rand(NX, 1 + NC) - 0.5;
% w_out = rand(LP, 1 + NC + NX) - 0.5;
w = rand(NX) - 0.5; % Wij the weight from ith unit to the jth

% construct internal units
x = zeros(NX, 1);



