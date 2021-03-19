function M = ImageMorphingTriangulation(warp_frac,dissolve_frac)

if nargin < 1
    warp_frac = .5;
end

if nargin < 2
    dissolve_frac= warp_frac; 
end


% ream images
I = im2double(imread('a.png'));
J = im2double(imread('c.png'));

% load mat file with points, variables Ip,Jp
 load('points.mat');
 
% initialize ouput image (morphed)
M = zeros(size(I));

%  Triangulation (on the mean shape)
MeanShape = (1/2)*Ip+(1/2)*Jp;
TRI = delaunay(MeanShape(:,1),MeanShape(:,2));


% number of triangles
TriangleNum = size(TRI,1); 

% find coordinates in images I and J
CordInI = zeros(3,3,TriangleNum);
CordInJ = zeros(3,3,TriangleNum);

for i =1:TriangleNum
  for j=1:3
    
    CordInI(:,j,i) = [ Ip(TRI(i,j),:)'; 1];
    CordInJ(:,j,i) = [ Jp(TRI(i,j),:)'; 1]; 
    
  end
end

% create new intermediate shape according to warp_frac
Mp = (1-warp_frac)*Ip+warp_frac*Jp; 

 
% create a grid for the morphed image
[x,y] = meshgrid(1:size(M,2),1:size(M,1));

% for each element of the grid of the morphed image, find  which triangle it falls in
TM = tsearchn([Mp(:,1) Mp(:,2)],TRI,[x(:) y(:)]);

% YOUR CODE STARTS HERE

% Para computar unicamente una vez cada matriz 
% se ordenan los pixeles por triangulo, pero manteniendo sus indices
[PixOrdenados,Indices] = sort(TM);

% Hay dos imagenes intermedias antes del cross dissolve
M_I = zeros(size(I));
M_J = zeros(size(I));

% Matrices para cada color y cada imagen
M_I_red = M_I(:,:,1);
M_I_green = M_I(:,:,2);
M_I_blue = M_I(:,:,3);

M_J_red = M_J(:,:,1);
M_J_green = M_J(:,:,2);
M_J_blue = M_J(:,:,3);

% Separacion de cada imagen en rgb
I_red = I(:,:,1);
I_green = I(:,:,2);
I_blue = I(:,:,3);

J_red = J(:,:,1);
J_green = J(:,:,2);
J_blue = J(:,:,3);

% Cosechar tamanos para usar en la fuuncion sub2ind
[numFilas,numColum,~] = size(M_I);

figure(100);
subplot(1,3,1);
imshow(I);
hold on;
triplot(TRI,Ip(:,1),Ip(:,2))
hold off;
title('First')

%subplot(1,3,2);
%imshow(M);
%%hold on;
%%triplot(TRI,Mp(:,1),Mp(:,2))
%%hold off
%title('Morphed')

subplot(1,3,3);
imshow(J);
hold on;
triplot(TRI,Jp(:,1),Jp(:,2))
hold off
title('Second')

subplot(1,3,2);

% Computar los baricentros de cada pixel por triangulo
for i = 1:TriangleNum
    % Encontrar los pixeles correspondientes de cada triangulo
    PixDelTriag = find(PixOrdenados == i);

    % Numero de pixeles en el triangulo actual
    NumPixelesTriag = length(PixDelTriag);
    
    % Construir matriz para encontrar baricentros de cada pixel
    MatrizCordPixelesTriag = ones(3,NumPixelesTriag);
    MatrizCordPixelesTriag(1:2,:) = [x(Indices(PixDelTriag))'; y(Indices(PixDelTriag))'];
    
    % Formar matriz de coordenadas de las esquinas del triangulo actual
    MatrizEsquinasTriag = ones(3,3);
    % Coordenadas de cada esquina 
    MatrizEsquinasTriag(1:2,1) = Mp(TRI(i,1),:)';
    MatrizEsquinasTriag(1:2,2) = Mp(TRI(i,2),:)';
    MatrizEsquinasTriag(1:2,3) = Mp(TRI(i,3),:)';

    % Computar baricentros de cada pixel
    CordenadasBari = MatrizEsquinasTriag \  MatrizCordPixelesTriag; 
   
    % Computar pixeles correspondientes en la source image
    PixelesEnM_I = round(CordInI(:,:,i) * CordenadasBari);

    PixelesEnM_J = round(CordInJ(:,:,i) * CordenadasBari);


    % Copiar los pixeles de la imagen original en la morfeada intermedia
    % cuidando la correspondencia i-j y-x, se hace para cada color
    
    % Imagen I
    M_I_red(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            I_red(sub2ind([numFilas,numColum],PixelesEnM_I(2,:),PixelesEnM_I(1,:)));
    
    M_I_green(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            I_green(sub2ind([numFilas,numColum],PixelesEnM_I(2,:),PixelesEnM_I(1,:)));
    
    M_I_blue(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            I_blue(sub2ind([numFilas,numColum],PixelesEnM_I(2,:),PixelesEnM_I(1,:)));

    % Imagen J
    M_J_red(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            J_red(sub2ind([numFilas,numColum],PixelesEnM_J(2,:),PixelesEnM_J(1,:)));
    
    M_J_green(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            J_green(sub2ind([numFilas,numColum],PixelesEnM_J(2,:),PixelesEnM_J(1,:)));
    
    M_J_blue(sub2ind([numFilas,numColum],MatrizCordPixelesTriag(2,:),MatrizCordPixelesTriag(1,:))) = ...
            J_blue(sub2ind([numFilas,numColum],PixelesEnM_J(2,:),PixelesEnM_J(1,:)));


% Unir los colores
M_I(:,:,1) = M_I_red;
M_I(:,:,2) = M_I_green;
M_I(:,:,3) = M_I_blue;

M_J(:,:,1) = M_J_red;
M_J(:,:,2) = M_J_green;
M_J(:,:,3) = M_J_blue;
 

% cross-dissolve
M =(1-dissolve_frac)* M_I + dissolve_frac * M_J;
imshow(M)
hold on
hold off
pause(.02)
end



end