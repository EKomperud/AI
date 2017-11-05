function action = CS4300_MC_agent(percept)
% CS4300_MC_agent - Monte Carlo agent with a few informal rules
% On input:
%   percept (1x5 Boolean vector): percept from Wumpus world
%       (1): stench
%       (2): breeze
%       (3): glitter
%       (4): bump
%       (5): scream
% On output:
%   action (int): action to take
%       1: FORWARD
%       2: RIGHT
%       3: LEFT
%       4: GRAB
%       5: SHOOT+
%       6: CLIMB
% Call:
%   a = CS4300_MC_agent(percept);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017

FORWARD = 1;
RIGHT = 2;
LEFT = 3;
GRAB = 4;
SHOOT = 5;
CLIMB = 6;
debug = "";

persistent plan board visited breezes stenches agent P_pits P_wumps
if isempty(agent)
    agent.x = 1;
    agent.y = 1;
    agent.dir = 0;
    agent.gold = 0;
    agent.arrow = 1;
    agent.smelled_stench = 0;
    agent.heard_scream = 0;
    board = ones(4,4);
    board(4,1) = 0;
    visited = zeros(4,4);
    visited(4,1) = 1;
    breezes = -ones(4,4);
    stenches = -ones(4,4);
end

board(5 - agent.y, agent.x) = 0;


if percept(2) == 1
    breezes(5 - agent.y, agent.x) = 1;
else
    breezes(5 - agent.y, agent.x) = 0;
end

if agent.heard_scream == 0
    if percept(1) == 1
        stenches(5 - agent.y, agent.x) = 1;
        agent.smelled_stench = 1;
    else
        stenches(5 - agent.y, agent.x) = 0;
    end
end

if percept(5) == 1
    stenches = -ones(4,4);
    agent.heard_scream = 1;
end

[p_pits, p_wumps] = CS4300_WP_estimates(breezes,stenches,50);
if p_pits(1) ~= -2
    P_pits = p_pits;
    P_wumps = p_wumps;
end
for y = 4:-1:1
    for x = 1:4
        if P_pits(y,x) == 0 && P_wumps(y,x) == 0
            board(y,x) = 0;
        end
    end
end

if  percept(3) == 1 && agent.gold == 0
    debug = "foung gold";
    state = [agent.x,agent.y,agent.dir];
    [solution, nodes] = CS4300_Wumpus_A_star(board, state, [1,1,1], 'CS4300_A_star_Man');
    plan = [[state(1),state(2),state(3),4]; solution; [1,1,1,6]];
    agent.gold = 1;
end

if isempty(plan)
    debug = "explore safe location";
    destination = CS4300_pick_one(board, visited);
    state = [agent.x,agent.y,agent.dir];
    if ~isempty(destination)
        [route_plan, nodes] = CS4300_Wumpus_A_star(board, state, destination, 'CS4300_A_star_Man');
        plan = route_plan;
    end
end

if isempty(plan) && agent.arrow == 1 && agent.smelled_stench == 1
    debug = "try to kill wumpus";
    wumpus_location = [0,0];
    wumpus_chance = 0;
    for y = 4:-1:1
        for x = 1:4
            if P_wumps(5 - y,x) > wumpus_chance
                wumpus_location = [x,y];
                wumpus_chance = P_wumps(y,x);
            end
        end
    end
    agent_loc = [agent.x, agent.y, agent.dir];
    shot_state = CS4300_find_location_to_shoot(board,wumpus_location,agent_loc);
    [route_plan, nodes] = CS4300_Wumpus_A_star(board,[agent.x,agent.y,agent.dir],shot_state,'CS4300_A_star_Man');
    take_shot = [shot_state, 5];
    plan = [route_plan; take_shot];
    agent.arrow = 0;
end

if isempty(plan)
    debug = "take a risk";
    least_unsafe_location = [0,0,0];
    danger_level = 1;
    for y = 1:4
        for x = 1:4
            if (x ~= agent.x || y ~= agent.y) && board(5-y,x) == 1
                neighbors = CS4300_get_neighbors(x,y);
                is_frontier = 0;
                for i = 1:length(neighbors)
                    if board(5 - neighbors(i,2),neighbors(i,1)) == 0
                        is_frontier = 1;
                    end
                end
                p_danger = max(P_pits(5-y,x),P_wumps(5-y,x));
                if p_danger < danger_level && is_frontier == 1
                    least_unsafe_location = [x,y,0];
                    danger_level = p_danger;
                end
            end
        end
    end
    fake_board = board;
    fake_board(5 - least_unsafe_location(2), least_unsafe_location(1)) = 0;
    [route_plan, nodes] = CS4300_Wumpus_A_star(fake_board,[agent.x,agent.y,agent.dir],least_unsafe_location,'CS4300_A_star_Man');
    plan = route_plan;
end

debug_plan = plan;
action = plan(1,4);
plan(1,:) = [];
if action == 0
    action = plan(1,4);
    plan(1,:) = [];
end

state = CS4300_Wumpus_soft_transition([agent.x,agent.y,agent.dir], action, board);
agent.x = state(1);
agent.y = state(2);
agent.dir = state(3);
visited(5 - agent.y,agent.x) = 1;

end

