close all

global position_init
global theta_init
global pend_length

addpath('simulinkfiles')
load('matfiles/params_pend_identification')

%%

position_init = 0; % pendulum initial angle [radian]
theta_init = 0.1; % pendulum initial angle [radian]

% 既知のパラメータ
m = 0.0568;           %振子（42cm）の質量
l = 0.21;           %振子の長さの1/2（42cm）
g = 9.8;           %重力加速度
Kg = 1;          %内部ギア比
Ktau = 0.023;        %モータのトルク定数
Ke = 0.023;          %逆起電力定数
rho = 0.00635;         %ピニオンギア半径 
Resist = 8.3;      %電気子抵抗

% 同定したパラメータ
M = 0.9473;                %台車の質量
Dhatx = 2.8818;            %台車の摩擦係数

Dtheta = 1.4241e-4;           %振子の摩擦係数 

%% 状態空間方程式の設定
% A行列, B行列に現れるK, Deltaの計算
K = Ke*Kg/(Resist*rho);
Delta = (M+m)*4/3*m*l^2-m^2*l^2;

% A行列
A = [0 0 1 0;
    0 0 0 1;
    0 -1/Delta*m^2*l^2*g -1/Delta*4/3*Dhatx*m*l^2 1/Delta*Dtheta*m*l;
    0 1/Delta*(M+m)*m*g*l 1/Delta*Dhatx*m*l -1/Delta*(M+m)*Dtheta];

% B行列
B = [0;
    0;
    K/Delta*4/3*m*l^2;
    -K/Delta*m*l];

C = [1 0 0 0;
     0 1 0 0];

%% 閉ループ系の極の設定

% 使わないものは行頭に%をつけてコメントアウト
p11 = -0.5-4i;
p12 = -0.5+4i;
p13 = -6-0.6i;
p14 = -6+0.6i;

P1 = [p11 p12 p13 p14];

p21 = -2-3i;
p22 = -2+3i;
p23 = -4-0.1i;
p24 = -4+0.1i;

P2 = [p21 p22 p23 p24];

%% 最適レギュレータの設定

% 使わないものは行頭に%をつけてコメントアウト
Q1 = diag([5,1,5,1]);
R1 = 1;
 
Q2 = diag([10,10,10,10]);
R2 = diag([1,1]);

%% コントローラの設計

% 使わないものは行頭に%をつけてコメントアウト
%F = place(A,B,P1);
F = lqr(A,B,Q1,R1);

%L = place(A',C',P2);
L = lqr(A',C',Q2,R2);


F = -F
eig(A+B*F)
L = -L'
eig(A+L*C)

%% simulation

Model = 'cartpend_obs_simulator';
open_system(Model);
set_param(Model, 'StopTime', '10');
sim(Model);
close_system(Model);
data = ans;

%% plot

figure
plot(data.time, data.cart_position, 'b', 'LineWidth', 3)
hold on
plot(data.time, data.cart_position_hat, 'r', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Cart Position [m]')
legend('Real','Estimate')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angle, 'b', 'LineWidth', 3)
hold on
plot(data.time, data.pole_angle_hat, 'r', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Pole Angle [rad]')
legend('Real','Estimate')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.cart_velocity, 'b', 'LineWidth', 3)
hold  on
plot(data.time, data.cart_velocity_hat, 'r', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Cart Velocity [m/s]')
legend('Real','Estimate')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angularvelocity, 'b', 'LineWidth', 3)
hold  on
plot(data.time, data.pole_angularvelocity_hat, 'r', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Pole Angular Velocity [rad/s]')
legend('Real','Estimate')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.voltage, 'b', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Voltage [V]')
set(gca, 'FontSize', 15)
