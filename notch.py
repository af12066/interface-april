# -*- coding: utf-8 -*-
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

fs = 1000
fd = 50
dt = 1 / fs
Q = 1 / np.sqrt(2)

lmd = np.tan(np.pi * fd * dt)
sigma = np.power(lmd, 2) + lmd / Q + 1

beta0 = (np.power(lmd, 2) + 1) / sigma
beta1 = 2 * (np.power(lmd, 2) - 1) / sigma
alpha1 = beta1
alpha2 = 1 - (2 * lmd / Q) / sigma

b = np.array([beta0, beta1, beta0])
a = np.array([1, alpha1, alpha2])

w, h = signal.freqz(b, a, 10000)

f = w / (2 * np.pi) * fs #周波数軸の生成
amp = 20 * np.log10(abs(h)) #振幅
p = np.angle(h) * 180 / np.pi #位相

#プロット
plt.subplot(211)

plt.plot(f, amp)
plt.title("Magnitude")
plt.xlabel('Freq [Hz')
plt.ylabel('Amp [dB]')
plt.xlim(0.1, 100)
plt.grid(which='both', axis='both')

plt.subplot(212)
plt.plot(f, p)
plt.title('Phase')
plt.xlabel('Freq [Hz]')
plt.ylabel('Amp [Hz]')
plt.xlim(0.1, 100)
plt.ylim(-180, 180)
plt.grid(which='both', axis='both')

plt.show()

# 正弦波にフィルタをかける

n = 10000 #サンプル数
t = np.linspace(1, n, n)*dt - dt
y = np.sin(2 * np.pi * fd * t)
yy = signal.filtfilt(b, a, y)

plt.plot(t, y, 'b')
plt.plot(t, yy, 'r')
plt.title("Wave1")
plt.xlabel('Time')
plt.ylabel('Amp')