%%%%%%%%%%%%%%%%%%%%%
% Interface Apr. 2015
% pp. 49-50
% Copyright (c) 2016 T. Hashimoto
% This software is released under the MIT License, see LICENSE.
%%%%%%%%%%%%%%%%%%%%%

Fs = 1000; %サンプリング周波数
Fd = 30; %カットオフ周波数
T = 1/Fs;

%%% 式 (4) を用いて周波数プリワーピング omega_a を求める
omega_a = 2 / T * tan(pi*Fd*T);

%%% プリワーピングで補正したアナログフィルタの遮断周波数Faを計算する
Fa = omega_a / (2*pi);

%%% 周波数誤差
error_freq = Fa - Fd;


%% バタワースフィルタの設計 (次数，正規化した周波数，ハイパス・ローパス・バンドパス)
[b, a] = butter(2, Fd/(Fs/2), 'low');

% 戻り値は {b + 2*b*z^(-1) + b*z^(-2)} / {1 + a_1*z^(-1) + a_2*z^(-2)} に対応している．
% 
%

freqz(b, a, 10000, Fs);

%% バタワースフィルタの設計 (半手動で)

lambda = tan(pi * Fd * T);
Q = 1 / sqrt(2);
sigma = lambda^2 + lambda / Q + 1;

beta = lambda^2 / sigma;
alpha1 = 2 * (lambda^2 - 1) / sigma;
alpha2 = 1 - (2*lambda / Q) / sigma;
% 式 (6) の係数b, aを butter の戻り値のようにする
b = [beta 2*beta beta];
a = [1 alpha1 alpha2];