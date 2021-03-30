%% Abraham Rodriguez Vazquez
imagen = 'peppers.png';

% Lectura de imagen
pic = imread(imagen);
figure;
imshow(pic)
title('Imagen original')

%% Operaciones basicas con imagenes
close all;

% Redimensionamiento
imagen_redimensionada = imresize(pic,.5);
figure;
imshow(imagen_redimensionada);
title('Imagen redimensionada')

% Recorte
imagen_recortada = pic(1:size(pic,1)/2,1:size(pic,2)/2,:);
figure;
imshow(imagen_recortada);
title('Imagen recortada')

% Rotacion
imagen_rotada = imrotate(pic,30);
figure;
imshow(imagen_rotada);
title('Imagen rotada')


%% 2D convolution vs imfilter
close all;

picdouble = im2double(rgb2gray(pic));

kernel = fspecial('motion', 50, 45);

imshow(conv2(picdouble,rot90(kernel,2)))
title('Convolucion')
figure;
imshow(imfilter(pic,kernel))
title('imfilter')

%% Filtros especiales
close all;

kernel_gaus = fspecial('gaussian',50,20);
imshow(imfilter(pic,kernel_gaus));
title('Gaussian blur');

figure;
kernel_lap = fspecial('laplacian');
imshow(imfilter(pic,kernel_lap));
title('Laplacian');

figure;
edge(rgb2gray(pic),'Canny')
title('Bordes Canny')

[mag,dir] = imgradient(im2double(rgb2gray(pic)));
subplot(1,2,1)
imshow(mag);
title('Magnitud de gradientes')
subplot(1,2,2)
imshow(dir)
title('Direccion de gradientes')


