function bool = CS4300_unique(sentences, new_clause)

% Helper function used to determine if a clause
% already exists in a collection of clauses
% On input:
%   sentences: A collection of clauses
%   new_clause: A single clause to be checked for existence in sentences
% On output:
%   bool: 1 or 0 if new_clause is or isn't unique
% Call:
% unique = CS4300_unique(Knowledge_Base,new_clause);
% Author:
% Eric Komperud
% UU
% Fall 2017
%

bool = 1;

for i = 1:length(sentences)
   s_clause = sentences(i).clauses;
   if length(s_clause) == length(new_clause)
       for j = 1:length(s_clause)
          if s_clause(j) ~= new_clause(j)
              break
          else
              if j == length(s_clause)
                 bool = 0;
                 return
              end
          end
       end
   end
end

end

