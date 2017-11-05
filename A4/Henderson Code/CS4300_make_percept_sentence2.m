function sentence = CS4300_make_percept_sentence2(percept,x,y)
% CS4300_make_percept_sentence - create logical sentence from percept
% On input:
%   percept (1x5 Boolean vector): percept
%       [Stench, Breeze, Glitter, Scream, Bump]
%   x (int): x location of agent
%   y (int): y location of agent
% On output:
%   sentence (KB struct): logical sentence (CNF)
%       (1).clauses (int): c1 (index of Sxy if stench), else -c1
%       (2).clauses (int): c2 (index of Bxy if breeze), else -c2
%       (3).clauses (int): c3 (index of Gxy if glitter), else -c3
%       (4).clauses (int): c4 (index of Cxy if scream), else -c4
%       (5).clauses (int): c5 (index of Exy if bump), else -c5
% Call:
%   s = CS4300_make_percept_sentence([0,1,0,0,0],3,2);
% Author:
%   Eric Komperud
%   U0844210
%   Fall 2017
%

sentence(5).clauses = 1;
coordinate = ((y-1) * 4) + x; 

for p = 1:5
   if ~percept(p)
      percept(p) = -1; 
   end
end

sentence(1).clauses = (coordinate + 48) * percept(1); % stench
sentence(2).clauses = (coordinate + 00) * percept(2); % breeze
sentence(3).clauses = (coordinate + 16) * percept(3); % glitter
sentence(4).clauses = (coordinate) * percept(4); % scream
sentence(5).clauses = (coordinate) * percept(5); % bump

end

