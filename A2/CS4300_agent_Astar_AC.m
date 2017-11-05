function action = CS4300_agent_Astar_AC(percept)
% CS4300_agent_Astar_AC - A* search agent with AC
% Uses A* to find best path back to start and AC to avoid trouble
% On input:
% percept (1x5 Boolean vector): percept values
% (1): Stench
% (2): Breeze
% (3): Glitters
% (4): Bumped
% (5): Screamed
% On output:
% action (int): action selected by agent
% FORWARD = 1;
% ROTATE_RIGHT = 2;
% ROTATE_LEFT = 3;
% GRAB = 4;
% SHOOT = 5;
% CLIMB = 6;
% Call:
% a = CS4300_agent_Astar_AC([0,0,0,0,0]);
% Author:
% Eric Komperud
% U0844210
% Fall 2017
%

persistent state board travel_plans travel_iterator gold visit_board to_be_visited;

if isempty(state)
    state = [1 1 0];
    board = [ 0 3 3 3 ; 3 3 3 3 ; 3 3 3 3 ; 3 3 3 3 ];
    gold = false;
    visit_board = [ 1 0 0 0 ; 0 0 0 0 ; 0 0 0 0 ; 0 0 0 0 ];
    to_be_visited = [];
    travel_iterator = 0;
end

action = 0;
FORWARD = 1;
ROTATE_RIGHT = 2;
ROTATE_LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

%perceive!

visit_board( state(1), state(2) ) = 1;
for i = 1:length(to_be_visited)
    if to_be_visited(i).x == state(1) && to_be_visited(i).y == state(2)
        to_be_visited(i) = [];
        break;
    end
end

if state(1) == 1 && state(2) == 1 && gold == true
    action = CLIMB;
    return
end

if percept(3) == 1 && gold == false
    [travel_plans, nodes] = CS4300_Wumpus_A_star(board,state,[1,1], "CS4300_Manhattan_Distance");
    action = GRAB;
    travel_iterator = 1;
    gold = true;
    return
end

if percept(2) == 0 && gold == false
    if (state(1) < 4)
        board( state(1) + 1, state(2) ) = 0; 
        if visit_board( state(1)+1 , state(2) ) == 0
            loc.x = state(1)+1;
            loc.y = state(2);
            to_be_visited = [to_be_visited; loc ];
        end
    end
    if (state(1) > 1)
        board( state(1) - 1, state(2) ) = 0; 
        if visit_board( state(1)-1 , state(2) ) == 0
            loc.x = state(1)-1;
            loc.y = state(2);
            to_be_visited = [to_be_visited; loc ];
        end
    end
    if (state(2) < 4)
        board( state(1), state(2) + 1 ) = 0; 
        if visit_board( state(1) , state(2)+1 ) == 0
            loc.x = state(1);
            loc.y = state(2)+1;
            to_be_visited = [to_be_visited; loc ];
        end
    end
    if (state(2) > 1)
        board( state(1), state(2) - 1 ) = 0; 
        if visit_board( state(1) , state(2)-1 ) == 0
            loc.x = state(1);
            loc.y = state(2)-1;
            to_be_visited = [to_be_visited; loc ];
        end
    end
    
elseif percept(2) == 1 && gold == false
    if (state(1) < 4)
        board( state(1) + 1 ) = board( state(1) + 1 ) == 3; 
    end
    if (state(1) > 1)
        board( state(1) - 1 ) = board( state(1) - 1 ) == 3; 
    end
    if (state(2) < 4)
        board( state(2) + 1 ) = board( state(2) + 1 ) == 3; 
    end
    if (state(2) > 1)
        board( state(2) - 1 ) = board( state(2) - 1 ) == 3; 
    end
end

if travel_iterator > 0 && travel_iterator < size(travel_plans,1)
    action = travel_plans(travel_iterator, 4);
    travel_iterator = travel_iterator + 1;
    if travel_iterator > size(travel_plans,1)
        travel_iterator = 0;
    end

else
    if ~isempty(to_be_visited)
        [travel_plans, nodes] = CS4300_Wumpus_A_star(board,state,[to_be_visited(1).x,to_be_visited(1).y],...
            "CS4300_Manhattan_Distance");
        travel_iterator = 1;
        if ~isempty(travel_plans)
            action = travel_plans(travel_iterator, 4);
            travel_iterator = travel_iterator + 1;
            if travel_iterator > size(travel_plans,1)
                travel_iterator = 0;
            end
        end
    else
        action = randi(3);
    end
end

if action == FORWARD
    if (state(3) == 0 && state(1) ~= 4)
        state(1) = state(1) + 1;
    elseif (state(3) == 1 && state(2) ~= 4)
        state(2) = state(2) + 1;
    elseif (state(3) == 2 && state(1) ~= 1)
        state(1) = state(1) - 1;
    elseif (state(3) == 3 && state (2) ~= 1)
        state(2) = state(2) - 1;
    end

elseif action == ROTATE_RIGHT
    state(3) = state(3) - 1;
    if state(3) < 0
        state(3) = 3;
    end

elseif action == ROTATE_LEFT
    state(3) = state(3) + 1;
    if state(3) > 3
        state(3) = 0;
    end
end
    
end

