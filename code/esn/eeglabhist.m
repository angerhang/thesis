% EEGLAB history file generated on the 27-Mar-2017
% ------------------------------------------------
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename','p2a8i7h.set','filepath','/Users/Hang/6thSemester/thesis/data/processed/');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
eeglab redraw;
