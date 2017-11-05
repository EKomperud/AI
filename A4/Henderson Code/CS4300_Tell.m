function KB_out = CS4300_Tell(KB,sentence)
% CS4300_Tell - Tell function for logic KB
% On input:
%   KB (KB struct): Knowledge base (CNF)
%       (k).clauses (1xp vector): disjunction clause
%   sentence (KB struct): query theorem (CNF)
%       (k).clauses (1xq vector): disjunction
% On output:
%   KB_out (KB struct): revised KB
% Call:
%   KB = CS4300_Tell([],[1]);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

KB_out = KB;
kb_len = length(KB);

vars = zeros(1,80);
for z = 1:80
    vars(z) = z;
end

for i = 1:length(sentence)
%     repeat = 0;
%     for j = kb_len:-1:402
%         if sentence(i).clauses == KB(j).clauses
%             repeat = 1;
%         end
%     end
%     if repeat == 0
    KB_out(kb_len + i).clauses = sentence(i).clauses;
    %if CS4300_Ask(KB_out, sentence(i), vars) == 0
        sentence(i).clauses = [];
    %end
end

end

