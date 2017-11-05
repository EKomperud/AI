function d = CS4300_Manhattan_Distance(current_state, goal_state)
% CS4300_Manhattan_Distance - Calculates the Manhattan Distance between 2
% nodes
% On input:
%   current_state = [x_position, y_position, direction]
%   goal_state = [x_position, y_position, direction]
% On output:
%   d = (current_state(1)-goal_state(1))+(current_state(2)- goal_state(2))
% Author:
% Eric Komperud
% U0844210
% Fall 2017

xy = [ 0 0 ];
xy(1) = abs(current_state(1) - goal_state(1));
xy(2) = abs(current_state(2) - goal_state(2));
d = xy(1) + xy(2);

end

