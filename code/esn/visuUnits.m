function visuUnits(x, initP, endP, initU)
% visu for the internal units within a given interval
% and given units
% assume always 20 units at a time

if nargin < 2
   initP = 1;
   endP = 1000;
   initU = 1;
elseif nargin < 4
   initU = 1;
end

xs = initP:endP;
unitIdx = initU:(initU+19);
figure
for i=1:20
    subplot(4, 5, i);
    plot(xs, x(unitIdx(i), initP:endP));
    str = sprintf('%d unit', i + unitIdx(i) - 1);
    title(str);
end

end

