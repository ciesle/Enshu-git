s=tf('s');
w=logspace(-2,4,100);

G=1/(s*(1*s+1)*(0.01*s+1));

figure
bode(G,w)
grid on
legend('G')
set(findall(gcf,'type','Line','LineWidth',3))
set(findall(gcf,'type','Axes','FontSize',18))