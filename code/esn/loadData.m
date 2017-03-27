function [u, y] = loadData
%loadData from the *.set files and create the class label
% u: input sequence 12 * t
% y: teacher signal 2 * t

EEG = pop_loadset('filename','p2a8i7h.set', ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
u = EEG.data;

timestep = size(u, 2);

% [1; 0] good learner
% [0; 1] bad learner
class = [1; 0]; 
y = repmat(class, 1, timestep);

end

