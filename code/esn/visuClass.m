function visuClass(u, y, y_pre, initP, endP)
% provide visu for training teacher signal and 
% preadicted output within a given internval
% u: input
% y: teacher
% initP and endP: are optional boundary default are set between 0 
% and 500

if nargin < 5
    initP = 1;
    endP = 500;
end

% input chans
xs = initP:endP;
if size(u, 1) > 5 
    for j=1:2
        figure;
        for i=(j -1) * 6 + 1: j * 6
            subplot(6, 1, i - (j - 1) * 6);
            plot(xs, u(i, initP:endP));
            str = sprintf('input dynamics %d', i);
            title(str);
        end
    end
else
    figure;
    for i=1:size(u, 1)
        subplot(size(u, 1), 1, i);
        plot(xs, u(i, initP:endP));
        str = sprintf('input dynamics %d', i);
        title(str);
    end
end

% teacher and simulate teacher
figure;
subplot(2, 1, 1);
plot(xs, y(1, initP:endP));
title('teacher signal');

subplot(2, 1, 2);
plot(xs, y_pre(2, initP:endP));
title('simulated teacher signal');

end

