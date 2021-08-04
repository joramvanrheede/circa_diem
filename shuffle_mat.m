function shuffled_mat = shuffle_mat(in_mat, shuffle_mode)
% function shuffled_mat = shuffle_mat(IN_MAT, SHUFFLE_MODE)
% Shuffles input matrix IN_MAT using Matlab's randperm function.
% 'SHUFFLE_MODE' determines how elements are shuffled:
%   - 'all', all elements of the matrix are shuffled;
%   - 'rows': Each row is shuffled separately; each row retains its data
%   points
%   - 'columns': Each column is shuffled separately; each column retains
%   its data points
% 
% 

% If no mode specified, shuffle all matrix elements 
if nargin < 2
    shuffle_mode = 'all';
end

% Depending on shuffle_mode:
switch shuffle_mode
    case 'all'
        % Shuffle all elements in one go
        
        % Generate a random permutation of 1:[number of elements in in_mat]
        shuffled_inds   = randperm(numel(in_mat));
        
        % Use these to draw out in_mat data points in random order, reshape
        % this into the right size corresponding to in_mat
        shuffled_mat    = reshape(in_mat(shuffled_inds), size(in_mat));
    case 'rows'
        % Shuffle each row separately
        
        % Pre-allocate array of right size
        shuffled_mat    = NaN(size(in_mat));
        
        % For each row
        for a = 1:size(shuffled_mat,1)
            % Generate random permutation of indices to match the number of
            % data points in this row
            shuffled_inds       = randperm(size(in_mat,2));
            
            % Use the indices to draw data points from this in_mat row 
            % reordered into corresponding shuffled_mat row
            shuffled_mat(a,:)   = in_mat(a,shuffled_inds);
        end
    case 'columns'
        % Shuffle each column separately
        
        % Pre-allocate array of right size
        shuffled_mat    = NaN(size(in_mat));
        
        % For each column
        for a = 1:size(shuffled_mat,2)
            % Generate random permutation of indices to match the number of
            % data points in this column
            shuffled_inds       = randperm(size(in_mat,1));
            
            % Use the indices to draw data points from this in_mat column 
            % reordered into corresponding shuffled_mat column
            shuffled_mat(:,a)   = in_mat(shuffled_inds,a);
        end
end

