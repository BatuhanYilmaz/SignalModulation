%% AM w/ envelope detector, DSB-SC, SSB 
clear; clc;
 
Am = 0.5;  % Message Amplitude
fm = 50;   % Message frequency
 
A = 5;  % some constant
fc = 200; % Carrier frequency
fs = 100*fc; % Sample frequency
 
t = 0:1/fs:4/fm;
 
% Message signal
my_msg = Am*(0.5*sin(2*pi*fm*t)-0.5*cos(2*pi*2*fm*t)-0.25*sin(2*pi*3*fm*t));
 
%% MODULATION PART
% A general carrier for the signals
carr = cos(2*pi*fc*t);
 
e = A+my_msg;   % Envelope creator for AM          
 
% Muliplying with carriers
% For AM
am_env_carr = e.*carr; 
 
% For DSB-SC
dsb_sc_carr = my_msg.*carr;  
 
% For SSB
mh = imag(hilbert(my_msg));     % Hilbert-transformed message
carr_imag = sin(2*pi*fc*t); % Carrier for Hilbert-transformed message
u_sb = my_msg.*carr - mh.*carr_imag;   % Upper-sideband
l_sb = my_msg.*carr + mh.*carr_imag;   % Lower-sideband
 
% Lowpass filter (10th order Butterworth) 
% for clipping higher frequency components
[num,den] = butter(10,fc*2/fs);
 
%% DEMODULATION PART
 
%AM demodulation
 
%am_demod = amdemod(am_env_carr,fc,fs,0,A,num,den);
 
[am_demod,noneed] = envelope(am_env_carr);
am_demod = am_demod-A;
 
%DSB-SC demodulation
 
dsb_sc_demod = filtfilt(num,den,dsb_sc_carr.*(2.*carr));
 
%SSB demodulation
 
u_sb_demod = filtfilt(num,den,u_sb.*(2.*carr));
l_sb_demod = filtfilt(num,den,l_sb.*(2.*carr));
 
%% PLOTTING RESULTS
figure(1)
hold on;
plot(t,my_msg,'b');
plot(t,am_demod,'r--');
hold off;
title('AM w/ Envelope Detector');
xlabel('Time');
ylabel('Message');
legend('Real message','Demodulated signal')
 
 
figure(2)
hold on
plot(t,e,'b');
plot(t,am_env_carr,'r--');
hold off
title('AM Modulated Signal and Envelope');
xlabel('Time');
ylabel('Message');
legend('Modulated signal','Upper envelope')
 
figure(3)
hold on;
plot(t,my_msg,'b');
plot(t,dsb_sc_demod,'r--');
hold off;
title('Double Sideband-Suppressed Carrier AM');
xlabel('Time');
ylabel('Message');
legend('Real message','Demodulated signal')
 
figure(4)
hold on;
plot(t,dsb_sc_carr,'b');
hold off;
title('DSB-SC Modulated Signal');
xlabel('Time');
ylabel('Message');
legend('Modulated signal')
 
figure(5)
hold on
plot(t,my_msg,'b');
plot(t,l_sb_demod,'k--'); % ANSWER OF PART2 d): You can decide which side %of the BW to use plot(t,u_sb_demod),'r--';
hold off
title('Single Sideband Modulation');
xlabel('Time');
ylabel('Message');
legend('Real message','Demodulated signal')
 
figure(6)
hold on
%plot(t,l_sb_demod,'k--'); % You can decide which side of the BW to use
plot(t,l_sb),'b--';
plot(t,u_sb),'r--';
hold off
title('Single Sideband Modulated Signal');
xlabel('Time');
ylabel('Message');
legend('Left-hand side','Right-hand side')

