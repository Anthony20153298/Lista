function ejercicio_8()
to=0; % start time
tf=60; % end time
t=linspace(to,tf,200);
xo(1)=-10; % initial condition
xo(2)=20;
global fileID
fileID = fopen('datos8.txt','w');
options1=odeset('RelTol',0.01);
[t,x] = ode23(@(t,x)nonlinear(t,x),t,xo,options1);
%[T,Y] = ode45(@(t,y) test(t,y,b), tspan, y0);  % One comma removed
fclose(fileID);
xlabel('Time (s)')
ylabel('Amplitude')
hold on
plot(t,x(:,1))
plot(t,x(:,2))
plot(t,u,'y')
legend('x1','x2', 'u');
grid
function [xdot] = nonlinear(t,x)
% nonlinear model to integrate with ODE45
% parameters
% deslizante control
global fileID
%a=-2+4*rand;
a=0;%Valor medio
eta=1;%valor eta mayor que cero
w=0.25*pi;
xd=sin(w*t);
xd1=cos(w*t)*w;
xd2=-sin(w*t)*w^2;
lamda=1;
F=x(2)*abs(x(2));
k=F+eta;
s=x(2)-xd1+lamda*(x(1)-xd);%Superficie deslizante 
u=(xd2-lamda*(x(2)-xd1)-k*sign(s));
xdot=[x(2);a*x(2)*abs(x(2))+u];
fprintf(fileID,'%10.6f %10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2),xd);