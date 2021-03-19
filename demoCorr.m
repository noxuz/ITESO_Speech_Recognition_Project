% Ejemplos de cross correlation
clear;close all;

imagen = imread('cameraman.tif');
imagendouble = im2double(imagen);

% Segmentar kernel
kernel = imagendouble(50:100,100:150);
% Realizar correlation cruzada
procesar = filter2(kernel,imagendouble);

% Normalizar
normalizados = normalize(procesar(:));
result = reshape(normalizados,size(procesar));

% Mostrar
figure;
montage({imagen, kernel, result});
title('Cross correlation output')