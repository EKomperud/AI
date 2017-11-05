function Sip = CS4300_RTP(sentences,thm,vars)

% CS4300_RTP - resolution theorem prover
% On input:
% sentences (CNF data structure): array of conjuctive clauses
% (i).clauses
% each clause is a list of integers (- for negated literal)
% thm (CNF datastructure): a disjunctive clause to be tested
% vars (1xn vector): list of variables (positive integers)
% On output:
% Sip (CNF data structure): results of resolution
% []: proved sentence |- thm
% not []: thm does not follow from sentences
% Call: (example from Russell & Norvig, p. 252)
% DP(1).clauses = [-1,2,3,4];
% DP(2).clauses = [-2];
% DP(3).clauses = [-3];
% DP(4).clauses = [1];
% thm(1).clauses = [4];
% vars = [1,2,3,4];
% Sr = CS4300_RTP(DP,thm,vars);
% Author:
% Eric Komperud
% UU
% Fall 2017
%

negThm(length(thm)).clauses = 1;
for j = 1:length(thm)
   negThm(j).clauses = (-thm(j).clauses); 
end

sentences = [sentences, negThm];
newClauses.clauses = 1;
n = 1;
Sip = [];
l = 2;

while (true)
    L = length(sentences);
    for i = 1:L
        if i == l
           l = l+1; 
        end
       for j = l:L
            resolvent = CS4300_resolve(sentences(i),sentences(j));
            resolvent = sort(resolvent);
            if length(resolvent) == 1 && resolvent(1) == 0
                Sip = [];
                return
            end
            if ~isempty(resolvent) && CS4300_unique(newClauses, resolvent)
                newClauses(n).clauses = resolvent;
                n = n + 1;
            end
       end
    end
    for m = 1:length(newClauses)
       if CS4300_unique(sentences, newClauses(m).clauses)
          sentences = [sentences, newClauses(m)];
          l = L+1;
       end
    end
    if (length(sentences) == L)
        Sip = sentences;
        return
    end
    
end

end

