function match = CS4300_board_match(b1,b2)
% 

match = 1;
for y = 4:-1:1
    for x = 1:4
        if b1(y,x) ~= -1 && b1(y,x) ~= b2(y,x)
            match = 0;
            return
        end
    end
end
return;

end

