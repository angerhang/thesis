function e = computeError(d, w_out, x)
% compute the least square error given the 
% w_out 20 by 1 weights vector
% x: N by 20 matrix for state
% d: N by 1 expected values
e = d - x * w_out;
e = e .* e;
e = sum(e) / size(d, 1);

