% this scirpt applies the preprocess to every signle bdf file in the 
% raw_eeg directory. WARNING: make sure every file in raw_eeg is 
% of the form bdf otherwise processing will terminate
clc;
clear;

% activate eeglab
tic
cd ../eeglab
eeglab
cd ../esn

% preprocess all the raw eeg data 
%getEEGNames get the list of eeg file names to process
% call getNames to update
load 'names.mat'
cd ../../data/raw_eeg

% process every signle file and store them in the processed folder
for i=1:size(names, 1)
    preprocess(names{i});
    fprintf('%s preprocessing completed\n\n', names{i});
end


for i=72:size(names, 1)
    preprocess(names{i});
    fprintf('%s preprocessing completed\n\n', names{i});
end

% print out processing info
timer = toc;
fprintf('Processed %d files in total.\n', size(names, 1));
fprintf('Total time used %f\n', timer);

% come back to the current dir
cd ../../code/esn

% close plots for eeg filters
close all

