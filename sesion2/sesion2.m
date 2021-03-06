% Sesion 2 - Abraham Rodriguez
%% Declaracione
clear;clc;close all

% Variables y vectores
a = 1; % whos a
b = "Hola mundo";
disp(b)
c = [1 2 3];
g = 1:3;

% Matrices
d = [1 2 3;4 5 6;7 8 9];
e = [1,2,3;4,5,6;7,8,9];
d = [1 2 3;4 5 6;7 8 9];
f = [1 2 3;...
     4 5 6;...
     7 8 9];

% Indexado
d(3,3);
d(1:2,1:2);
d(:,:);
d(end-1,end-1);
d(:);

%% Operaciones
linspace(-1,1,10);

a = [1 2 3 4 6 4 3 4 5];
b = a + 2;

A = [1 2 0; 2 5 -1; 4 10 -1];
B = A';
C = A * B;
C = A .* B;

b = [1;3;5];
x = A\b;

eig(A)

% Producto punto producto cruz
A = [4 -2 1];
B = [1 -1 3];
C = cross(A,B);
D = dot(A,B);
A*B'

% Producto externo
A'*B

%% Plot
x = 0:pi/10:2*pi;
y1 = sin(x);
y2 = sin(x-0.25);
y3 = sin(x-0.5);

figure
plot(x,y1,'g',x,y2,'b--o',x,y3,'c*')

%% Scatter
theta = linspace(0,1,500);
x = exp(theta).*sin(100*theta);
y = exp(theta).*cos(100*theta);
s = scatter(x,y);

%% Scatter3
z = linspace(0,4*pi,250);
x = 2*cos(z) + rand(1,250);
y = 2*sin(z) + rand(1,250);

figure
scatter3(x,y,z,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',[0 .75 .75])
axis vis3d

%% Matrices a archivos y viceversa
datos = iris_dataset;
writematrix(datos,'datos.csv');
datos2 = readmatrix('datos.csv');

%% Easter eggs
image
spy
why
penny
logo
fifteen
xpbombs
surf(membrane)
axis vis3d
life
x=[-2:.001:2],y=(sqrt(cos(x)).*cos(200*x)+sqrt(abs(x))-0.7).*(4-x.*x).^0.01,plot(x,y);

