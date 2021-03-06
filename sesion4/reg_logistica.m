%               Abraham Rodriguez Vázquez
% Codigo para realizar regresion logistica al conjunto de
% datos Iris incorporado en MATLAB
% Abril/2021

% Limpieza inicial
clear;clc;close all;

% Preprocesado
dataset = iris_dataset';
dataset = dataset(1:100,:);
clases = vertcat(zeros(50,1),ones(50,1));
datos = horzcat(dataset,clases);

% Renombrar a contexto de formulas
x = datos(:,1:2);
y = datos(:,end);

% Extraer numero de datos 
longitud = length(y);
m = longitud;

% Concatenar vector de 1
x = [ones(longitud,1) x];

% Normalizacion de los features
for i = 2:3
   media = sum(x(:,i))/m;
   desviacionestandar = std(x(:,i));
    for j = 1:m
        x(j,i) = (x(j,i) - media)/desviacionestandar;   
    end
end


% Inicializacion de variables e hiperparametros
alfa = .02;                 % Learning rate
thetas = zeros(3,1);        % Variables de aprendizaje
temp = ones(3,1);           % Variables temporales
iteraciones = 1000;         % Numero de iteraciones
J = zeros(1,iteraciones);   % Vector para almacenar el costo

% Matrices para graficado con contour
[X,Y] = meshgrid(linspace(-2,2),linspace(-2,2));

% Iniciar ventana de graficado
figure;
title('Divisor entre I. Setosa y I. Versicolor');

% Inicio de optmización
for k = 1:iteraciones
  
    % Parámetros temporales
    thetas = thetas - (alfa/m) * sum((h(x,thetas) - y).* x)';
    
    % Evaluar costo
    J(k) = (-1/m)* sum( y .* log(h(x,thetas)) + ((1-y) .* log(1- h(x,thetas))));

    % Graficar
    scatter(x(1:50,2),x(1:50,3),'x','r')
    hold on;
    scatter(x(51:100,2),x(51:100,3),'o','b')
     
    contour(X,Y,(1./(1 + exp(-(thetas(1) + thetas(2)*X + thetas(3)*Y))))');
    xlim([-5 5])
    ylim([-5 5]) 
    %pause(.01)
    hold ;
     
end


% Grafico del vector de costo
pause(1)
figure;
plot(1:iteraciones,J)
title('Costo-Iteraciones')

% Vista 3D
figure;
scatter3(x(:,2),x(:,3),clases)
axis vis3d

figure;
scatter3(x(:,2),x(:,3),h(x,thetas))
axis vis3d
hold on
surf(X,Y,-(thetas(1) + thetas(2)*X + thetas(3)*Y))

% Funcion auxiliar sigmoide
function valorsigmoide = h(x, thetas)

    valorsigmoide = (1./(1 + exp(-(thetas'*x'))))';

end