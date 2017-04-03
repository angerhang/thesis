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

xs = initP:endP;
subplot(3, 1, 1);
plot(xs, u(initP:endP));
title('input dynamics');

subplot(3, 1, 2);
plot(xs, y(1, initP:endP));
title('teacher signal');

subplot(3, 1, 3);
plot(xs, y_pre(2, initP:endP));
title('simulated teacher signal');

end

