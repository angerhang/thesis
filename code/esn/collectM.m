function [M, y, new_intervals] = collectM(U, y, x, w, w_in, ...
                                       alpha, startPoint, intervals)
% collect responses for the internal dynamics 
% u: input NC by t
% y: teacher signal LP by t
% x: internal units a vector of length NX
% w: weight matrix NX by NX
% w_in: input to internal units weights
% w_out: output weight matrix NC by (1 + LP + NX)
% alpha: leaky rate
% intervals: the range of each data entries
% reg: regulization term

total_t = size(U, 2);
% internal unit responses 
xs = zeros(size(x, 1) + size(U, 1) +1 , total_t - ...
    startPoint * size(intervals, 1)); 
new_y = zeros(2, total_t - startPoint * size(intervals, 1));
new_intervals = zeros(size(intervals));
oldX = x;

% loop for each data entry 
for i=1:size(intervals, 1)
    current_c = 1;
    new_intervals(i, :) = [intervals(i, 1)-(i-1)*startPoint intervals(i, 2)-i*startPoint];
    x = oldX;
    
    for t=intervals(i,1):intervals(i, 2)
        % update state
        u = U(:, t);

        internal = w * x;
        inputs = w_in * [1; u];
        xs_temp = tanh(internal + inputs);
        x = (1 - alpha) * x + alpha * xs_temp;

        % discard for the init phase for every sequence
        if current_c > startPoint
            xs(:, t - startPoint * i) = [1; u; x];
            new_y(:, t - startPoint * i) = y(:, t);
        end
        
        current_c = current_c + 1;
    end
end

% T = w_out * [1; u; xs];
M = xs;
y = new_y;
