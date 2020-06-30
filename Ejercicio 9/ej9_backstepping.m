function ej9_backstepping()
to=0; % start time
tf=20; % end time
t=linspace(to,tf,100);
xo(1)=5; % initial condition
xo(2)=-2;
[t,x] = ode45(@(t,x)nonlinear(t,x),t,xo);
plot(t,x)
xlabel('Time (s)')
ylabel('Amplitude')
grid
function [xdot] = nonlinear(t,x)
% nonlinear model to integrate with ODE45
% parameters
%aU=0+2*rand; % -1<a<8 Uncertainties in parameter
a=2*rand;
k=1;
% backstepping control
u=-x(2)-x(1)-k*(x(1)+x(2))-a*x(2)*abs(x(2));
xdot=[x(2); % system with uncertainty aU
a*x(2)*abs(x(2))+u];
endfunction
endfunction