%%%%%%%%%%%%%%%%%%%%%
% Interface Apr. 2015
% pp. 46-48
% Copyright (c) 2016 T. Hashimoto
% This software is released under the MIT License, see LICENSE.
%%%%%%%%%%%%%%%%%%%%%

Fs = 1000; %�T���v�����O���g��
Fd = 0.5; %�J�b�g�I�t���g��
T = 1/Fs;

%%% �� (4) ��p���Ď��g���v�����[�s���O omega_a �����߂�
omega_a = 2 / T * tan(pi*Fd*T);

%%% �v�����[�s���O�ŕ␳�����A�i���O�t�B���^�̎Ւf���g��Fa���v�Z����
Fa = omega_a / (2*pi);

%%% ���g���덷
error_freq = Fa - Fd;


%% �o�^���[�X�t�B���^�̐݌v (�����C���K���������g���C�n�C�p�X�E���[�p�X�E�o���h�p�X)
[b, a] = butter(1, Fd/(Fs/2), 'high');

% �߂�l�� {b_1 + b_2*z^(-1)} / {a_1 + a_2*z^(-1)} �ɑΉ����Ă���D
% 
%

freqz(b, a, 10000, Fs);

%% �o�^���[�X�t�B���^�̐݌v (���蓮��)

lambda = tan(pi * Fd * T);
alpha = (lambda - 1) / (lambda + 1);
beta = 1 / (lambda + 1);

% �� (6) �̌W��b, a�� butter �̖߂�l�̂悤�ɂ���
b = [beta -beta];
a = [1 alpha];