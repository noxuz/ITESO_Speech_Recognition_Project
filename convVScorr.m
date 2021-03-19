% Conv vs cross correlation vs convolution
clear;clc;close all;

% Cargar matriz de ejemplo
m = randi(3,5)

% kernel de ejemplo
k = eye(3)
k(3,2) = 2;

filter2(k,m,'full')
xcorr2(m,k)
conv2(m,rot90(k,2),'full')




