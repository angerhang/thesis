% save the names needed for preprocessing

t = readtable('labels.csv');
names = table2cell(t(:, 2));
t = readtable('topredict.csv');
newnames = table2cell(t(:, 2));
names = [names ; newnames];
save('../code/esn/names.mat', 'names');