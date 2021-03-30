%% Demo con grabacion de audio
clear;clc;close all
% Instanciar objeto y grabar
recObj = audiorecorder;

disp('Inicia grabacion.')
recordblocking(recObj, 3);
disp('Termina grabacion.');

%% Reproducir grabacion
play(recObj);


%% Obtener vector de audio y obtener espectrograma
y = getaudiodata(recObj);
spectrogram(y)
title('Espectrograma de muestra de audio')

figure;
plot(y)
title('Audio en el tiempo')