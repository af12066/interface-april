# -*- coding: utf-8 -*-
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

fs = 1000 #サンプリング周波数
dt = 1 / fs #サンプリング間隔
fc = 20 #カットオフ周波数

b, a = signal.iirfilter(1, fc / (fs / 2), btype = 'lowpass', analog = False, ftype = 'butter', output = 'ba') #バタワースフィルタの設計
w, h = signal.freqz(b, a, 10000)

f = w / (2 * np.pi) * fs #周波数軸の生成
a = 20 * np.log10(abs(h)) #振幅
p = np.angle(h) * 180 / np.pi #位相

#プロット
plt.subplot(211)

plt.plot(f, a)
plt.xscale('log')
plt.title("Magnitude")
plt.xlabel('Freq [Hz')
plt.ylabel('Amp [dB]')
plt.xlim(0.1, 100)
plt.grid(which='both', axis='both')

plt.subplot(212)
plt.plot(f, p)
plt.xscale('log')
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
freq1 = 2
freq2 = 0.2
y1 = np.sin(2 * np.pi * freq1 * t) + 0.5*np.random.randn(t.size)
y2 = np.sin(2 * np.pi * freq2 * t) + 0.5*np.random.randn(t.size)

b1, a1 = signal.butter(1, fc / (fs / 2), btype='low', analog=False, output='ba')
yy1 = signal.filtfilt(b1, a1, y1)

yy2 = signal.filtfilt(b1, a1, y2)

plt.subplot(211)

plt.plot(t, y1, 'b')
plt.plot(t, yy1, 'r')
plt.title("Wave1")
plt.xlabel('Time')
plt.ylabel('Amp')

plt.subplot(212)
plt.plot(t, y2, 'b')
plt.plot(t, yy2, 'r')
plt.title("Wave2")
plt.ylabel('Amp')