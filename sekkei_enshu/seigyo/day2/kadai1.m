xi=0.0175;
wn=5.9279;

K=0.58*sqrt(1-xi.^2)*exp(xi*wn*0.26)/sin(wn*sqrt(1-xi.^2)*0.26)/wn
t=0:0.01:3;

s=tf('s');
P=K*wn.^2/(s*s+2*xi*wn*s+wn.^2);
impulse(P,t)
grid on;

