function ejercicio_3()
to=0; % start time
tf=50; % end time
t=linspace(to,tf,200);
xo(1)=-2; % initial condition
xo(2)=10;
global fileID
fileID = fopen('datos3.txt','w');
options1=odeset('RelTol',0.01);
[t,x] = ode23(@(t,x)nonlinear(t,x),t,xo,options1);
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
global fileID
a=2+1*rand;
%a=2.5;
%b=2;
b=0+4*rand;
eta=1;
w=0.25*pi;
xd=sin(w*t);
xd1=cos(w*t)*w;
xd2=-sin(w*t)*w^2;
lamda=1;
F=0.5*abs(x(1))*x(2)^2+2*x(1)^3*cos(2*x(1));
k=F+eta;
s=x(2)-xd1+lamda*(x(1)-xd);%Superficie deslizante 
u=2.5*abs(x(1))*x(2)^2+2*x(1)^3*cos(2*x(1))+xd2-lamda*(x(2)-xd1)-k*sign(s);
xdot=[x(2);-a*abs(x(1))*x(2)^2-b*x(1)^3*cos(2*x(1))+u];
fprintf(fileID,'%10.6f %10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2),xd);