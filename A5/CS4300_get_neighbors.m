function neighbors = CS4300_get_neighbors(x,y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

neighbors = [];

if x < 4
    neighbors = [neighbors; x + 1, y];
end
if y < 4
    neighbors = [neighbors; x, y + 1];
end
if x > 1
    neighbors = [neighbors; x - 1, y];
end
if y > 1
    neighbors = [neighbors; x, y - 1];
end

end

