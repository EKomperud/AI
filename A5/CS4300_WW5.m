function [scores,traces] = CS4300_WW5(max_steps,f_name,boards)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

len = length(boards);
scores = zeros(250,1);
traces(len).trace = 0;

for b = 1:len
    [score, trace] = CS4300_WW1(max_steps,f_name,boards(b).board);
    scores(b) = score;
    traces(b).trace = trace;
    disp(b);
end


end

