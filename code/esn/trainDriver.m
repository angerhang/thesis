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
alpha = 0.003;
%alpha = 0.00001; % leaky rate
NC = 12; % number of input channels
NX = 250; % number of internal units
LP = 2; % class number
row = 1; % spetral radius
in_scale = 0.2; % w_in will be sampled from [-in_scale, in_scale]
bias_scale = 0.1; 
startPoint = 550; % cut off point for internal unit responses 
% reg = 2.2e-05; % regulization term
reg = 2.2e-05; % regulization term

k = 5;

% model construction
[u, y, intervals, true_labels, max_u, min_u] = loadData(3);

%% training
% simple custom inputs
% [u, y] = simulate(100000);
erros = zeros(15, 5);

tic;
count = 1;
for i=1:15
fprintf('%d iteration\n', count);
[x, w_in, w] = constructDR(NX, NC, row, in_scale, bias_scale);
fprintf('Networks parameters: input channels: %d\n', NC);
fprintf('Internal units size: %d Leaky rate %f\n', NX, alpha);
fprintf('Spetrual radius  %f\n', row);
fprintf('Input scale: %f Bias scale: %f\n', in_scale, bias_scale);
fprintf('Response cutoff threshold: %d\n', startPoint);
fprintf('Regulization term is: %f\n', reg);

fprintf('Start cross-validation ...\n');
% cross validation
[~, ~, train_er, test_er] = cross_validate(u, y, x, w, w_in, alpha,... 
                startPoint, intervals, reg, k, true_labels, LP);
            
erros(count, 1)= train_er;
erros(count, 2)= test_er;
erros(count, 3)= alpha;
erros(count, 4)= row;
erros(count, 5)= reg;
count = count + 1;
alpha = alpha + 0.002;

end

timeUsed = toc;

plot(erros(:, 5), erros(:,1), 'b', erros(:, 5), erros(:, 2), 'g');
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
initP = 1;
endP = 2000;

visuClass(u, y, y_pre, initP, endP);
unitS = 100;
visuUnits(M, initP, endP, unitS);

small = 0.91:0.01:1;
alphas = 0.0001:0.0001:0.001;
ori = 0.00001;
for i=1:10
    alphas(i) = ori;
    ori = ori * 3;
end

[X, Y] = meshgrid(small, alphas);
subplot(2,1,2)       % add first plot in 2 x 2 grid
Z = reshape(erros(:, 2), 10, 10); 
surf(X, Y, Z);






