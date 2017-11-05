function new_clause = CS4300_resolve(clause1,clause2)

% Helper function used to resolve two clauses
% On input:
%   clause1: A single disjunction
%   clause2: A single disjunction
% On output:
%   new_clause: A single disjunction made of the union of clause1 & clause2
% Call:
% unique = CS4300_resolve(clause1,clause2);
% Author:
% Eric Komperud
% UU
% Fall 2017
%

new_clause = [];
clauses1 = clause1(1).clauses;
clauses2 = clause2(1).clauses;
L1 = length(clauses1);
L2 = length(clauses2);


for c1 = 1:L1
    for c2 = 1:L2
        if clauses1(c1) == -clauses2(c2)
            if ~isempty(new_clause)
               new_clause = [];
               return
            end
            clauses1(c1) = 0;
            clauses2(c2) = 0;
            new_clause = unique([clauses1,clauses2]);
        end
    end
end

if length(new_clause) > 1
    L3 = length(new_clause);
    for c3 = 1:L3
        if new_clause(c3) == 0
           new_clause(c3) = [];
           return
        end
    end
end

end

