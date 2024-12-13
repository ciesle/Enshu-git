close all

%%

% 読み込むファイルの名前　data_***.mat
filenum = 'paoropt3000100130.0.mat';
load(filenum)

%%

% 構造体dataには6種類の信号が保存されている．
% ワークスペースにdataが表示されていたらクリックして保存された信号を確認できる．
% 表示されていなければこのプログラムを1度実行すると表示される．
% オブザーバを使った制御実験の場合は推定値も保存されている．
figure
plot(data.time, data.cart_position, 'b', 'LineWidth', 2)
hold on
plot(data.time, data.cart_position_hat, 'r', 'LineWidth', 2)
hold off
grid on
xlabel('Time [s]')
ylabel('Cart Position [m]')
legend('true value','predicted value')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.cart_velocity, 'b', 'LineWidth', 2)
hold on
plot(data.time, data.cart_velocity_hat, 'r', 'LineWidth', 2)
hold off
grid on
xlabel('Time [s]')
ylabel('Cart Velocity [m/s]')
legend('true value','predicted value')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angle, 'b', 'LineWidth', 2)
hold on
plot(data.time, data.pole_angle_hat, 'r', 'LineWidth', 2)
hold off
grid on
xlabel('Time [s]')
ylabel('Pendulum Angle [rad]')
legend('true value','predicted value')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angularvelocity, 'b', 'LineWidth', 2)
hold on
plot(data.time, data.pole_angularvelocity_hat, 'r', 'LineWidth', 2)
hold off
grid on
xlabel('Time [s]')
ylabel('Pendulum Angular Velocity [rad/s]')
legend('true value','predicted value')
set(gca, 'FontSize', 15)