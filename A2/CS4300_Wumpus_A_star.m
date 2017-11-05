function [solution,nodes] = CS4300_Wumpus_A_star(board,initial_state,goal_state,h_name)
% CS4300_Wumpus_A_star - A* algorithm for Wumpus world
% On input:
% board (4x4 int array): Wumpus board layout
% 0: means empty cell
% 1: means a pit in cell
% 2: means gold (only) in cell
% 3: means Wumpus (only) in cell
% 4: means gold and Wumpus in cell
% initial_state (1x3 vector): x,y,dir state
% goal_state (1x3 vector): x,y,dir state
% h_name (string): name of heuristic function
% On output:
% solution (nx4 array): solution sequence of state and the action
% nodes (search tree data structure): search tree
% (i).parent (int): index of node’s parent
% (i).level (int): level of node in search tree
% (i).state (1x3 vector): [x,y,dir] state represented by node
% (i).action (int): action along edge from parent to node
% (i).g (int): path length from root to node
% (i).h (float): heuristic value (estimate from node to goal)
% (i).cost (float): g + h (called f value in text)
% (i).children (1xk vector): list of node’s children
% Call:
%[so,no] = CS4300_Wumpus_A_star1([0,0,0,0;0,0,0,1;0,2,1,3;0,0,0,0],...
% [1,1,0],[2,2,1],’CS4300_A_star_Man’)
% so =
% 1 1 0 0
% 2 1 0 1
% 2 1 1 3
% 2 2 1 1
%
% no = 1x9 struct array with fields:
% parent
% level
% state
% action
% cost
% g
% h
% children
% Author:
% Eric Komperud
% U0844210
% Fall 2017
%

open_list = [];
closed_list = [];
solution = [];
nodes = [];

start_node.parent = [];
start_node.state = initial_state;
start_node.action = 0;
start_node.level = 0;
start_node.cost = 0;
start_node.children = [];
num_nodes = 1;
open_list = [open_list, start_node];
%all_list = [open_list, start_node];
while ~isempty(open_list)
    node = open_list(1);
    pop_index = 1;
    for i = 1:length(open_list)
        if open_list(i).cost < node.cost
            node = open_list(i);
            pop_index = i;
        end
    end
    
    closed_list = [closed_list, open_list(pop_index)];
    open_list(pop_index) = [];
    
    successors = [];
    for action = 1:3
        next_state = CS4300_Wumpus_transition(node.state,...
            action,board);
        next_square = board(next_state(1),next_state(2));
        if next_square < 3
            repeat = CS4300_Wumpus_new_state(next_state,open_list,closed_list,...
                    nodes);
            if repeat == 0  
                new_node.parent = node;
                new_node.state = next_state;
                new_node.action = action;
                new_node.level = node.level + 1;
                new_node.cost = node.cost + 1 + feval(h_name, next_state, [0,0,0]);
                new_node.children = [];
                successors = [successors, new_node];
            elseif repeat < 0
                new_cost = node.cost + 1 + feval(h_name, node.state, [0,0,0]);
                if open_list(-repeat).cost > new_cost
                   new_node.parent = node;
                   new_node.state = next_state;
                   new_node.action = action;
                   new_node.level = node.level + 1;
                   new_node.cost = new_cost;
                   new_node.children = [];
                   successors = [successors, new_node];
                   open_list(-repeat) = new_node;
                end
            elseif repeat > 0
                new_cost = node.cost + 1 + feval(h_name, node.state, [0,0,0]);
                if closed_list(repeat).cost > new_cost
                   new_node.parent = node;
                   new_node.state = next_state;
                   new_node.action = action;
                   new_node.level = node.level + 1;
                   new_node.cost = new_cost;
                   new_node.children = [];
                   successors = [successors, new_node];
                   %closed_list(repeat) = new_node;
                end
            end
        end
    end
    
    for j = 1:length(successors)
        if successors(j).state(1) == goal_state(1) && successors(j).state(2) == goal_state(2)
            solution = [successors(j).parent.state, successors(j).action];
            traceback_node = successors(j).parent;
            while ~isempty(traceback_node.parent)
                solution = [traceback_node.parent.state, traceback_node.action; solution];
                traceback_node = traceback_node.parent;
            end
            return
        end
    end
    
    open_list = [open_list, successors];
        
end

% nodes(1).parent = [];
% nodes(1).level = 0;
% nodes(1).state = initial_state;
% nodes(1).action = 0;
% nodes(1).cost = 0;
% nodes(1).children = [];
% num_nodes = 1;
% frontier = ( nodes(1) );
% explored = [];
% while 1==1
%     if isempty(frontier)
%         solution = [];
%         return
%     end
%     node = frontier(1);
%     for i = 1:length(frontier)
%         if frontier(i).cost > node.cost
%             node = frontier(i);
%         end
%     end
%     frontier = frontier(2:end);
%     explored = [explored,node];
%     if CS4300_Wumpus_solution(board, node.state, goal_state) % nodes(node).state
%         solution = CS4300_traceback(nodes,node);
%         return
%     end
%     next_list = [];
%     for action = 1:3
%         next_state = CS4300_Wumpus_transition(node.state,...
%             action,board);
%         if next_state(1)>0 ...
%             && CS4300_Wumpus_new_state(next_state,frontier,explored,...
%                 nodes)
%             num_nodes = num_nodes + 1;
%             nodes(num_nodes).parent = node;
%             nodes(num_nodes).level = node.level + 1;
%             nodes(num_nodes).state = next_state;
%             nodes(num_nodes).action = action;
%             nodes(num_nodes).cost = node.cost + 1 + feval(h_name, node.state, [0,0,0]);
%             nodes(num_nodes).children = [];
%             node.children = [node.children,num_nodes];
%             next_list = [nodes(num_nodes),next_list];
%         end
%     end
%     frontier = [next_list, frontier]; %next_list(end:1:-1)
% end

end

