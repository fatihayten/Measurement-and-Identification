%% Task 1.2
%1.2.1
%Question 1.1: ADC Dynamic Range = (2^16)-1
% Reference: https://www.allaboutcircuits.com/technical-articles/understanding-the-dynamic-range-specification-of-an-ADC/

%% Task 1.2.2
% What is the minimum sampling frequency required to perfectly reconstruct a
% sinusoidal signal with a frequency of 10 Hz? : 20 Hz

%% Task 1.3
%Question 1.2 Accuracy FRF: Why is this the case?

% The lower the crest factor, the more measurement power is fed to the circuit
% for a certain amplitude level: hence we can quote the crest factor as the required
% signal amplitude per unity power. Therefore, it is wise to add Schroeder
% phase to multiple sinusoids, or at least random phase to obtain low crest
% factor.

%% Task 1.4.1
%Question 1.3
clc
close all
clear all
bins = (1:100);
n = 0:4095;
random_phase = 2*pi*rand(1,100);
schroeder_phase = bins.*(bins+1)*pi/100;
constant_phase = pi;
N = 4096;

sines = zeros(100,4096);
%Random phase
for i = 1:100
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*random_phase(i));
end
multisine_random_phase = sum(sines,1);



%Schroeder phase
for i = 1:100
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*schroeder_phase(i));
end
multisine_schroeder = sum(sines,1);


%Constant phase
for i = 1:100
    sines(i,:) = cos(2*pi*bins(i)*n/N+constant_phase);
end
multisine_constant = sum(sines,1);


%Question 1.4
crest_factor_schroeder = max(multisine_schroeder)/sqrt((sum(multisine_schroeder.*multisine_schroeder)/N))
crest_factor_random = max(multisine_random_phase)/sqrt((sum(multisine_random_phase.*multisine_random_phase)/N))
crest_factor_constant = max(multisine_constant)/sqrt((sum(multisine_constant.*multisine_constant)/N))

% Min crest factor : Schroeder, Max crest factor : Constant

%Question 1.5

%Random phase
figure;
x = (abs(fft(multisine_random_phase)));
y = (angle(fft(multisine_random_phase)));
subplot(3,1,1)
plot(x(2:2048));
title("FFT Bins Magnitude Plot of Random Phase");
xlabel("frequency bins")
subplot(3,1,2)
plot(y(2:2048)/pi);
ylabel("*\pi")
title("FFT Bins Phase Plot of Random Phase");
xlabel("frequency bins")
subplot(3,1,3)
plot(multisine_random_phase)
title("Time Samples Plot of Random Phase");
xlabel("time samples")

%Schroeder phase
figure;
x = (abs(fft(multisine_schroeder)));
y = (angle(fft(multisine_schroeder)));
subplot(3,1,1)
plot(x(2:2048));
title("FFT Bins Magnitude Plot of Schroeder Phase");
xlabel("frequency bins")
subplot(3,1,2)
plot(y(2:2048)/pi);
ylabel("*\pi")
title("FFT Bins Phase Plot of Schroeder Phase");
xlabel("frequency bins")
subplot(3,1,3)
plot(multisine_schroeder)
title("Time Samples Plot of Schroeder Phase");
xlabel("time samples")

%Constant phase
figure;
x = (abs(fft(multisine_constant)));
y = (angle(fft(multisine_constant)));
subplot(3,1,1)
plot(x(2:2048));
title("FFT Bins Magnitude Plot of Constant Phase");
xlabel("frequency bins")
subplot(3,1,2)
plot(y(2:2048)/pi);
ylabel("*\pi")
title("FFT Bins Phase Plot of Constant Phase");
xlabel("frequency bins")
subplot(3,1,3)
plot(multisine_constant)
title("Time Samples Plot of Constant Phase");
xlabel("time samples")