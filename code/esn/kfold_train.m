function [w_out, x] = kfold_train(M, y, intervals, in_size, reg)
% comptue w_out based on the already collected internal units 

n = size(intervals, 1);
start = 1 + in_size;
x = M(start:size(M, 1), intervals(n, 2));

total_t = sum(intervals(:, 2) - intervals(:, 1)) + size(intervals, 1);
xs = zeros(size(M ,1), total_t);
yt = zeros(2, total_t);

for i=1:size(intervals, 1)
   xs(:, intervals(i, 1):intervals(i, 2)) = ...
       M(:, intervals(i, 1):intervals(i, 2));
   yt(:, intervals(i, 1):intervals(i, 2)) = ...
      y(:, intervals(i, 1):intervals(i, 2));
end

xt = xs';
w_out =  yt * xt * inv(xs * xt + reg * eye(size(x, 1) + in_size));

end

