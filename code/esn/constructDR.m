function [x, w_in, w] = constructDR(NX, NC, row, in_scale, bias_scale)
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
% row: the spetral radius of w
% bias_scale and in_scale: range of the columns of w should be sampled

% generate output 
w_bias = rand(NX, 1) * 2 * bias_scale - bias_scale;
w_ins = rand(NX, NC) * 2 * in_scale - in_scale;
w_in = [w_bias w_ins];

% w_out = rand(LP, 1 + NC + NX) - 0.5;
% normalize spectral radius
w = rand(NX) - 0.5; % Wij the weight from ith unit to the jth
opt.disp = 0;
real_row = abs(eigs(w, 1, 'LM', opt));
w = w .* ( row / real_row);

% construct internal units
x = zeros(NX, 1);



