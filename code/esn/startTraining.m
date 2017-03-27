function [M, w_out] = startTraining(u, y, x, w, w_in, alpha)
% collect responses for the internal dynamics 
% u: input NC by t
% y: teacher signal LP by t
% x: internal units a vector of length NX
% w: weight matrix NX by NX
% w_in: input to internal units weights
% w_out: output weight matrix NC by (1 + LP + NX)
% alpha: leaky rate

t = size(u, 2);
% internal unit responses 
xs = zeros(size(x, 1), t); 

for i=1:t
    % update state
    if (i == 1)
        xs(:, i) = alpha *  tanh(w_in * [1; u(:, i)]);
    else 
        internal = w' * xs(:,i-1);
        inputs = w_in * [1; u(:, i)];
        xs_temp = tanh(internal + inputs);
        xs(:, i) = (1 - alpha) * xs(:, i - 1) + alpha * xs_temp;
    end;
end

% T = w_out * [1; u; xs];
M = xs;
w_out = y * pinv(M);

