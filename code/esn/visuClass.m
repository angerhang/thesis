function visuClass(y, initP, endP)

xs = initP:endP;
plot(xs, y(1 , initP:endP), xs, y(2, initP:endP));
legend('class one', 'class two');

end

