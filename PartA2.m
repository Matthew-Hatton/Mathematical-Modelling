#We analyse a given Leslie Matrix to produce plots of the probability of death of sea turtles
ageclass = [1,2,3,4,5,6,7];
%To get probdeath do 1 - (g_i+p_i)
probdeath = [0.9,0.5,0.3,0.3,0.2,0.1,0.1];
plot(ageclass,probdeath,'red')
xlabel('Age Class')
ylabel('Probability of Death')
