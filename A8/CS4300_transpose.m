function transposition = CS4300_transpose(board, rows, cols)
% Given a N length vector, this will transpose it into a rows X cols 
% matrix, assuming rows * cols equals N
%
% Input: 
%   board (vector): A vector of anything
%   rows (int): Number of rows in the transposition
%   cols (int): Number of columnss in the transposition
%
% Output:
%   transposition (rows X cols vector)
%
% Call:
%   Policy_transposed = CS4300_transpose(policy, 4, 4);
%
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

transposition = zeros(rows,cols);
for t = 1:length(board)
    a = abs(idivide(t-1,int32(cols)) - rows);
    b = mod(t,cols);
    if b == 0
        b = cols;
    end
    transposition(a,b) = board(t);
end

end

