clc
clear all
close all


Fs = 48000; %Sampling rate
T = 10;
N = Fs * T;
d = 1;
level = 0.8;
f = 1000;

x = zeros(N,1); % Input signal storage initialisation
x(1) = 1;   % Define input test signal as Kronecker Delta function
xz1 = 0;
yz1 = 0;
xz2 = 0;
yz2 = 0;

for n = 1:N
    
    %[y(n), xz1, yz1] = highShelf(x(n),xz1,yz1,Fs,T,f,level);
    [y(n), xz1, yz1, xz2, yz2] = lowPassFilter(x(n), xz1, yz1, xz2, yz2, Fs, f);
   
end

figure(1)
semilogx(20*log10(abs(fft(y))))
axis([0 Fs/2 -13 13])
title('Magnitude Response of LPF')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')



