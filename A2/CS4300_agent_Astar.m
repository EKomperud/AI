function action = CS4300_agent_Astar(percept)
% CS4300_agent_Astar - A* search agent example
% Uses A* to find best path back to start
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
% a = CS4300_agent_Astar([0,0,0,0,0]);
% Author:
% Eric Komperud
% U0844210
% Fall 2017
%

persistent state board solution soln_size soln_iterator;

if isempty(state)
    state = [1 1 0];
    board = [ 10 10 10 10 ; 10 10 10 10 ; 10 10 10 10 ; 10 10 10 10 ];
    soln_size = 0;
    soln_iterator = 1;
end

FORWARD = 1;
ROTATE_RIGHT = 2;
ROTATE_LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;

board(round(state(1)),round(state(2))) = percept(2);
%board(1,1) = percept(2);

if soln_size ~= 0
    if soln_iterator <= soln_size
        action = solution(soln_iterator,4);
        soln_iterator = soln_iterator + 1;
    else
        action = CLIMB;
    end

else
    if percept(3)
        board(state(1),state(2)) = 2;
        [solution, nodes] = CS4300_Wumpus_A_star(board,state,[1 1 3], "CS4300_Manhattan_Distance");
        action = GRAB;
        soln_size = size(solution,1);

    else
        choice = rand() * 3;
        if choice >= 0 && choice < 1
            action = FORWARD;
            if (state(3) == 0 && state(1) ~= 4)
                state(1) = state(1) + 1;
            elseif (state(3) == 1 && state(2) ~= 4)
                state(2) = state(2) + 1;
            elseif (state(3) == 2 && state(1) ~= 1)
                state(1) = state(1) - 1;
            elseif (state(3) == 3 && state (2) ~= 1)
                state(2) = state(2) - 1;
            end

        elseif choice >= 1 && choice < 2
            action = ROTATE_RIGHT;
            state(3) = state(3) - 1;
            if state(3) < 0
                state(3) = 3;
            end

        else
            action = ROTATE_LEFT;
            state(3) = state(3) + 1;
            if state(3) > 3
                state(3) = 0;
            end
        end
    end
end