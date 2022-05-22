%Defines the time in intervals of 5
t = linspace(0,40,9);

%Defines the values of x
x = -100:0.1:100;

%corresponds to the symmetry of our problem, ie. a slab.
m = 0;

sol = pdepe(m,@pdefun,@pdeic,@pdebc,x,t);

u1 = sol(:,:,1);
v = sol(:,:,2);


newcolors = [0.83 0.14 0.14
             1.00 0.54 0.00
             0.47 0.25 0.80
             0.25 0.80 0.54
             0.76 0.12 0.79
             0.99 0.56 0.21
             0.67 0.43 0.78
             0.96 0.69 0.42
             0.00 0.00 0.00];
%ensures lines with the same value of t have the same colour, defaults the
%colour order to be the matrix of RGB values defined above.
colororder(newcolors)
hold on
plot(x,u1)
plot(x,v,'--')
%Creates the legend for all 9 values of both u and v (v labels have dashed
%lines)
legend('u,t=0','u,t=5','u,t=10','u,t=15','u,t=20','u,t=25','u,t=30', ...
    'u,t=35','u,t=40','v,t=0','v,t=5','v,t=10' ...
    ,'v,t=15','v,t=20','v,t=25','v,t=30','v,t=35','v,t=40')

xlabel('x value')
ylabel('u(x,t) (solid lines) & v(x,t) (dashed lines)')


function [c,f,s] = pdefun(x,t,u,DuDx)
c = [1;1];
%diffusion term
f = [1;2] .*DuDx;
s = [u(1).*(1-u(1)-(1.5.*u(2)));1.5 .*u(2) .* (1-u(2)-(0.7.*u(1)))];
end

function u0 = pdeic(x)
if x<=1 && x>=-1
    v0 = 0.2;
else
    v0 = 0;
end
u0 = [1;v0];
end

function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t)
pl = [0; 0];
ql = [1/2; 1/2];
pr = [0; 0];
qr = [1/2; 1/2];
end