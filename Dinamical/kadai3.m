A=[-2 -1 1; -1 -2 1; 0 0 -3];
B=[0; 0; 1];
C1=[1 0 0];
C2=[0 1 0];
D=0;

delta=0.05;
t=0:delta:20;
u=1*ones(1,length(t));

s1=ss(A,B,C1,D);
s2=ss(A,B,C2,D);
y1=lsim(s1,u,t,[0;1;0]);
y2=lsim(s2,u,t,[0;1;0]);
plot(t,y1,'r');
hold on;
plot(t,y2,'b');
hold on;