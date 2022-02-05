clc
close all
clear all

Fs = 48000; %Sampling rate
T = 10;
N = Fs * T;
buf_size = Fs*2;  % max buffer size (delay time cannot be larger than half the buffer size)

%========================================================================
% Delay delay settings

delay_time = 600;                       % delay time in ms
delay_samples = Fs * (delay_time/1000); % Delay time in samples
Drive = 0.9;                                % Scalar gain value
FeedBack = 0.7;
%========================================================================

[x, Fs] = audioread('Alesis-Fusion-Clean-Guitar-c3.wav');

y = zeros(N,2);
buffer = zeros(buf_size,2);
write = 1;   % read first position
read = buf_size - delay_samples;   % write position is delay num samples ahead

channel_1 = 1;
channel_2 = 2;
m = 1;

for n = 1:N
     
     if n > length(x)
         in = 0;
     else
         in_L = x(n, 1);
         in_R = 0;
     end
         y(n,1) = in_L + (buffer(read,1));
         y(n,2) = in_R + (buffer(read,2)); 
 
     buffer(write, channel_2) = ((in_L * Drive) + (y(n,1) * FeedBack));
     buffer(write, channel_1) = ((in_R * Drive) + (y(n,2) * FeedBack));

    read = read + 1;
    if (read > buf_size)
     read = read - buf_size;
    end
   write = write + 1;
   if (write > buf_size)
     write = write - buf_size;
    end
end

figure(1)
subplot(2,1,1)
stem(x);
xlabel("n")
ylabel("x(n)")
subplot(2,1,2)
stem(y);
xlabel("n")
ylabel("y(n)")
sound(y,Fs);