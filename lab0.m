%% Task 2.1
close all
n = 0:999;
f = 3/1000; % If period is 1000/3, frequency is 3/1000
random_phase = 2*pi*rand;
cosine = cos(2*pi*f*n+random_phase);
figure;
plot(n,cosine)
figure;
subplot(2,1,1)
plot(fftshift(n),fftshift(abs(fft(cosine))))
title("Magnitude of FFT")
subplot(2,1,2)
plot(n,angle(fft(cosine)))
title("Angle (Phase) of FFT")



%% Task 2.2
% Window length = 1000
% Period = 1000/3
% Since window length is integer multiple of period, perfect construction
% can be realized. (Lecture Notes Page 137)
%From DFT, it can be seen that at only 3rd bin has non-zero value. (Try with f = 1.5/1000)
% There is no leakage visible.

%% Task 2.3
% Non-zero value appears at 3rd bin. 3rd bin represents the frequency 3/1000.
figure;
subplot(2,1,1)
plot((n),(abs(fft(cosine))))
xlabel("frequency bins")
title("Magnitude of FFT")
subplot(2,1,2)
plot(n,angle(fft(cosine)))
xlabel("frequency bins")
title("Angle (Phase) of FFT")
%% Task 2.4
close all
fs = 100;
Ts = 1/100;
n = 0:999;
f = 3/1000; % If period is 1000/3, frequency is 3/1000
xaxis_in_Hz = n/10; % N*Ts = 1000/100 = 10
random_phase = 2*pi*rand;
cosine = cos(2*pi*f*n+random_phase);

figure;
w = abs(fft(cosine));
plot((xaxis_in_Hz(1:501)),w(1:501))
title("Magnitude of FFT")
xlabel("frequency in Hz")

%% Task 3.1
periods = [2 4 5 10 20 40 50 100 200 500 ];
frequencies = 1./periods;
n = linspace(0,1000,1000);
sines = zeros(10,1000);
for i = 1:10
    sines(i,:) = sin(2*pi*frequencies(1,i)*n+2*pi*rand);
end

multisine = sum(sines,1);

figure;
plot(n,multisine)
figure;
plot(fftshift(n),fftshift(abs(fft(multisine))))
title("Magnitude of FFT")
xlabel("frequency in bins")


%% Task 3.2
close all
fs = 100;
Ts = 1/fs;
frequencies = [1 2 4 5 10 15 20 25 40 45 ];

n = 0:999;
sines = zeros(10,1000);
for i = 1:10
    sines(i,:) = sin(2*pi*frequencies(1,i)*n*Ts+2*pi*rand);
end

multisine = sum(sines,1);
xaxis_in_Hz = (0:500)/10; % k = 0,1,... N/2; N*Ts = 1000/100 = 10
figure;
plot(n/fs,multisine);
xlabel("Time in sec");

figure;
fft_of = (abs(fft(multisine)));
plot(xaxis_in_Hz(1:501),fft_of(1:501))
title("Magnitude of FFT");
xlabel("frequency in Hz");
%% Task 3.3
close all
fs = 200;
Ts = 1/fs;
frequencies = [4, 8, 12, 16, 20, 24 ];

n = 0:999;
sines = zeros(6,1000);
for i = 1:6
    sines(i,:) = sin(2*pi*frequencies(1,i)*n*Ts+2*pi*rand);
end

multisine = sum(sines,1);
xaxis_in_Hz = (0:500)/5; % k = 0,1,... N/2; N*Ts = 1000/200 = 5
figure;
plot(n/fs,multisine);
xlabel("Time in sec");

figure;
fft_of = (abs(fft(multisine)));
plot(xaxis_in_Hz(1:501),fft_of(1:501))
title("Magnitude of FFT");
xlabel("frequency in Hz");


%% Task 4.2
close all
clear all
sines = zeros(30,1000);
bins = 5*(1:30);
n = linspace(0,1000,1000);
A = rand(1,30);
N = 1000;
k = 1:30;
for i = 1:30
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*A(i));
end
multisine = sum(sines,1);
figure;
plot((abs(fft(multisine))));
figure;
plot(multisine)

%% Task 4.3
close all
clear all

fs = 50;
Ts = 1/fs;
frequencies =  linspace(5,15,30);

sines = zeros(30,1000);
bins = 1:30;
n = 0:999;
A = rand(1,30);
N = 1000;
k = 1:30;
for i = 1:30
    sines(i,:) = cos(2*pi*frequencies(i)*n*Ts+2*pi*A(i));
end
multisine = sum(sines,1);
xaxis_in_Hz = (0:500)/20; % k = 0,1,... N/2; N*Ts = 1000/50 = 20
figure;
plot(n/fs,multisine);
xlabel("Time in sec");

