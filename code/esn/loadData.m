function [u, y] = loadData
%loadData from the *.set files and create the class label
% u: input sequence 12 * t
% y: teacher signal 2 * t

EEG = pop_loadset('filename','p2a8i7h.set', ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
u = EEG.data;

timestep = size(u, 2);
class = [0; 1]; 
y = repmat(class, 1, timestep);

EEG = pop_loadset('filename','py5p.set', ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
timestep = size(EEG.data, 2);
u = [u EEG.data];
class = [1; 0]; 
miney = repmat(class, 1, timestep);
y = [y miney];

% [1; 0] good learner
% [0; 1] bad learner

end

