function [u, y, intervals, true_labels, max_u, min_u] = loadData(option)
%loadData from the *.set files and create the class label
% u: input sequence 12 * t
% y: teacher signal 2 * t
% intervals: the starting and end time for each input sequence 
% loading the training set 
% output the high_v and low_v for input normalization
% option: use to load 1st or 2nd set of data

%load('names.mat');  % load the mat for training set
if option == 1
    % oh vs yh: model a
    load('names_labels.mat');
elseif option == 2
    % ol vs oh: model c
    load('seconddata.mat');
else 
    % ol vs yh: model b
    load('thirdGroup.mat');
end

n = size(Code, 1);
intervals = ones(n,  2);

% figure how many timesteps for each data first
for i=1:n
    name = Code{i};
    name = name(2:end-1);
    EEG = pop_loadset('filename', strcat(name, '.set'), ...
    'filepath','/Users/Hang/thesis/data/processed/');
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
    'filepath','/Users/Hang/thesis/data/processed/');
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

