function [norm_u, max_u, min_u] = normalize_u(u)
% takes the input signal and normalize the whole sequence 
% by finding the max and min among all channels  

% 1 3 5 9 
max_u = max(max(u));
min_u = min(min(u));
u_mean = (max_u + min_u) / 2;
u_diff = (max_u - min_u) / 2;

norm_u = (u - u_mean) / u_diff;

end

