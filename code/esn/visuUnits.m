function visuUnits(x, initP, endP, initU, endU)
% visu for the internal units within a given interval
% and given units
% assume always 20 units at a time

if nargin < 2
   initP = 1;
   endP = 1000;
   initU = 1;
   endU = 20;
elseif nargin < 5
   initU = 1;
   endU = 20;
end

xs = initP:endP;

for i=initU:endU
    subplot(4, 5, i);
    plot(xs, x(i, initP:endP));
    str = sprintf('%d unit', i);
    title(str);
end

end

