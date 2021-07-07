%% TP - EJ 1 
% Rodriguez Javier Ceferino
% Gervasi, Sofia
% Venanzoni, Martina
clc;close all;clear all;

%Abro imagen
[file,dir]=uigetfile('*.bmp;*.jpg;*.tif;*.png');
filename=[dir,file];
info=imfinfo(filename);

% Convierto a Escala de Grises
switch info.ColorType
  
    case 'indexed'
        [X,map]=imread(filename);
        I=ind2gray(X,map);
        
    case 'grayscale'
        I=imread(filename);
        
    case 'truecolor'
        RGB=imread(filename);
        I=rgb2gray(RGB);
        
end

I=im2double(I);

%% Filtro Prewitt
dX=fspecial('prewitt') %d/dx
dY=rot90(dX)%d/dy

Gx=conv2(I,dX,'same');
Gy=conv2(I,dY,'same');

figure
subplot(121);imshow(Gx,[]);colorbar; title('Gx');
subplot(122);imshow(Gy,[]);colorbar; title('Gy');


%% Matriz de Angulos del Gradiente
G=Gy./Gx;
AG=atan(G);
AG=rad2deg(AG);

figure
subplot(121); imshow(AG,[]);colorbar; title ('Matriz de Angulos del Gradiente');

%% Matriz de Angulos de los Bordes
AB=AG-90;

subplot(122);imshow(AB,[]);colorbar; title('Matriz de Angulos de los Bordes');
%% Segmento
%Busco graficamente el rango de valores que toman los angulos de los bordes
%deseados

S=(AB>-87&AB<-84);

figure
subplot(121);imshow(I,[]);colorbar; title('Imagen Original');
subplot(122);imshow(S,[]);colorbar; title('Bordes Segmentados');
