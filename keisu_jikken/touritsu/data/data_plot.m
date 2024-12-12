close all

%%

% 読み込むファイルの名前　data_***.mat
filenum = 'opt1000001001';
filenum=strjoin({filenum, '.mat'},'');
load(filenum)

%%

% 構造体dataには6種類
% 
% の信号が保存されている．
% ワークスペースにdataが表示されていたらクリックして保存された信号を確認できる．
% 表示されていなければこのプログラムを1度実行すると表示される．
% オブザーバを使った制御実験の場合は推定値も保存されている．
figure
plot(data.time, data.cart_position, 'b', 'LineWidth', 2)
grid on
xlabel('Time [s]')
ylabel('Cart Position [m]')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.cart_velocity, 'b', 'LineWidth', 2)
grid on
xlabel('Time [s]')
ylabel('Cart Velocity [m/s]')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angle, 'b', 'LineWidth', 2)
grid on
xlabel('Time [s]')
ylabel('Pendulum Angle [rad]')
set(gca, 'FontSize', 15)

figure
plot(data.time, data.pole_angularvelocity, 'b', 'LineWidth', 2)
grid on
xlabel('Time [s]')
ylabel('Pendulum Angular Velocity [rad/s]')
set(gca, 'FontSize', 15)