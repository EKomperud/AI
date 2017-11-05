function shot_state = CS4300_find_location_to_shoot(board,wumpus_loc,agent_loc)
%

Y = wumpus_loc(2);
X = wumpus_loc(1);
shot_state = [0,0,0];
distance = 100;
for x = 1:4
    if board(5-Y,x) == 0
        if CS4300_A_star_Man([x,Y,0],[agent_loc(1),agent_loc(2),0]) < distance
            shot_state = [x,Y,0];
            distance = CS4300_A_star_Man([x,Y,0],[agent_loc(1),agent_loc(2),0]);
            if shot_state(1) < X
                shot_state(3) = 0;
            else
                shot_state(3) = 2;
            end
        end
    end
end

for y = 1:4
    if board(5-y,X) == 0
        if CS4300_A_star_Man([X,y,0],[agent_loc(1),agent_loc(2),0]) < distance
            shot_state = [X,y,0];
            distance = CS4300_A_star_Man([X,y,0],[agent_loc(1),agent_loc(2),0]);
            if shot_state(2) < Y
                shot_state(3) = 1;
            else
                shot_state(3) = 3;
            end
        end
    end
end

return;

end

