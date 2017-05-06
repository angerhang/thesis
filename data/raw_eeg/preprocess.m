function preprocess(dataName)
%this preprocess precedure does the following
% for a given raw eeg file
%      a. offset removal
%      b. select electrodes:F3 C3 P3 Pz O1 Oz O2 P4 C4 F4 Fz Cz
%      c. downsampling: 512Hz
%      d. filtering: with bandpass 1-40Hz (notch to do)
%      e. ICA to do
dataName = strcat(dataName);
dataPath = strcat('/Users/Hang/thesis/data/raw_eeg/', ...
            dataName, '.bdf');

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

EEG = pop_biosig(dataPath);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'gui','off'); 
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
EEG=pop_chanedit(EEG, 'lookup','/Users/Hang/thesis/code/eeglab/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'channel',{'F3' 'C3' 'P3' 'Pz' 'O1' 'Oz' ...
    'O2' 'P4' 'C4' 'F4' 'Fz' 'Cz'});
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, 256);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = pop_eegfiltnew(EEG, 1,40,1690,0,[],1);

EEG = pop_runica(EEG, 'extended',1,'interupt','off');
[~, ~, ~, artcmps] = processMARA ( ALLEEG,EEG,CURRENTSET );

if ~isempty(artcmps)
   EEG = pop_subcomp( EEG, artcmps, 0);
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off');  
end

% saving procedure
cd ../processed/
to_save_name = strcat(dataName);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'savenew', to_save_name ...
    ,'gui','off');
cd ../raw_eeg/

end

