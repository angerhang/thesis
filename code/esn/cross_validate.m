function [train_e, test_e, train_er, test_er] = cross_validate(u, y, x, w, ...
              w_in, alpha, startPoint, intervals, reg, k, true_labels, LP)
% this script splits the whole data set into k folds and 
% we use a stratefied approach 
% report the training and testing error along with their visus
% test_e and train_e will just be a vector of size k
% M, w_out, x will be the optimal parameters taken from the best fold


% might need to change if having more classes
rng('default');
one_len = sum(true_labels == 1);
two_len = sum(true_labels == 2);
indices_one = crossvalind('Kfold', one_len, k);
indices_two = crossvalind('Kfold', two_len, k);
indices = [indices_two; indices_one];

test_e = zeros(k, 1);
train_e = zeros(k, 1);
test_er = 0;
train_er = 0;

[M, new_y, new_intervals] = collectM(u, y, x, w, w_in, ...
                                       alpha, startPoint, intervals);
target = [];
output = [];

for i=1:k
    % spliting 
    fprintf('Epoch %d out of %d folds\n', i, k);
    test = (indices == i); train = ~test;
    train_ints = new_intervals(train, :);
    train_labels = true_labels(train, :);
    test_ints = intervals(test, :);
    test_labels = true_labels(test, :);

    % training
    [w_out] = kfold_train(M, new_y, train_ints, size(w_in, 2), reg);         
    
    train_ints = intervals(train, :);
    [train_u, train_y, train_ints] = extractSequence(u, y, train_ints);
    [y_pre] = exploit(w_out, w_in, w, alpha, train_u, LP, x);

    predictions = predict(y_pre, train_ints, startPoint);

    % training error 
    % true label needs to be loaded with the intervals
    [~, my_labels] = max(predictions,[],2);
    error = sum(train_labels ~= my_labels);
    fprintf('The trianing error is %d: %f percent\n', error, ...
        error/size(train_ints, 1));
    train_e(i) = error;
    train_er = train_er +  error/size(train_ints, 1);
    
    % testing error 
    [test_u, test_y, test_ints] = extractSequence(u, y, intervals);
    y_pre = zeros(2, test_ints(size(test_ints, 1), 2));
    for j = 1:size(test_ints, 1)
        y_pre(:, test_ints(j, 1):test_ints(j, 2)) ...
         =  exploit(w_out, w_in, w, alpha, ... 
         test_u(:, test_ints(j,1):test_ints(j, 2)), LP, x);
    end
    predictions = predict(y_pre, test_ints, startPoint);
    [~, my_labels] = max(predictions,[],2);
    error = sum(test_labels ~= my_labels);
    fprintf('The testing error is %d: %f percent\n', error, ...
        error/size(test_ints, 1));
    test_e(i) = error;
    test_er = test_er + error/size(test_ints, 1);
    
    target = [target; test_labels];
    output = [output; predictions];
end


train_er = train_er / k;
test_er = test_er / k;
fprintf('Overall training error is %d %f percent\n', mean(train_e), train_er);
fprintf('Overall testing error is %d %f percent\n', mean(test_e),  test_er); 
end


            

            
            