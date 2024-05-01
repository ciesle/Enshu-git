function work4_1
M=1;
D=2;
K=1;
a=[0 1;-K/M -D/M];
b=[0;1/M];
c=[1 0];
d=[0];
s1=ss(a,b,c,d);

delta=0.05;
t=[0:delta:50];
u=[1/delta zeros(1,length(t)-1)];
u2=[zeros(1,length(t))];
y=lsim(s1,u,t);
y2=lsim(s1,u2,t,[0;1]);
plot(t,y,'b');
hold on
plot(t,y2,'g');
hold on
%plot(t,u,'r--');

hold off