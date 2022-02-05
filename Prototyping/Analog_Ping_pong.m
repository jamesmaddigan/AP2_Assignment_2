clc
close all
clear all

Fs = 48000; %Sampling rate
T = 10;
N = Fs * T;
buf_size = Fs*2;  % max buffer size (delay time cannot be larger than half the buffer size)

%========================================================================
% Delay delay settings

z = 1.5;
delay_time = 400;                       % delay time in ms
delay_samples = Fs * (delay_time/1000); % Delay time in samples
Drive = 1;                                % Scalar gain value
FeedBack = 1;
%========================================================================
% filter controls
fc = 1500;
%========================================================================
% Distortion Controls
distortion_control = 2;
%========================================================================
% StepResponse for Ping Pong(transition from one channel to other
alpha = 0.75;
previousOutput = 0;
%========================================================================
% Input unit impulse

%x = zeros(N,1); % Input signal storage initialisation
%x(1) = 1;   % Define input test signal as Kronecker Delta function
[x, Fs] = audioread('Alesis-Fusion-Clean-Guitar-c3.wav');

y = zeros(N,2);
buffer = zeros(buf_size,2);
write = 1;   % write first position
read = buf_size - delay_samples;   
xz1L = 0;
yz1L = 0;
xz2L = 0;
yz2L = 0;
xz1R = 0;
yz1R = 0;
xz2R = 0;
yz2R = 0;

channel_1 = 1;
channel_2 = 2;


for n = 1:N
     
     if n > length(x)
         in = 0;
     else
         in_L = x(n, 1);
         in_R = 0;
     end
     
         filteredSignal_L = lowPassFilter(distortion(buffer(read,1), distortion_control), xz1L, yz1L, xz2L, yz2L, Fs, fc);
         y(n,1) = in_L + (buffer(read,1));
        
         filteredSignal_R = lowPassFilter(distortion(buffer(read,2), distortion_control), xz1R, yz1R, xz2R, yz2R, Fs, fc);
         y(n,2) = in_R + (buffer(read,2)); 

     
     buffer(write, channel_2) = lowPassFilter(distortion(((in_L * Drive) + (y(n,1) * FeedBack)), distortion_control),xz1L, yz1L, xz2L, yz2L, Fs, fc);
     buffer(write, channel_1) = lowPassFilter(distortion(((in_R * Drive) + (y(n,2) * FeedBack)), distortion_control),xz1R, yz1R, xz2R, yz2R, Fs, fc);
    
         xz2L = xz1L;
         xz1L = in_L;
         yz2L = yz1L;
         yz1L = filteredSignal_L;
         
         xz2R = xz1R;
         xz1R = in_R;
         yz2R = yz1R;
         yz1R = filteredSignal_R;
          
         
         

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
ylabel("x(n)")
sound(y,Fs);
