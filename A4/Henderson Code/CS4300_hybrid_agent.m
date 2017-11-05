function action = CS4300_hybrid_agent(percept)
% CS4300_hybrid_agent - hybrid random and logic-based agent
% On input:
%   percept( 1x5 Boolean vector): percepts
% On output:
%   action (int): action selected by agent
%    FORWARD = 1;
%    ROTATE_RIGHT = 2;
%    ROTATE_LEFT = 3;
%    GRAB = 4;
%    SHOOT = 5;
%    CLIMB = 6;
% Call:
%   a = CS4300_hybrid_agent([0,0,0,0,0]);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

persistent KBi t vars board state safe visited have_gold pits wumpus plan have_arrow wumpus_located moved;
if isempty(KBi)
    [KB, KBi, vars] = BR_gen_KB;
    t = 0;
    state(1) = 1;
    state(2) = 1;
    state(3) = 0;
    board = [1,1,1,1; 1,1,1,1;1,1,1,1;0,1,1,1];
    pits = zeros(4,4);
    pits(4,1) = 0;
    wumpus = zeros(4,4);
    wumpus(4,1) = 0;
    visited = zeros(4,4);
    visited(4,1) = 1;
    safe = -ones(4,4);
    safe(4,1) = 1;
    wumpus_located = 0;
    have_gold = 0;
    have_arrow = 1;
    moved = 1;
end

% B:1-16, G:17-32, P:33-48, S:49-64, W:65-80


if moved == 1 && have_gold == 0
    percept_sentence = CS4300_make_percept_sentence(percept, state(1), state(2));
    tell_sentence(1).clauses = percept_sentence(1).clauses;
    tell_sentence(2).clauses = percept_sentence(2).clauses;
    tell_sentence(3).clauses = percept_sentence(3).clauses;
    KBi = CS4300_Tell(KBi, tell_sentence);
    
    pos = 32 + ((state(1) - 1)*4) + (state(2));
    up(1).clauses = -(pos + 1);
    up(2).clauses = -(pos + 32 + 1);
    upN(1).clauses = (pos + 1);
    upN(2).clauses = (pos + 32 + 1);
    right(1).clauses = -(pos + 4);
    right(2).clauses = -(pos + 32 + 4);
    rightN(1).clauses = (pos + 4);
    rightN(2).clauses = (pos + 32 + 4);
    down(1).clauses = -(pos - 1);
    down(2).clauses = -(pos + 32 - 1);
    downN(1).clauses = (pos - 1);
    downN(2).clauses = (pos +  32 - 1);
    left(1).clauses = -(pos - 4);
    left(2).clauses = -(pos + 32 - 4);
    leftN(1).clauses = (pos - 4);
    leftN(2).clauses = (pos + 32 - 4);
    tic
    if state(2) < 4 && safe(5 - (state(2)) - 1, state(1)) == -1 && have_gold == 0
        up1 = CS4300_Ask(KBi, up, vars);
        up2 = CS4300_Ask(KBi, upN, vars);
        if up1 == 1
            safe(5 - state(2) - 1, state(1)) = 1;
            board(5 - state(2) - 1, state(1)) = 0;
        elseif up2 == 1
            safe(5 - state(2) - 1, state(1)) = 0;
            board(5 - state(2) - 1, state(1)) = 1;
        else
            safe(5 - state(2) - 1, state(1)) = -1;
        end
    end
    if state(1) < 4 && safe(5 - state(2), state(1) + 1) == -1 && have_gold == 0
        right1 = CS4300_Ask(KBi, right, vars);
        right2 = CS4300_Ask(KBi, rightN, vars);
        if right1 == 1
            safe(5 - state(2), state(1) + 1) = 1;
            board(5 - state(2), state(1) + 1) = 0;
        elseif right2 == 1
            safe(5 - state(2), state(1) + 1) = 0;
            board(5 - state(2), state(1) + 1) = 1;
        else
            safe(5 - state(2), state(1) + 1) = -1;
        end
    end
    if state(2) > 1 && safe(5 - (state(2)+1), state(1)) == -1 && have_gold == 0
        down1 = CS4300_Ask(KBi, down, vars);
        down2 = CS4300_Ask(KBi, downN, vars);
        if down1 == 1
            safe(5 - state(2)+1, state(1)) = 1;
            board(5 - state(2)+1, state(1)) = 0;
        elseif down2 == 1
            safe(5 - state(2)+1, state(1)) = 0;
            board(5 - state(2)+1, state(1)) = 1;
        else
            safe(5 - state(2)+1, state(1)) = -1;
        end
    end
    if state(1) > 1 && safe(5 - state(2), state(1) - 1) == -1 && have_gold == 0
        left1 = CS4300_Ask(KBi, left, vars);
        left2 = CS4300_Ask(KBi, leftN, vars);
        if left1 == 1
            safe(5 - state(2), state(1) - 1) = 1;
            board(5 - state(2), state(1) - 1) = 0;
        elseif left2 == 1
            safe(5 - state(2), state(1) - 1) = 0;
            board(5 - state(2), state(1) - 1) = 1;
        else
            safe(5 - state(2), state(1) - 1) = -1;
        end
    end
    t = toc;
end

% Found the gold! Pick it up and go home
if percept(3) == 1 && have_gold == 0
    [solution, nodes] = CS4300_Wumpus_A_star(board, state, [1,1,1], 'CS4300_A_star_Man');
    plan = [[state(1),state(2),state(3),4]; solution; [1,1,1,6]];
    have_gold = 1;
end

% Pick a safe location to explore
if isempty(plan)
    destination = CS4300_pick_one(safe, visited);
    if ~isempty(destination)
        [route_plan, nodes] = CS4300_Wumpus_A_star(board, state, destination, 'CS4300_A_star_Man');
        plan = route_plan;
    end
end

% Kill that fuckin Wumpus
if isempty(plan) && have_arrow == 1
    do_nothing = 0;
end

% Pick a location that isn't known to be unsafe
if isempty(plan)
    destination = CS4300_pick_one2(safe, visited);
    if ~isempty(destination)
        [route_plan, nodes] = CS4300_Wumpus_A_star(board, state, destination, 'CS4300_A_star_Man');
        plan = route_plan;
    end
end

% Give up
if isempty(plan)
    [route_plan, nodes] = CS4300_Wumpus_A_star(safe, state, [1,1,1], 'CS4300_A_star_Man');
    plan = [route_plan; [1,1,1,6]];
end

action = plan(1,4);
plan(1,:) = [];
if action == 0
    action = plan(1,4);
    plan(1,:) = [];
end

if action == 1
    moved = 1;
else
    moved = 0;
end

state = CS4300_Wumpus_transition(state, action, board);
visited((5 - state(2)), state(1)) = 1;
t = t+1;

end

