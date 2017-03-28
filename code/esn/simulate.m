function [u, y] = simulate(n)

% for class one 
u1 = zeros(1, n);
height = 0; 
duration = 5;
for i=1:n
    duration = duration - 1;
    
    if (duration == 0)
        duration = randi(10) + 2;
        if (height == 0)
            height = rand();
        else
            height = 0;
        end
    end
    
    u1(i) = height;
end
y1 = [1; 0];
y1 = repmat(y1, [1, n]);


% for class two
u2 = generateSin(n);
y2 = [0; 1];
y2 = repmat(y2, [1, n]);

u3 = generateSin(n) * 5;
n = 10000;
u = [u1 u2'];
y = [y1 y2];
ts = 1:20000;
plot(ts(1:100), u2(1:100), ts(1:100), u1(1:100));

end

