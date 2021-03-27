%% Sesion 3, 
% Abraham Rodriguez Vazquez

%% Sort
clear;clc;close all;
a = 0.1:0.1:10;
b = linspace(0.1,10,100);

c = 1:0.1:10;
d = linspace(1,10,100);

% Ordenar ascendente y descendente
vectorOrdenadoAsc = sort(a);
vectorOrdenadoDes = sort(a,'descend');

% Ordenar Matriz
m = randi(10,3);
sortRows = sort(m,1);
sortColumns = sort(m,2);


%% For loops, debug
for i = 1:10
   disp(i); 
end

i = 1;
while i < 11
    disp(i);
    i = i+1;
end

% Inverso
for i = 10:-1:1
    disp(i);
end

% Factorial
n = 10;
f = n;
while n > 1
    n = n-1;
    f = f*n;
end
disp(['n! = ' num2str(f)])
funcion(2)
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

%% Vector vs for

% Dot product comparison
a = randi(10,[1 1000]);
b = randi(10,[1 1000]);

c = zeros(1,1000);
acum = 0;
disp('Tiempo con for loops')
tic
for i = 1:1000
    acum = acum + a(i)*b(i);
end
toc

disp(' ');
disp('Tiempo vectorizado')
tic
c = a*b';
toc


%% Diferenciacion
clear;clc;close all

h = 0.4;
t = 0:h:2*pi;
y = sin(t);
scatter(t,y)
hold on
dif = (sin(t) - sin(t + h))./ h;
scatter(t,dif)

%% Integracion
cumsum(y)



