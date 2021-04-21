%               Abraham Rodriguez Vázquez

clear;clc;close all;

dataset = iris_dataset';
dataset = dataset(1:100,:);
clases = vertcat(zeros(50,1),ones(50,1));
datos = horzcat(dataset,clases);

x = datos(:,1:2);
y = datos(:,end);

longitud = length(y);
m = longitud;

x = [ones(longitud,1) x];

% Normalizacion de valores de xi
for i = 2:3
   media = sum(x(:,i))/m;
   desviacionestandar = std(x(:,i));
    for j = 1:m
        x(j,i) = (x(j,i) - media)/desviacionestandar;   
    end
end


% Inicializacion de variables
alfa = .07;
thetas = zeros(3,1);
temp = ones(3,1);
iteraciones = 1000;
J = zeros(1,iteraciones);

equis1 = linspace(-20,20);
equis2 = linspace(-20,20);

[X,Y] = meshgrid(equis1,equis2);

figure;
title('Divisor entre I. Setosa y I. Versicolor');

% Inicio de optmización
for k = 1:iteraciones
  
        % Parámetros temporales
        for i = 1:3
            temp(i) = thetas(i) - (alfa/m) * sum((h(x,thetas) - y).* x(:,i));
        end   
        
        % Evaluar costo
        J(k) = (-1/m)* sum( y .* log(h(x,thetas)) + ((1-y) .* log(1- h(x,thetas))));
        
     % Asignar parámetros 
     for j = 1:3
            thetas(j) = temp(j);
     end
        
     % Graficar
     scatter(x(1:50,2),x(1:50,3),'x','r')
     hold on
     scatter(x(51:100,2),x(51:100,3),'o','b')
     
     contour(X,Y,(1./(1 + exp(-(thetas(1) + thetas(2)*X + thetas(3)*Y))))');
     xlim([-5 5])
     ylim([-5 5]) 
     pause(.01)
     hold 
end


pause(3)
figure;
plot(1:iteraciones,J)
title('Costo-Iteraciones')


function valorsigmoide = h(x, thetas)
valorsigmoide = (1./(1 + exp(-(thetas'*x'))))';

end