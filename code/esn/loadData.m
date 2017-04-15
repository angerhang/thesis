function [u, y, intervals, true_labels, max_u, min_u] = loadData
%loadData from the *.set files and create the class label
% u: input sequence 12 * t
% y: teacher signal 2 * t
% intervals: the starting and end time for each input sequence 
% loading the training set 
% output the high_v and low_v for input normalization

%load('names.mat');  % load the mat for training set
load('names_labels.mat');
n = size(Code, 1) - 1;
Code = Code(2:end);
learn = learn(2:end);
intervals = ones(n,  2);

% figure how many timesteps for each data first
for i=1:n
    name = Code{i};
    name = name(2:end-1);
    EEG = pop_loadset('filename', strcat(name, '.set'), ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
    u = EEG.data; 
    seq_length = size(u, 2);

    if i > 1
        intervals(i,:)=[intervals(i-1, 2)+1 intervals(i-1, 2)+seq_length];
    else 
        intervals(1,:)=[1 seq_length];
    end
end

% allocate space for u and y
u = ones(size(u, 1), intervals(n, 2));
y = ones(2, intervals(n, 2));
true_labels = ones(n, 1);
for i =1:n
    name = Code{i};
    name = name(2:end-1);
    EEG = pop_loadset('filename', strcat(name, '.set'), ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
    current = EEG.data; 
    u(:, intervals(i, 1):intervals(i, 2)) = current;
    
    % fill in teacher signal
    % [1; 0] good learner
    % [0; 1] bad learner
    if (learn(i) == 1)
        class = [1; 0];  
        true_labels(i) = 1;
    else 
        class = [0; 1];
        true_labels(i) = 2;
    end
    current_y = repmat(class, 1, intervals(i, 2) - intervals(i, 1) + 1);
    y(:, intervals(i, 1):intervals(i, 2)) = current_y;
end

% very high values are rare?
[u, max_u, min_u] = normalize_u(u);

end

