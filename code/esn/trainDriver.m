clear;
clc;

%% driver for esn 
% we first load eeglab and set the global parameters 
% preprocessing for data is done separately in preprocess
% all data should be placed in ../data/processed
% needs to be carried out in the code/esn folder
fprintf('Constructing DR...\n');

% loading eeglab
cd ../eeglab
eeglab;
cd ../esn

%% model setup 
alpha = 0.1;
%alpha = 0.00001; % leaky rate
NC = 12; % number of input channels
NX = 1500; % number of internal units
LP = 2; % class number
row = 0.1; % spetral radius
in_scale = 1; % w_in will be sampled from [-in_scale, in_scale]
bias_scale = 1; 
startPoint = 700; % cut off point for internal unit responses 
% reg = 2.2e-05; % regulization term
reg = 0; % regulization term

k = 3;

% model construction
[u, y, intervals, true_labels, max_u, min_u] = loadData(2);
alphas = [0.1 0.25 0.4 0.55 0.70];
rows = [0.1 0.25 0.4 0.55 0.70]; % spetral radius
regs = [1e-06 5e-06 1e-05 5e-05 1e-04 5e-04 1e-03 5e-03 1e-02];
%% training
% simple custom inputs
% [u, y] = simulate(100000);
erros = zeros(9, 5);

tic;
count = 1;
for i=1:9
reg = regs(i);
fprintf('%d iteration\n', count);
fprintf('Networks parameters: input channels: %d\n', NC);
fprintf('Internal units size: %d Leaky rate %f\n', NX, alpha);
fprintf('Spetrual radius  %f\n', row);
fprintf('Input scale: %f Bias scale: %f\n', in_scale, bias_scale);
fprintf('Response cutoff threshold: %d\n', startPoint);
fprintf('Regulization term is: %f\n', reg);

fprintf('Start cross-validation ...\n');
% cross validation
[x, w_in, w] = constructDR(NX, NC, row, in_scale, bias_scale);
[~, ~, train_er, test_er] = cross_validate(u, y, x, w, w_in, alpha,... 
                startPoint, intervals, reg, k, true_labels, LP);
            
erros(count, 1)= train_er;
erros(count, 2)= test_er;
erros(count, 3)= alpha;
erros(count, 4)= row;
erros(count, 5)= reg;
count = count + 1;
end

timeUsed = toc;
xs = 1:9;

plot(xs, erros(:,1), 'b', xs, erros(:, 2), 'g');
save('reg.mat', 'erros');

[M, w_out, x] = startTraining(u, y, x, w, w_in, alpha, ... 
                startPoint, intervals, reg);

endTime = toc;
fprintf('Training completed! Time spent: %f\n', endTime);

[y_pre] = exploit(w_out, w_in, w, alpha, u, LP, x);

predictions = predict(y_pre, intervals);

% true label needs to be loaded with the intervals
[~, my_labels] = max(predictions,[],2);
error = sum(true_labels ~= my_labels);
fprintf('The trianing error is %d: %f percent\n', error, ...
    error/size(intervals, 1));

% visu classification 
initP = train_ints(1,1);
endP =  train_ints(2,2);

visuClass(train_u, train_y, y_pre, initP, endP);
unitS = 30;
visuUnits(M, initP, endP, unitS);

small = 0.4:0.15:0.85;
alphas = 0.1:0.15:0.55;
ori = 0.00001;
for i=1:10
    alphas(i) = ori;
    ori = ori * 3;
end

[X, Y] = meshgrid(small, alphas);
subplot(2,1,2)       % add first plot in 2 x 2 grid
Z = reshape(erros(:, 2), 4, 4); 
surf(X, Y, Z);






