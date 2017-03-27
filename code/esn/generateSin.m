function ds = generateSin(n)
% generate the teacher signal for a 
% sin wave defined by d(n) = 1/2 sin(n/4)
% n is the number of steps in the sequence
% ds will be a n * 1 column vector

ts = 0:(n - 1);
ds = arrayfun(@(x) 1 / 2 * sin(x / 4), ts)';
