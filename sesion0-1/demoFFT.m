% Ejemplos FFT
clear;clc;close all

% Parametros de senal
Fs = 1000;                    
T = 1/Fs;                     
L = 1000;                     
t = (0:L-1)*T;                

% Creacion de senales
x1 = cos(2*pi*50*t);          
x2 = cos(2*pi*150*t);         
x3 = cos(2*pi*300*t);         

X = [x1; x2; x3];

% Graficacion
figure;
for i = 1:3
    subplot(3,1,i)
    plot(t(1:100),X(i,1:100))
    title(['Senal ',num2str(i),' en dominio del tiempo'])
end

% Obtener transformada de fourier
n = 2^nextpow2(L);
dim = 2;
Y = fft(X,n,dim);

% Escalamiento de resultados para graficacion
P2 = abs(Y/L);
P1 = P2(:,1:n/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);

% Graficacion del espectro de frecuencia
figure;
for i=1:3
    subplot(3,1,i)
    plot(0:(Fs/n):(Fs/2-Fs/n),P1(i,1:n/2))
    title(['Senal ',num2str(i),' En dominoi de la frecuencia'])
end