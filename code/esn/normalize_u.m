function [norm_u, max_u, min_u] = normalize_u(u)
% takes the input signal and normalize the whole sequence 
% by finding the max and min among all channels  
% normalize across each channel

max_u = max(u, [], 2);
min_u = min(u, [], 2);
u_mean = (max_u + min_u) / 2;
u_diff = (max_u - min_u) / 2;

norm_u = zeros(size(u));

for i=1:size(u,1)
    norm_u(i,:) = (u(i,:) - u_mean(i)) / u_diff(i);    
end


end

