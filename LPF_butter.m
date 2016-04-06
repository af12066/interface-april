%%%%%%%%%%%%%%%%%%%%%
% Interface Apr. 2015
% pp. 49-50
% Copyright (c) 2016 T. Hashimoto
% This software is released under the MIT License, see LICENSE.
%%%%%%%%%%%%%%%%%%%%%

Fs = 1000; %�T���v�����O���g��
Fd = 30; %�J�b�g�I�t���g��
T = 1/Fs;

%%% �� (4) ��p���Ď��g���v�����[�s���O omega_a �����߂�
omega_a = 2 / T * tan(pi*Fd*T);

%%% �v�����[�s���O�ŕ␳�����A�i���O�t�B���^�̎Ւf���g��Fa���v�Z����
Fa = omega_a / (2*pi);

%%% ���g���덷
error_freq = Fa - Fd;


%% �o�^���[�X�t�B���^�̐݌v (�����C���K���������g���C�n�C�p�X�E���[�p�X�E�o���h�p�X)
[b, a] = butter(2, Fd/(Fs/2), 'low');

% �߂�l�� {b + 2*b*z^(-1) + b*z^(-2)} / {1 + a_1*z^(-1) + a_2*z^(-2)} �ɑΉ����Ă���D
% 
%

freqz(b, a, 10000, Fs);

%% �o�^���[�X�t�B���^�̐݌v (���蓮��)

lambda = tan(pi * Fd * T);
Q = 1 / sqrt(2);
sigma = lambda^2 + lambda / Q + 1;

beta = lambda^2 / sigma;
alpha1 = 2 * (lambda^2 - 1) / sigma;
alpha2 = 1 - (2*lambda / Q) / sigma;
% �� (6) �̌W��b, a�� butter �̖߂�l�̂悤�ɂ���
b = [beta 2*beta beta];
a = [1 alpha1 alpha2];