figure;
fft_of = (abs(fft(multisine)));
plot(xaxis_in_Hz(1:501),fft_of(1:501))
title("Magnitude of FFT");
xlabel("frequency in Hz");

%% Task 5
clc
close all
clear all
bins = (1:60);
n = 0:499;
random_phase = 2*pi*rand(1,60);
schroeder_phase = bins.*(bins+1)*pi/60;
linear_phase = bins*pi;
N = 500;


%Random phase
for i = 1:60
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*random_phase(i));
end
multisine = sum(sines,1);
figure;
plot((abs(fft(multisine))));
title("FFT Bins Plot of Random Phase");
figure;
plot(multisine)
title("Time Samples Plot of Random Phase");

crest_factor_random = max(multisine)/sqrt((sum(multisine.*multisine)/N))

%Schroeder phase
for i = 1:60
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*schroeder_phase(i));
end
multisine = sum(sines,1);
figure;
plot((abs(fft(multisine))));
title("FFT Bins Plot of Schroeder Phase");

figure;
plot(multisine)
title("Time Samples Plot of Schroeder Phase");
crest_factor_schroeder = max(multisine)/sqrt((sum(multisine.*multisine)/N))

%Linear phase
for i = 1:60
    sines(i,:) = cos(2*pi*bins(i)*n/N+2*pi*linear_phase(i));
end
multisine = sum(sines,1);
figure;
plot((abs(fft(multisine))));
title("FFT Bins Plot of Linear Phase");
figure;
plot(multisine)
title("Time Samples Plot of Linear Phase");
crest_factor_liear = max(multisine)/sqrt((sum(multisine.*multisine)/N))

% Observation: Max crest factor occurs in linear phase, min crest in
% schroeder. Sometimes random and schroeder become close each other.

%% Task 6.1
clc
clear all
close all
gauss = randn(1,1000);
figure;
subplot(3,1,1);
plot(gauss);
title("Time Samples of Gaussian Noise")
subplot(3,1,2);
plot(abs(fft(gauss)))
title("FFT Magnitude of Gaussian Noise")
subplot(3,1,3);
plot(angle(fft(gauss)))
title("FFT Phase of Gaussian Noise")

%% Task 6.2
clc
clear all
close all
fc = 5;
fs = 100;

[b,a] = cheby1(5,2,fc/(fs/2));

freqz(b,a,[],fs)
subplot(2,1,1)

dataIn = randn(1,1000);
dataOut = filter(b,a,dataIn);
figure;
subplot(3,1,1);
plot(dataOut);
title("Time Samples of Filtered Gaussian Noise")
subplot(3,1,2);
plot(abs(fft(dataOut)))
title("FFT Magnitude of Filtered Gaussian Noise")
subplot(3,1,3);
plot(angle(fft(dataOut)))
title("FFT Phase of Filtered Gaussian Noise")

%% Task 6.3
clc
clear all
close all
fs = 100;
Ts = 1/fs;

sines = zeros(51,1000);
bins = linspace(0,5,51);
n = 0:999;
phase = rand(1,51);
amplitude = rand(1,51);
k = 1:51;
for i = 1:51
    sines(i,:) = amplitude(i)*cos(2*pi*bins(i)*n*Ts+2*pi*phase(i));
end
multisine = sum(sines,1);

xaxis_in_Hz = (0:500)/10; % k = 0,1,... N/2; N*Ts = 1000/50 = 20
figure;
plot(n/fs,multisine);
xlabel("Time in sec");

figure;
fft_of = (abs(fft(multisine)));
plot(xaxis_in_Hz(1:501),fft_of(1:501))
title("Magnitude of FFT");
xlabel("frequency in Hz");

% Copying One After Each Other and Recalculating DFT
new_n = 0:1999;
repeated_multisine = [multisine multisine];
figure;
plot(new_n/fs,repeated_multisine);
xlabel("Time in sec");
xaxis_in_Hz = (0:1000)/20; % k = 0,1,... N/2; N*Ts = 1000/50 = 20

figure;
fft_of = (abs(fft(repeated_multisine)));
plot(xaxis_in_Hz(1:1001),fft_of(1:1001))
title("Magnitude of FFT");
xlabel("frequency in Hz");

%% Task 7
rms_desired = 3;

fs = 100;
Ts = 1/fs;
N = 1000;
sines = zeros(51,1000);
bins = linspace(0,5,51);
n = 0:999;
phase = rand(1,51);
amplitude = rand(1,51);
k = 1:51;
for i = 1:51
    sines(i,:) = amplitude(i)*cos(2*pi*bins(i)*n*Ts+2*pi*phase(i));
end
multisine = sum(sines,1);
real_rms = max(multisine)/sqrt((sum(multisine.*multisine)/N));
x_desired = multisine*rms_desired/real_rms;
plot(multisine);
hold on
plot(x_desired);
legend("first one","modified")

