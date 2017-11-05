function time = CS4300_A3_Driver

% A driver for timing operations of A3
% No input
% On outpt:
%   Time:
%   The time in seconds taken to run RTP 500 times
% Call:
% time = CS4300_A3_Driver;
% Author:
% Eric Komperud
% UU
% Fall 2017
%

vars = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

num_statements = 14;
con_length = 2;
thm_length = 1;

% total length = (num_statements) + (num_statements + (con_length - 1) -
% thm_length) + thm_length

statements((num_statements*2) + (con_length - 1) - thm_length).clauses = 1;

t = 1;
while t <= 500

time = 0;
setup = 0;

tic;

for i = 1:num_statements
    statement = [];
    for i2 = 1:con_length
        neg = randi(2);
        if neg == 2
            neg = 1;
        else
            neg = -1;
        end
        statement(i2) = neg * vars(i+i2-1);
    end
    statements(i).clauses = statement;
end

for j = i+1: (i + num_statements + (con_length-1) - thm_length)
    neg = randi(2);
    if neg == 2
        neg = 1;
    else
        neg = -1;
    end
    statements(j).clauses = neg * vars(j-num_statements);
end

thm(thm_length).clauses = 1;
for k = j+1: (j+thm_length)
    neg = randi(2);
    if neg == 2
        neg = 1;
    else
        neg = -1;
    end
   thm(k-(num_statements*2)).clauses =  neg * vars(k-num_statements);
end

setup = setup + toc;

CS4300_RTP(statements, thm, vars);

time = time + toc;
t = t+1;

end

time = time - setup;

end

