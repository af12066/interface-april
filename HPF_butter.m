%%%%%%%%%%%%%%%%%%%%%
% Interface Apr. 2015
% pp. 46-48
% Copyright (c) 2016 T. Hashimoto
% This software is released under the MIT License, see LICENSE.
%%%%%%%%%%%%%%%%%%%%%

Fs = 1000; %サンプリング周波数
Fd = 0.5; %カットオフ周波数
T = 1/Fs;

%%% 式 (4) を用いて周波数プリワーピング omega_a を求める
omega_a = 2 / T * tan(pi*Fd*T);

%%% プリワーピングで補正したアナログフィルタの遮断周波数Faを計算する
Fa = omega_a / (2*pi);

%%% 周波数誤差
error_freq = Fa - Fd;


%% バタワースフィルタの設計 (次数，正規化した周波数，ハイパス・ローパス・バンドパス)
[b, a] = butter(1, Fd/(Fs/2), 'high');

% 戻り値は {b_1 + b_2*z^(-1)} / {a_1 + a_2*z^(-1)} に対応している．
% 
%

freqz(b, a, 10000, Fs);

%% バタワースフィルタの設計 (半手動で)

lambda = tan(pi * Fd * T);
alpha = (lambda - 1) / (lambda + 1);
beta = 1 / (lambda + 1);

% 式 (6) の係数b, aを butter の戻り値のようにする
b = [beta -beta];
a = [1 alpha];