classdef Wumpus_Node
    % Wumpus_Node - A helper class for A* search
    % A simple class to contain
    %   - a position
    %   - a parent
    %   - a path length
    %   - the manhattan length and
    %   - total length
    
    properties
        position
        parent
        path_length
        manhattan_length
        total_length
    end
    
    methods
        function obj = Wumpus_Node()
        end
        
    end
    
end

