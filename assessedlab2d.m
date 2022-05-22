%Question 2d

%Defines the time in intervals of 5
t = linspace(0,40,9)

%Defines the values of x
x = -100:0.1:100;

%corresponds to the symmetry of our problem, ie. a slab.
m = 0;

solv = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t);

v = solv(:,:,1);





figure
plot(x,v)
xlabel('Value of x')
ylabel('v(x;t)')

%Defines pde (2)
function [c,f,s] = pdex1pde(x,t,v,DvDx)
c = 1;
%diffusion term
f = 2 .* DvDx;

s = 1.5 .*v .* (1-v-(0.7));
end

%Defines initial conditions
function v0 = pdex1ic(x)
if x<=1 && x>=-1
    v0 = 0.2;
else
    v0 = 0;
end
end

function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t)
pl = 0;
ql = 1/2;
pr = 0;
qr = 1/2;
end