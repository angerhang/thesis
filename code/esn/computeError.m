function e = computeError(u, M, w_out, y)
% compute the least square error given the 
% w_out 20 by 1 weights vector
% x: N by 20 matrix for state
% d: N by 2 expected values

x = linspace(0, 31744, 1);
e = y - w_out * [ones(1, size(u, 2)); u; M];
e = e .* e;
e = sum(e) / size(y, 1);

