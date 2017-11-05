function [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,num_trials)
% CS4300_WP_estimates - estimate pit and Wumpus likelihoods
% On input:
%   breezes (4x4 Boolean array): presence of breeze percept at cell
%       -1: no knowledge
%       0: no breeze detected
%       1: breeze detected
%   stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%       0: no stench detected
%       1: stench detected
%   num_trials (int): number of trials to run (subset will be OK)
% On output:
%   pits (4x4 [0 to 1] array): likelihood of pit in cell
%   Wumpus (4x4 [0 to 1] array): likelihood of Wumpus in cell
% Call:
%   breezes = -ones(4,4);
%   breezes(4,1) = 1;
%   stench = -ones(4,4);
%   stench(4,1) = 0;
%   [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,10000)
% pits = 
%   0.2021  0.1967  0.1956  0.1953
%   0.1972  0.1999  0.2016  0.1980
%   0.5527  0.1969  0.1989  0.2119
%   0.0000  0.5552  0.1948  0.1839
%
% Wumpus = 
%   0.0806  0.0800  0.0827  0.0720
%   0.0780  0.0738  0.0723  0.0717
%   0.0000  0.0845  0.0685  0.0803
%   0.0000  0.0000  0.0741  0.0812
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2016
LIMIT = 20000;
count = 0;
successes = 0;

pits = zeros(4,4);
Wumpus = zeros(4,4);
for i = 1:num_trials
    b = CS4300_gen_board(0.2);
    [p,w] = CS4300_gen_percept_boards(b);
    while (~CS4300_board_match(breezes, p) || ~CS4300_board_match(stench, w)) && ...
            (count < LIMIT || successes == 0)
        b = CS4300_gen_board(0.2);
        [p,w] = CS4300_gen_percept_boards(b);
        count = count + 1;
    end
    successes = successes + 1;
    for y = 1:4
        for x = 1:4
            if b(y,x) == 1 %PIT
                pits(y,x) = pits(y,x) + 1;
            elseif b(y,x) == 3 %WUMP
                Wumpus(y,x) = Wumpus(y,x) + 1;
            end
        end
    end
    if count >= LIMIT
        break;
    end
end

% if successes == 0
%     pits = -2;
%     Wumpus = -2;
% else
    for y = 1:4
        for x = 1:4
            pits(y,x) = pits(y,x) / successes;
            Wumpus(y,x) = Wumpus(y,x) / successes;
        end
    end  
%end

end

