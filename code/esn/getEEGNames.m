function [newnames] = getEEGNames
% return the list of eeg data source names

files = dir;
filenames = [];

% get the list of names
for i=1:size(files)
    name = files(i).name;
    postfix = strsplit(name, '.');
    postfix = postfix{2};
    if (length(name) > 3 && name(1) ~= '.' && strcmp(postfix,'bdf'))
        filenames = [filenames name ' '];
    end
    
end

filenames = strsplit(filenames);
% hard code to get rid of the last empty string
newnames = filenames(:, 1:77);

end

