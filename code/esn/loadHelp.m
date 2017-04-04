EEG = pop_loadset('filename','8d2w7c_3.set', ...
    'filepath','/Users/Hang/6thSemester/thesis/data/processed/');
test = EEG.data;

[y_pre] = exploit(w_out, w_in, w, alpha, test, LP, x);
sum(y_pre(1,:))
sum(y_pre(2,:))

% this is a bad one
% [0; 1] bad learner

