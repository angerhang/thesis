function [predictions] = predict(y_rep, intervals)
% make predictions for different data entries
% intervals sequence range of size n by 2
% predictions of size n by 2

predictions = ones(size(intervals, 1), 2);
for i=1:size(intervals, 1)
    current = y_rep(:, intervals(i,1):intervals(i,2));
    if (sum(current(1,:)) > sum(current(2,:)))
        predictions(i, :) = [1 0];
    else
        predictions(i, :) = [0 1];
    end    
end

end

