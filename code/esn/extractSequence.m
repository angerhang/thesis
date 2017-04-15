function [new_u, new_y, newtrain_ints] = extractSequence(u, y, intervals)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

total_t = sum(intervals(:, 2) - intervals(:, 1)) + size(intervals, 1);
new_u = zeros(size(u, 1), total_t);
new_y = zeros(size(y, 1), total_t);
newtrain_ints = zeros(size(intervals));
counter = 1;

for i=1:size(intervals, 1)
    step = intervals(i, 2) - intervals(i, 1);
    new_u(:, counter:counter+step) = u(:, intervals(i, 1):intervals(i, 2));
    new_y(:, counter:counter+step) = y(:, intervals(i, 1):intervals(i, 2));
    counter = counter + step + 1;
    
     if i > 1
        newtrain_ints(i,:)= ...
                    [newtrain_ints(i-1, 2)+1 newtrain_ints(i-1, 2) + step];
    else 
        newtrain_ints(1,:)=[1 step];
    end
end

end

