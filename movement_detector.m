opengl 'hardware';

close all;
clear all;

%im = ('http://192.168.1.73:8080/shot.jpg');
%im = ('http://172.16.67.11:8080/shot.jpg');
im = ('http://192.168.1.2:8080/shot.jpg');
n = 2000; %numero de trigers
h = 2;    %numero de promedios por hacer
G = fspecial('gaussian',[5 5],1.5);

imagen = imread(im);
imagen = imfilter(imagen,G,'same');
imagen = double(imagen);
Gauss.media = imagen;
Gauss.desv = 256*ones(size(imagen));
Gauss.error = abs(Gauss.media-imagen);

sigma = 3;
rho = 0.999;

figure(1);
set(gcf,'Renderer','opengl');