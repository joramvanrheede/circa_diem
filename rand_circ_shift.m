function rand_shifted_mat = rand_circ_shift(in_mat, shift_dim)
% function RAND_SHIFTED_MAT = RAND_CIRC_SHIFT(IN_MAT, SHIFT_DIM)
% 
% Apply random shift to each row or each column of matrix IN_MAT. SHIFT_DIM
% determines whether rows or columns are shifted. Only 2d matrices are
% supported.
% 
% Shifted rows / columns 'wrap around' so that any values shifted out of
% range 
% 

% Default to shifting along first dimension
if nargin < 2
    shift_dim = 1;
end

% Get dimensions of input
n_cols  = size(in_mat,2);
n_rows  = size(in_mat,1);

% Make meshgrids of row and column indices
[col_inds,row_inds]     = meshgrid(1:n_cols,1:n_rows);

switch shift_dim
    case 1 % Shift in first dimension
        % add random integer between 1 and n_rows to each row index
        new_row_inds         	= row_inds + randi([1 n_rows],[1 n_cols]);
        
        % Wrap around by subtracting n_rows from any indices that exceed
        % n_rows
        q_wrap                  = new_row_inds > n_rows;
        new_row_inds(q_wrap)  	= new_row_inds(q_wrap) - n_rows;
        
        % Convert the row and column indices to single linear indices
        lin_inds                = sub2ind([n_rows, n_cols],new_row_inds(:),col_inds(:));
        
        % Use indices to retrieve new values and reshape to match original
        rand_shifted_mat        = reshape(in_mat(lin_inds),[n_rows n_cols]);
    
    case 2 % Shift in second dimension
        new_col_inds        	= col_inds + randi([1 n_cols],[n_rows ,1]);
        
        % Wrap around by subtracting n_cols from any indices that exceed
        % n_cols
        q_wrap                  = new_col_inds > n_cols;
        new_col_inds(q_wrap) 	= new_col_inds(q_wrap) - n_cols;

        % Convert the row and column indices to single linear indices
        lin_inds                = sub2ind([n_rows, n_cols],row_inds(:),new_col_inds(:));

        % Use indices to retrieve new values and reshape to match original
        rand_shifted_mat        = reshape(in_mat(lin_inds),[n_rows n_cols]);
end
