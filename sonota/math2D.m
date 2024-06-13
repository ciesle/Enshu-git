figure;

syms x y
z=x+1i*y;
fsurf(real(y.^3/3-x.^2*y-y),[-3 3 -3 3]);
hold on;
yt = linspace(-3, 3, 100);

% zの値を計算
zt = (yt.^3) / 3 - yt;

% xは0に固定
xt = zeros(size(yt));

% プロット
plot3(xt, yt, zt, 'LineWidth', 2);

xt=linspace(-3,3,100);
yt=sqrt((xt.^2)/3+1);
zt=(-8*yt.^3)/3+2*yt;
plot3(xt,yt,zt, 'LineWidth',2);
yt=-yt;
zt=(-8*yt.^3)/3+2*yt;
plot3(xt,yt,zt, 'LineWidth',2);

xlabel('x');
ylabel('y');
zlabel('z');

hold off;