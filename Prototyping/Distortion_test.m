clc
clear all
close all


Fs = 48000; %Sampling rate
T = 10;
N = Fs * T;
f = 400; 
d = 3;

for n = 1:N
    
    x(n) = sin(2*pi*f*(1/Fs)*n);
    [y(n)] = distortion(x(n), d);
end


figure(3)
plot(y);
xlabel("n")
ylabel("x(n)")
hold on;
plot(x);
xlabel("n")
ylabel("y(n)")
axis([0 500 -1 1]);

