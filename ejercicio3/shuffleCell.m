function cell_img = shuffleCell(cell, N, n)
%SHUFFLE Summary of this function goes here
%   Detailed explanation goes here
    sh = randperm(N);
    sort(sh);
    new_cell = cell(sh);
    x = 1;
    for i=1:n
        for j=1:n
            cell_img{i, j} = new_cell{1, x};
            x = x + 1;
        end
    end
end

