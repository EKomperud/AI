function path = CS4300_A_star(board, start, goal, h_name)
% CS4300_A_star - find the quickest path from start to goal
% On input:
%   start (1x3 vector): x,y,dir
%   goal (1x3 vector): x,y,dir
% On output:
%   path (nx4 array): solution sequence of state and action
% Call:
%   p = CS4300_A_star(11,44);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
% 

open_list = [];
closed_list = [];
path = [];

start_node.parent = [];
start_node.state = start;
start_node.action = 0;
%start_node.level = 0;
start_node.cost = 0;
%start_node.children = [];

open_list = [open_list, start_node];

while ~isempty(open_list)
    search_node = open_list(1);
    pop_index = 1;
    for i = 1:length(open_list)
        if open_list(i).cost < search_node.cost
            search_node = open_list(i);
            pop_index = i;
        end
    end
    open_list(pop_index) = [];
    
    for j = 1:3
       successor.state = CS4300_Wumpus_transition(search_node.state,j,board);
       board_state = board(successor.state(1),successor.state(2));
       if board_state ~= 1
           successor.parent = search_node;
           successor.action = j;
           prev_cost = search_node.cost + (j == 1);
           added_cost = feval(h_name, successor.state, goal);
           successor.cost = prev_cost + added_cost;

           if successor.state(1) == goal(1) && ...
               successor.state(2) == goal(2)
                traceback_node = successor;

               while ~isempty(traceback_node.parent)
                   path = [traceback_node, path];
                   traceback_node = traceback_node.parent;
               end
               path = [traceback_node, path];
               return
           end

           skip = 0;      
           for k = 1:length(open_list)
              open_node = open_list(k);
              if open_node.state(1) == successor.state(1) && ...
                      open_node.state(2) == successor.state(2) && ...
                      open_node.state(3) == successor.state(3) && ...
                      open_node.cost < successor.cost
                 skip = 1;
              end
           end

           for k = 1:length(closed_list)
               closed_node = closed_list(k);
               if closed_node.state(1) == successor.state(1) && ...
                      closed_node.state(2) == successor.state(2) && ...
                      closed_node.state(3) == successor.state(3) && ...
                      closed_node.cost < successor.cost
                 skip = 1;
               end
           end

           if skip == 0
               open_list = [open_list, successor];
           end
       end
    end
    
    closed_list = [closed_list, search_node];
    
end

end

