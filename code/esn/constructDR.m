function [x, w, w_back] = constructDR(N, L)
% initilize the DR input, internal (x) and output (d) units
% and their corresponding weights W, W_out and W_back
% initialize DR parameters 
% N : the number of internal states
% x: internal inputs
% w: weights from internal units to output layer
% w_back: back projection from output to the internal units

% generate output 
w_back = rand(N, L);

% construct internal units
x = zeros(N, L);
% x = round(rand(N, L));
w = rand(N) - 0.5; % Wij the weight from ith unit to the jth

