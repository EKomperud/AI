function [pits,wumps] = CS4300_gen_percept_boards(board)
% 

pits = zeros(4,4);
wumps = zeros(4,4);
for y = 1:4
    for x = 1:4
        agent.x = x;
        agent.y = 5 - y;
        percept = CS4300_get_percept(board,agent,0,0);
        if percept(2) == 1
            pits(y,x) = 1;
        end
        if percept(1) == 1
            wumps(y,x) = 1;
        end
    end
end

return;

end

