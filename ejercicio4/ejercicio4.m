%% TP - EJ 4 
% Rodriguez Javier Ceferino
% Gervasi, Sofia
% Venanzoni, Martina
clc;close all;clear all;

%Abro imagen
[file,dir]=uigetfile('*.bmp;*.jpg;*.tif;*.png');
filename=[dir,file];
info=imfinfo(filename);

RGB=imread(filename);

figure
imshow(RGB);title('Imagen Original');

% Cambio a espacio de color LAB
LAB=rgb2lab(RGB);
L=LAB(:,:,1); 
A=LAB(:,:,2);% verde NEG y rojo POS
B=LAB(:,:,3);% azul NEG y amarillo POS

figure
subplot(221);imshow(A,[]);title('A');
subplot(222);imhist(int8(A),201);title('Histograma de A');
subplot(223);imshow(B,[]);title('B');
subplot(224);imhist(int8(B),201);title('Histograma de B');

%% Segmento
%Busco graficamente el rango de valores que los colores que deseamos segmentar

R=(A>70);% Segmento objectos rojos
V=(A<-56);% Segmento objectos verdes
N=(L==0);% Segmento objectos negros
AZ=(B<-69);% Segmento objectos azules

%Genero mapa de colores
mapR=[1 1 1; 1 0 0];
mapV=[1 1 1; 0 1 0];
mapAZ=[1 1 1; 0 0 1];
mapN=[1 1 1; 0 0 0];

%Cuento cuantos elementos hay de cada color
nR=bwlabel(R);
nR=max(max(nR));

nV=bwlabel(V);
nV=max(max(nV));

nAZ=bwlabel(AZ);
nAZ=max(max(nAZ));

nN=bwlabel(N);
nN=max(max(nN));

figure
subplot(141);imshow(R,mapR); title([num2str(nR),' Objetos Rojos']);
subplot(142);imshow(V,mapV); title([num2str(nV),' Objetos Verdes']);
subplot(143);imshow(AZ,mapAZ); title([num2str(nAZ),' Objetos Azules']);
subplot(144);imshow(N, mapN);title([num2str(nN),' Objetos Negros']);

