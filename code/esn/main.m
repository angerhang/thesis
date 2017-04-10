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

%% parameters 
alpha = 0.001; % leaky rate
NC = 12; % number of input channels
NX = 150; % number of internal units
LP = 2; % class number
row = 1; % spetral radius
in_scale = 0.2; % w_in will be sampled from [-in_scale, in_scale]
bias_scale = 0.1; 
startPoint = 500; % cut off point for internal unit responses 
reg = 1e-8; % regulization term

% model construction
[u, y, intervals] = loadData;
% simple custom inputs
% [u, y] = simulate(100000);
[x, w_in, w] = constructDR(NX, NC, row, in_scale, bias_scale);

tic;
fprintf('Start traning ...\n');
fprintf('Networks parameters: input channels: %d\n', NC);
fprintf('Internal units size: %d Leaky rate %f\n', NX, alpha);
fprintf('Spetrual radius  %f\n', row);
fprintf('Input scale: %f Bias scale: %f\n', in_scale, bias_scale);
fprintf('Response cutoff threshold: %d\n', startPoint);
fprintf('Regulization term is: %f\n', reg);

[M, w_out, x] = startTraining(u, y, x, w, w_in, alpha, ... 
                startPoint, intervals, reg);

endTime = toc;
fprintf('Training completed! Time spent: %f\n', endTime);

% error = computeError(u, M, w_out, y);
% fprintf('Sampling completed, the training error is %d ...\n', error);
% k = generateSin(1000)';
% [y_pre] = exploit(w_out, w_in, w, alpha, k, LP, x);

[y_pre] = exploit(w_out, w_in, w, alpha, u, LP, x);

predictions = predict(y_pre, intervals);

[~, true_label] = max(y,[],2);
[~, my_label] = max(predictions,[],2);
error = sum(true_label ~= my_label);
fprintf('The trianing error is %d\n', error);

% visu classification 
initP = 1;
endP = 2000;
visuClass(u, y, y_pre, initP, endP);
unitS = 27;
visuUnits(M, initP, endP, unitS);


