% Ejercicio 3 / Puzzle
% Rodriguez Javier Ceferino

%%
% Limpieza
clear, clc, close all

% Variables
N = 16; % Numero de partes
n = sqrt(N);
valid = zeros(4, 4);  % Genero una matriz de 0s para determinar mas adelante si
                      % una pieza del puzzle fue ubicada en su lugar con un 1
valid(2, 3) = 1; % Ya pongo 1 en la semilla para que no se analice sus bordes

% Abro la imagen
[file,dir]=uigetfile('*.bmp;*.jpg;*.png;*.tiff;*.tif');
filename=[dir,file];
info=imfinfo(filename);

% Dependiendo del tipo, la convierto en escala RGB
switch info.ColorType
    case 'grayscale'
        I = imread(filename);
        if islogical(I)
            I = uint8(I);
            I(I==1) = 255;
        end
        I = cat(3, I, I, I);
    case 'truecolor'
        I = imread(filename);
    case 'indexed'
        [I,map] = imread(filename);
        I = ind2rgb(I,map);
end

% Guardo tamanio de imagen y defino tamanio de sub-matrices
% Aplico imresize por si la cantidad de filas y/o columnas es impar
[f, c, z] = size(I);
fnew = f; cnew = c;
if rem(f,2) ~= 0
    fnew = f - 1;
end
if rem(c,2) ~= 0
    cnew = c - 1;
end
I = imresize(I, [fnew, cnew]);
f_sub = fnew/n; c_sub = cnew/n;

% Muestro imagen original
figure
% subplot(1,3,1);
imshow(I); title('Imagen original');

%% GENERACIÓN DEL PUZZLE
% Guardo sub-matrices de la imagen en una cell array
cell_img = mat2cell(I, [f_sub f_sub f_sub f_sub], [c_sub c_sub c_sub c_sub], (z));

% Guardo una submatriz como semilla
seed = cell_img{2,3};

% Uso funcion creada "shuffleCell" y mezclo la imagen en la cell array
cell_img = shuffleCell(cell_img, N, n); % Celda con submatrices desordenadas

% Muestro puzzle
figure
% subplot(1,3,2);
imshow(cell2mat(cell_img)); title('Puzzle (imagen desordenada)');

%% REUBICACIÓN DE LA SEMILLA EN IMAGEN y NUEVA CELDA
% 1) Debo ubicar la posición actual de la semilla luego de desordenarla
% 2) Al encontrarla, la cambio a su posición original, intercambiando submratices
% 3) Muestro intercambio en un plot nuevo

for i = 1:n
    for j = 1:n
        if isequal(seed, cell_img{i, j})
            aux = cell_img{2, 3};
            cell_img{2, 3} = seed;
            cell_img{i, j} = aux;
            break; % Salgo del bucle
        end
    end
end

figure
% subplot(1,3,3);
imshow(cell2mat(cell_img)); title('Ubico la semilla en su pos. original');


%% PRIMERA BUSQUEDA

[cell_img, valid] = search_similar_border(cell_img, [2, 3], 'top', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 3], 'right', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 3], 'bottom', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 3], 'left', valid);

figure
% subplot(1,2,1)
imshow(cell2mat(cell_img)); title('Ubicación de vecinos (1er iteracion)');

%% SEGUNDA BUSQUEDA

[cell_img, valid] = search_similar_border(cell_img, [2, 2], 'top', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 2], 'bottom', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 4], 'top', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 4], 'bottom', valid);

figure
% subplot(1,2,2)
imshow(cell2mat(cell_img)); title('Ubicación de vecinos (2da iteracion)');

%% TERCERA BUSQUEDA

[cell_img, valid] = search_similar_border(cell_img, [3, 2], 'bottom', valid);
[cell_img, valid] = search_similar_border(cell_img, [3, 3], 'bottom', valid);
[cell_img, valid] = search_similar_border(cell_img, [3, 4], 'bottom', valid);

figure
% subplot(1,2,1)
imshow(cell2mat(cell_img)); title('Ubicación de vecinos (3ra iteracion)');

%% CUARTA BUSQUEDA

[cell_img, valid] = search_similar_border(cell_img, [1, 2], 'left', valid);
[cell_img, valid] = search_similar_border(cell_img, [2, 2], 'left', valid);
[cell_img, valid] = search_similar_border(cell_img, [3, 2], 'left', valid);
[cell_img, valid] = search_similar_border(cell_img, [4, 2], 'left', valid);

figure
% subplot(1,2,2)
imshow(cell2mat(cell_img)); title('Ubicación de vecinos (4ta iteracion)');