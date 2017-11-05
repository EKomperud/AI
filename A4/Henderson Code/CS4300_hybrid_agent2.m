function action = CS4300_hybrid_agent2(percept)
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
    [KB, KBi, vars] = CS4300_gen_KB;
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
    safe = -ones(4,4);
    safe(4,1) = 1;
    wumpus_located = 0;
    have_gold = 0;
    have_arrow = 1;
    moved = 1;
end

% B:1-16, G:17-32, P:33-48, S:49-64, W:65-80

percept_sentence = CS4300_make_percept_sentence2(percept, state(1), state(2));
tell_sentence(1).clauses = percept_sentence(1).clauses;
tell_sentence(2).clauses = percept_sentence(2).clauses;
tell_sentence(3).clauses = percept_sentence(3).clauses;
%KBi = CS4300_Tell(KBi, tell_sentence);
if have_gold == 0
    neighbors = 0;
    known_neighbors = 0;
    unknown_neighbors = [];
    visit = visited(5 - state(2), state(1));

    if state(2) < 4
        neighbors = neighbors + 1;
        
        if visit == 0
            if percept(1) == 1
                wumpus(5 - (state(2)+1), state(1)) = wumpus(5 - (state(2)+1), state(1)) - 1;
            else
                wumpus(5 - (state(2)+1), state(1)) = wumpus(5 - (state(2)+1), state(1)) + 1;
            end
            if percept(2) == 1
                pits(5 - (state(2)+1), state(1)) = pits(5 - (state(2)+1), state(1)) - 1;
            else
                pits(5 - (state(2)+1), state(1)) = pits(5 - (state(2)+1), state(1)) + 1;
            end
        end
        
        if pits(5 - (state(2)+1), state(1)) >= 0 && wumpus(5 - (state(2)+1), state(1)) >= 0
            safe(5 - (state(2)+1), state(1)) = 1;
            board(5 - (state(2)+1), state(1)) = 0;
        end
        
        if safe(5 - (state(2)+1), state(1)) == -1
            unknown_neighbors = [unknown_neighbors; [5 - (state(2)+1), state(1)]];
        else
            known_neighbors = known_neighbors + 1;
        end
    end
    
    if state(1) < 4
        neighbors = neighbors + 1;
        
        if visit == 0
            if percept(1) == 1
                wumpus(5 - state(2), state(1) + 1) = wumpus(5 - state(2), state(1) + 1) - 1;
            else
                wumpus(5 - state(2), state(1) + 1) = wumpus(5 - state(2), state(1) + 1) + 1;
            end        
            if percept(2) == 1
                pits(5 - state(2), state(1) + 1) = pits(5 - state(2), state(1) + 1) - 1;
            else
                pits(5 - state(2), state(1) + 1) = pits(5 - state(2), state(1) + 1) + 1;
            end
        end
        
        if pits(5 - state(2), state(1) + 1) >= 0 && wumpus(5 - state(2), state(1) + 1) >= 0
            safe(5 - state(2), state(1) + 1) = 1;
            board(5 - state(2), state(1) + 1) = 0;
        end
        
        if safe(5 - (state(2)+1), state(1)) == -1
            unknown_neighbors = [unknown_neighbors; [5 - (state(2)+1), state(1)]];
        else
            known_neighbors = known_neighbors + 1;
        end
    end
    
    if state(2) > 1
        neighbors = neighbors + 1;
        
        if visit == 0
            if percept(1) == 1
                wumpus(5 - (state(2)-1), state(1)) = wumpus(5 - (state(2)-1), state(1)) - 1;
            else
                wumpus(5 - (state(2)-1), state(1)) = wumpus(5 - (state(2)-1), state(1)) + 1;
            end      
            if percept(2) == 1
                pits(5 - (state(2)-1), state(1)) = pits(5 - (state(2)-1), state(1)) - 1;
            else
                pits(5 - (state(2)-1), state(1)) = pits(5 - (state(2)-1), state(1)) + 1;
            end
        end
        
        if pits(5 - (state(2)-1), state(1)) >= 0 && wumpus(5 - (state(2)-1), state(1)) >= 0
            safe(5 - (state(2)-1), state(1)) = 1;
            board(5 - (state(2)-1), state(1)) = 0;
        end
        
        if safe(5 - (state(2)+1), state(1)) == -1
            unknown_neighbors = [unknown_neighbors; [5 - (state(2)+1), state(1)]];
        else
            known_neighbors = known_neighbors + 1;
        end
    end
    
    if state(1) > 1
        neighbors = neighbors + 1;
        
        if visit == 0
            if percept(1) == 1
                wumpus(5 - state(2), state(1) - 1) = wumpus(5 - state(2), state(1) - 1) - 1;
            else
                wumpus(5 - state(2), state(1) - 1) = wumpus(5 - state(2), state(1) - 1) + 1;
            end        
            if percept(2) == 1
                pits(5 - state(2), state(1) - 1) = pits(5 - state(2), state(1) - 1) - 1;
            else
                pits(5 - state(2), state(1) - 1) = pits(5 - state(2), state(1) - 1) + 1;
            end
        end
        
        if pits(5 - state(2), state(1) - 1) >= 0 && wumpus(5 - state(2), state(1) - 1) >= 0 
            safe(5 - state(2), state(1) - 1) = 1;
            board(5 - state(2), state(1) - 1) = 0;
        end
        
        if safe(5 - (state(2)+1), state(1)) == -1
            unknown_neighbors = [unknown_neighbors; [5 - (state(2)+1), state(1)]];
        else
            known_neighbors = known_neighbors + 1;
        end
    end
    
    if neighbors - known_neighbors == 1
        safe(unknown_neighbors(1),unknown_neighbors(2)) = 0;
    end
    visited((5 - state(2)), state(1)) = 1;
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

t = t+1;

end

