# -*- coding: utf-8 -*-
from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

fs = 1000 #サンプリング周波数
dt = 1 / fs #サンプリング間隔
fc = 0.5 #カットオフ周波数

b, a = signal.iirfilter(1, fc / (fs / 2), btype = 'highpass', analog = False, ftype = 'butter', output = 'ba') #バタワースフィルタの設計
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