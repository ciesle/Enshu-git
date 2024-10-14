T=[200 2;45 4];

K=1;
M=2;
D=100;

delta=0.05;
t=0:delta:20;
y1=feedback(K,M,D,[1 0;0 1],t);
y2=feedback(K,M,D,T,t);

hold off;
plot(t,y1,"r--");
hold on;
plot(t,y2,"b");
hold on;

eig([0 1; -K/M -D/M])
