%% Abraham Rodriguez Vazquez
imagen = 'monarca.jpg';

% Lectura de imagen
pic = imread(imagen);
figure;
imshow(pic)
title('Imagen original')

%% Imagen en escala de grises
picGrayscale = rgb2gray(pic);
figure;
imshow(picGrayscale);
title('Imagen en escala de grises')

%% Canales RGB de imagen | Intensidad de cada canal
close all;

R = pic(:,:,1);
G = pic(:,:,2);
B = pic(:,:,3);
figure;
montage({R,G,B})
title('Intensidades de cada canal RGB')

%% Canales RGB de imagen | Descomposicion
close all;

picRed = pic;
picRed(:,:,2:3) = 0;

picGreen = pic;
picGreen(:,:,[1 3]) = 0;

picBlue = pic;
picBlue(:,:,1:2) = 0;

figure;
montage({picRed,picGreen,picBlue})
title('Descomposicion de cada canal RGB')

%% Canales RGB de imagen | Aislamiento
close all;

[R1,R2,R3] = deal(R,R,R); 
[G1,G2,G3] = deal(G,G,G); 
[B1,B2,B3] = deal(B,B,B); 

% Detectar pixel Rojo
RedPixs = (R > 100) & (G < 100) & (B < 40);

% Apagar intensidades no rojas
R1(~RedPixs) = 255;
G1(~RedPixs) = 255;
B1(~RedPixs) = 255;

% Reconstruir imagen
aisR = pic;
aisR(:,:,1) = R1;
aisR(:,:,2) = G1;
aisR(:,:,3) = B1;

% Detectar pixel Verde
GreenPixs = (R < 170) & (G > 100) & (B < 170);

% Apagar intensidades no verdes
R2(~GreenPixs) = 255;
G2(~GreenPixs) = 255;
B2(~GreenPixs) = 255;

% Reconstruir imagen
aisG = pic;
aisG(:,:,1) = R2;
aisG(:,:,2) = G2;
aisG(:,:,3) = B2;

% Detectar pixel Azul
BluePixs = (R < 120) & (G < 120) & (B > 40);

% Apagar intensidades no rojas
R3(~BluePixs) = 255;
G3(~BluePixs) = 255;
B3(~BluePixs) = 255;

% Reconstruir imagen
aisB = pic;
aisB(:,:,1) = R3;
aisB(:,:,2) = G3;
aisB(:,:,3) = B3;

figure;
montage({aisR,aisG,aisB})
title('Aislamiento de cada canal')
