s=tf('s');
w=logspace(-2,4,100);
K=20;
a=10;

G=K*(s+a)/((s+1)*(s+2)*(s+3));

figure
rlocus(G)
grid on
legend('G')
set(findall(gcf,'type','Line','LineWidth',3))
set(findall(gcf,'type','Axes','FontSize',18))