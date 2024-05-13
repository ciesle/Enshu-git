function []=wrap(x)

K=2;
M=1;
D=0.8;
delta=0.05;
t=0:delta:20;
d=(rand(1,length(t))-0.5)/2;
d2=zeros(1,length(t));
for i=1:5
    tmp=floor(rand*length(t))+1;
    d2(1,tmp)=1;
end
d3=ones(1,length(t))*0.5;
zero=zeros(1,length(t));

func{1}=@(K,M,D,d) kadai4_1(K,M,D,d);
func{2}=@(K,M,D,d) kadai4_2(K,M,D,d);
func{3}=@(K,M,D,d) kadai4_3(K,M,D,d);
func{4}=@(K,M,D,d) kadai4_4(K,M,D,d);

y1=func{x}(K,M,D,zero);
hold off;
plot(t,y1,'k','LineWidth',2);
hold on;
y2=func{x}(K,0.9,D,zero);
plot(t,y2,'r','LineWidth',1.5);
hold on;
y3=func{x}(K,M,0.6,zero);
plot(t,y3,'g','LineWidth',1.5);
hold on;
y4=func{x}(K,M,D,d);
if x ~= 2
    plot(t,y4,'b','LineWidth',1.5);
end
hold on;
y5=func{x}(K,M,D,d2);
if x ~= 2
    plot(t,y5,'m','LineWidth',1.5);
end
hold on;
y6=func{x}(K,M,D,d3);
if x ~= 2
    plot(t,y6,'c','LineWidth',1.5);
end
xlabel("Time");
ylabel("Position");
legend('Default',"M=0.9","D=0.6","d=random", "d=impuls", "d=0.5");