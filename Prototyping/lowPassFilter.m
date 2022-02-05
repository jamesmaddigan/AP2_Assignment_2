
function [filteredSignal, xz1, yz1, xz2, yz2] = lowPassFilter(x,xz1, yz1, xz2, yz2, Fs, fc)

Qb = 1/sqrt(2);             % Butterworth quality factor
w0 = 2*pi*fc/Fs;            % Normalised cutoff frequency
alphab = sin(w0)/(2*Qb);

a0 = 1 + alphab;
b0 = (1-cos(w0))/2;
b1 = 1- cos(w0);
b2 = (1-cos(w0))/2;
a1 = -2*cos(w0);
a2 = 1 - alphab;

b0 = b0/a0;
b1 = b1/a0;
b2 = b2/a0;
a1 = a1/a0;
a2 = a2/a0;
a0 = a0/a0;

filteredSignal = b0*x + b1*xz1 + b2*xz2 - a1*yz1 - a2*yz2;
        
xz2 = xz1;        
xz1 = x;
yz2 = yz1;
yz1 = filteredSignal;

end

