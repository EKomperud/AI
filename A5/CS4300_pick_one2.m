function destination = CS4300_pick_one2(safe, visited)
% CS4300_pick_one - pick a safe, unvisited square
% On input:
%   safe: A Wumpus board that has safe locations recorded
%   visited: A Wumpus board that has visited locations recorded
% On output:
%   destination: A random, safe, unvisited location if one exists
% Call:
%   destination = CS4300_pick_one(safe, visited);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

destination = [];
possible_locations = [];
size = 0;

for i = 1:16
    y = idivide(int8(i-1),int8(4),'floor') + 1;
    y = double(y);
    x = mod((i),4);
    if x == 0
        x = 4;
    end
    if safe(y,x) == -1 && visited(y,x) == 0
        possible_locations = [possible_locations; [x,(5-y),0]];
        size = size + 1;
    end
end

if size > 0
    destination = possible_locations(randi(size),:);
end

end

