%Question 2
%Move all into same document
%Most dangerous age class is (1)
ageclass = [1,2,3,4,5,6,7];
%To get probdeath do 1 - (g_i+p_i)
probdeath = [0.9,0.5,0.3,0.3,0.2,0.1,0.1];
plot(ageclass,probdeath,'red')
xlabel('Age Class')
ylabel('Probability of Death')
%Question 3
A=[0,0,0,0,8,18,4;0.1,0.2,0,0,0,0,0;0,0.3,0.4,0,0,0,0;0,0,0.3,0.3,0,0,0;0,0,0,0.4,0.5,0,0;0,0,0,0,0.3,0.8,0;0,0,0,0,0,0.1,0.9];
lambda = max(eig(A));                        

G_i = [0.1,0.3,0.3,0.4,0.3,0.1,0];
v = ones(1,7);
%Calculate stable age distribution
for x =2:numel(G_i)
    v(x) = (G_i(x-1).*v(x-1))/lambda;
end


%Question 4
t = linspace(0,50,51);
%Initialises column vector given in question.
N0=[0,1000,0,0,0,0,0]';
%Initialise a 7x50 matrix to overwrite values with.
storeN = zeros(7,50);
%Initialise first column as N0
storeN(:,1) = storeN(:,1) + N0;
%Loops the required times, updating each successive column with the
%previous column, multiplied on the left by the 7x7 matrix A.
for i = 1:50
    storeN(:,i+1) = A*storeN(:,i);
end
%Extracts rows 4,5,6 and 7 which store the data for N4,N5,N6 and N7
N4 = storeN(4,:);
N5 = storeN(5,:);
N6 = storeN(6,:);
N7 = storeN(7,:);
%Plots this data against the values of t. ADD A LEGEND.
hold on
plot(t,N4)
plot(t,N5)
plot(t,N6)
plot(t,N7)
hold off

%calculates Ni/lambda for i=4,5,6,7
N4lambda = N4/lambda;
N5lambda = N5/lambda;
N6lambda = N6/lambda;
N7lambda = N7/lambda;

figure()
hold on
plot(t,N4lambda)
plot(t,N5lambda)
plot(t,N6lambda)
plot(t,N7lambda)
hold off

%Question 5
Aprime = A;
domeigchange = ones(1,20);
A(1,5);
for x =0:20
    Aprime(1,5) = x;
    domeigchange(x+1) = max(eig(Aprime));   
end
lst = linspace(0,20,21);
%Finds position of lowest F5, 15th entry of array therefore lowest F5 value
%is 15-1=14
F5grow = find(domeigchange>1,1);
%Smallest value of F5 that will give growth

%Increasing fecundity in growth stage 5 increases the population. If F5>=14
%you get an increase in population. Biologically realistic.
figure()
plot(lst,domeigchange);
yline(1);

%Smallest value of growth when it just goes greater than 1.

%Question 6
%Initialises matrix which will be used for changing P3
A3 = A;
%Loop for P3
step = (0:0.01:1);
%Initialise list of eigenvalues
P3eig = ones(1,101);
for i=1:length(step)
    %changes values of P3, increases by 0.01 each time
    A3(3,3) = step(i);
    %calculates max eigenvalue for current matrix
    P3eig(i) = max(eig(A3));
end

A6 = A;
%Initialise list of eigenvalues
P6eig = ones(1,101);
for i=1:length(step)
    %changes values of P6, increases by 0.01 each time
    A6(6,6) = step(i);
    %calculates max eigenvalue for current matrix
    P6eig(i) = max(eig(A6));
end

%Axis labels
figure()
hold on
plot(step,P3eig)
plot(step,P6eig)
yline(1)
legend('P3','P6')
%Best to increase P3 over P6. P3 reaches growth faster than P6. Increase
%survival rate of large juveniles. P3 starts lower, easier to increase
%whereas increasing P6 to 1 would be very difficult. Increasing
%survivability may have a knock-on effect when protecting in P6.

%Question 7
[V,D,W] = eig(A);
w = W(:,6);

%Question 8
v = V(:,6);
vdotw = dot(v,w);
%Initialises a 7x7 matrix
E = zeros(7);
%Initialises an array of numbers 1 to 7 to iterate over in the following
%loop
seven = linspace(1,7,7);
%Double for loop allows us to iterate over elements i,j
for i=seven
    for j=seven
        %Formula for matrix e_ij given in the quewstion
        E(i,j) = (A(i,j)/lambda)*(w(i)*v(j))/vdotw;
    end
end
%Extract elements from our matrix e to plot.
P_i = diag(E);
G_inew = diag(E,-1);
G_inew(7) = 0;
F_i = E(1,:);

figure();
hold on
plot(seven,P_i,'-x')
plot(seven,G_inew,'-o')
plot(seven,F_i,'-*')
legend('P_i','G_i','F_i')
xlabel('Growth Stages')
ylabel('Elasticity')
hold off