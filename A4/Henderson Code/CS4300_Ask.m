function b = CS4300_Ask(KB,sentence,vars)
% CS4300_Ask - Ask function for logic KB
% On input:
%   KB (KB struct): Knowledge base (CNF)
%       (k).clauses (1xp vector): disjunction clause
%   sentence (KB struct): query theorem (CNF)
%       (k).clauses (1xq vector): disjunction
% On output:
%   b (Boolean): 1 if KB entails sentence, else 0
% Call:
%   KB(1).clauses = [1];
%   KB(2).clauses = [-1,2];
%   sentence(1).clauses = [2];
%   b = CS4300_Ask(KB,sentence);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

Sip = [];
sentence_len = length(sentence);
b = 0;

for i = 1:sentence_len
    Sip = [Sip, CS4300_RTP(KB,sentence(i),vars)];
end

if isempty(Sip)
    b = 1;
end

return

end

