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
l = 0.21;           %振子の長さの1/2（40cm）
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


%% 最適レギュレータの設定

Q = diag([10000,100,100,100]);
R = 1;

%% コントローラの設計

F = lqr(A,B,Q,R);

F = -F
eig(A+B*F)

%% simulation

Model = 'cartpend_simulator';
open_system(Model);
set_param(Model, 'StopTime', '10');
sim(Model);
close_system(Model);
data = ans;

%% plot

figure
plot(data.time, data.cart_position, 'b', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Cart Position [m]')
set(gca, 'FontSize', 23)

figure
plot(data.time, data.pole_angle, 'b', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Pole Angle [rad]')
set(gca, 'FontSize', 23)

figure
plot(data.time, data.voltage, 'b', 'LineWidth', 3)
grid on
xlabel('Time [s]')
ylabel('Voltage [V]')
set(gca, 'FontSize', 23)
