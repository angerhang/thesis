function [M, T] = startTraining (x, d, w, w_back)
% sampling and record the weights from 101-300 steps
% d is the teacher signal of size 300 * 1
% M: size 200 * 20 of the recored sates
% T: size 200 * 1 of the teacher force
xs = zeros(size(x, 1), length(d));

for i=2:300
    % update state
    internal = w' * xs(:,i-1);
    back_proj =  w_back * d(i-1);
    xs(:, i) = tanh(internal + back_proj);
end

M = xs(:, 101:300)';
T = d(101:300);

ts = 1:50;
subplot(2,2,2);
d = xs(1, 1:50)';
plot(ts, d);
title('Internal state for the 1st internal unit')

subplot(2,2,3);
d = xs(3, 1:50)';
plot(ts, d);
title('Internal state for the 3st internal unit')

