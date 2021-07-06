function [border] = get_border(elem, row_or_col, M)
% get_border
% elem: Número entero positivo que indica que fila o columna extraer
% row_or_col: Cadena que determina si se toman todas las filas o columnas
% M: Matriz para extraer fila o columna

if row_or_col == "row"
    border(:, :, 1) = M(:, elem, 1);
    border(:, :, 2) = M(:, elem, 2);
    border(:, :, 3) = M(:, elem, 3);
else
    border(:, :, 1) = M(elem, :, 1);
    border(:, :, 2) = M(elem, :, 2);
    border(:, :, 3) = M(elem, :, 3);
end

end

