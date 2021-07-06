function [cell_img, valid] = search_similar_border(cell_img, coord, border_dir, valid)
% search_similar_border
% cell_img: Celda matricial con elementos matriciales
% coord: Posición de la matriz central en cell_img
% border_dir: Cadena que indica que borde se analiza
% valid: Matriz que valida si una matriz ya fue ubicada en cell_img

x = coord(1); y = coord(2);

[f, c, ~] = size(cell_img{x, y});

[n, ~] = size(cell_img);

min_dE = 1000000000; % Asigo un dummy value alto para comparar

switch border_dir
    case 'top'
        b1 = get_border(1, 'col', cell_img{x, y});
    case 'right'
        b1 = get_border(c, 'row', cell_img{x, y});
    case 'bottom'
        b1 = get_border(f, 'col', cell_img{x, y});
    case 'left'
        b1 = get_border(1, 'row', cell_img{x, y});
end

for i=1:n
    for j=1:n
        switch border_dir
            case 'top'
                b2 = get_border(f, 'col', cell_img{i, j});
            case 'right'
                b2 = get_border(1, 'row', cell_img{i, j});
            case 'bottom'
                b2 = get_border(1, 'col', cell_img{i, j});
            case 'left'
                b2 = get_border(c, 'row', cell_img{i, j});
        end

        sum_dE = sum(imcolordiff(b1, b2));
        
        if sum_dE < min_dE
            if valid(i, j) == 0
                min_dE = sum_dE;
                pos = [i, j]; % Ubicacion de la matriz que puede ser vecino
            end
        end
    end
end

aux = cell_img{pos(1), pos(2)};
switch border_dir
    case 'top'
        cell_img{pos(1), pos(2)} = cell_img{x-1, y};
        cell_img{x-1, y} = aux;
        valid(x-1, y) = 1;
    case 'right'
        cell_img{pos(1), pos(2)} = cell_img{x, y+1};
        cell_img{x, y+1} = aux;
        valid(x, y+1) = 1;
    case 'bottom'
        cell_img{pos(1), pos(2)} = cell_img{x+1, y};
        cell_img{x+1, y} = aux;
        valid(x+1, y) = 1;
    case 'left'
        cell_img{pos(1), pos(2)} = cell_img{x, y-1};
        cell_img{x, y-1} = aux;
        valid(x, y-1) = 1;
end


end

