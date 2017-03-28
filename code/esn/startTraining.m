function [M, w_out, x] = startTraining(U, y, x, w, w_in, alpha)
% collect responses for the internal dynamics 
% u: input NC by t
% y: teacher signal LP by t
% x: internal units a vector of length NX
% w: weight matrix NX by NX
% w_in: input to internal units weights
% w_out: output weight matrix NC by (1 + LP + NX)
% alpha: leaky rate

startPoint = 100;

t = size(U, 2);
% internal unit responses 
xs = zeros(size(x, 1) + size(U, 1) +1 , t - startPoint); 

for i=1:t
    % update state
    u = U(:, i);

    internal = w * x;
    inputs = w_in * [1; u];
    xs_temp = tanh(internal + inputs);
    x = (1 - alpha) * x + alpha * xs_temp;
    
    if i > startPoint
        xs(:, i - startPoint) = [1; u; x];
    end
end

% T = w_out * [1; u; xs];
M = xs;

%w_out = y * pinv(M);
reg = 1e-8;  
xt = xs';
yt = y(:, 1:(t - startPoint));
% need to change to time average activations instead of x(n)
w_out = yt * xt * inv(xs * xt + reg*eye(size(x, 1) + size(U, 1) +1));

 
