myData = EEG.data;
plot(myData(1, :));


for numChans = 1:size(EEG.data,1);
     EEG.data(numChans, :) = single(double(EEG.data(numChans, :)) ...
     - mean(double(EEG.data(numChans, :))));
end

eegplot(myData);