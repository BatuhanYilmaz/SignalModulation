clc;
clear all;
close all;

%% Modulator and Demodulator Objects %%%
h_qpsk = modem.pskmod('M',4,'phaseoffset',pi/4,'inputtype','bit');
g_qpsk = modem.pskdemod('M',4,'phaseoffset',pi/4,'outputtype','bit');

h_16psk = modem.pskmod('M',16,'phaseoffset',pi/4,'inputtype','bit');
g_16psk = modem.pskdemod('M',16,'phaseoffset',pi/4,'outputtype','bit');

 h_16qam = modem.qammod('M',16,'inputtype','bit');
g_16qam = modem.qamdemod('M',16,'outputtype','bit');
 h_64qam = modem.qammod('M',64,'inputtype','bit');
g_64qam = modem.qamdemod('M',64,'outputtype','bit');
%%%% TRANSMITTER   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  in=imread('lena.jpg');    % image to be transmitted and matlab code should be in same directory
  N=numel(in);
  in2=reshape(in,N,1);
  bin=de2bi(in2,'left-msb');
  input=reshape(bin',numel(bin),1);
  len=length(input);
% %%%%% padding zeroes to input %%%
 z=len;
 while(rem(z,2) || rem(z,4)|| rem(z,6))
     z=z+1;
     input(z,1)=0;
 end
 input = double(input);
  y_qpsk=modulate(h_qpsk,input);
  y_16psk = modulate(h_16psk,input);
 y_16qam=modulate(h_16qam,input);
 y_64qam=modulate(h_64qam,input);

 ifft_out_qpsk=ifft(y_qpsk);
 ifft_out_16psk = ifft(y_16psk);
 ifft_out_16qam=ifft(y_16qam);
 ifft_out_64qam=ifft(y_64qam);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SNR = 10;          % SNR in dB
 tx_qpsk = awgn(ifft_out_qpsk,SNR,'measured');
 tx_16psk = awgn(ifft_out_16psk,SNR,'measured');
 tx_16qam=awgn(ifft_out_16qam,SNR,'measured');
 tx_64qam=awgn(ifft_out_64qam,SNR,'measured');
% %%%    RECEIVER  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% QPSK RECEIVER STRUCTURE
% Discrete Fourier Transform
k_qpsk = fft(tx_qpsk);
l_qpsk = demodulate(g_qpsk,k_qpsk);
output_qpsk = uint8(l_qpsk);
output_qpsk = output_qpsk(1:len);
% Sampling back to 8-bit symbols
b1 = reshape(output_qpsk,8,N)';
% Binary-to-decimal conversion from the symbols
dec_qpsk = bi2de(b1,'left-msb');
% Bit error rate calculation for QPSK
BER_qpsk = biterr(input,l_qpsk)/len
% Reconstructed image for QPSK, 729x730x3
im_qpsk = reshape(dec_qpsk(1:N),size(in,1),size(in,2),size(in,3));
%im_qpsk=reshape(dec_qpsk(1:N),730,729,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 16-PSK RECEIVER STRUCTURE
% Discrete Fourier Transform
k_16psk = fft(tx_16psk);
l_16psk = demodulate(g_16psk,k_16psk);
output_16psk = uint8(l_16psk);
output_16psk = output_16psk(1:len);
% Sampling back to 8-bit symbols
b_16 = reshape(output_16psk,8,N)';
% Binary-to-decimal conversion from the symbols
dec_16psk = bi2de(b_16,'left-msb');
% Bit error rate calculation for QPSK
BER_16psk = biterr(input,l_16psk)/len
% Reconstructed image for QPSK, 729x730x3
%im_qpsk = reshape(dec_qpsk(1:N),size(in,1),size(in,2),size(in,3));
im_16psk=reshape(dec_16psk(1:N),730,729,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 16-QAM RECEIVER STRUCTURE
% Discrete Fourier Transform
k_16qam = fft(tx_16qam);
l_16qam = demodulate(g_16qam,k_16qam);
output_16qam = uint8(l_16qam);
output_16qam = output_16qam(1:len);
% Sampling back to 8-bit symbols
b2 = reshape(output_16qam,8,N)';
% Binary-to-decimal conversion from the symbols
dec_16qam = bi2de(b2,'left-msb');
% Bit error rate calculation for 16-QAM
BER_16qam = biterr(input,l_16qam)/len
% Reconstructed image for 16-QAM, 729x730x3
im_16qam = reshape(dec_16qam(1:N),730,729,3);

%% 64-QAM RECEIVER STRUCTURE
% Discrete Fourier Transform
k_64qam = fft(tx_64qam);
l_64qam = demodulate(g_64qam,k_64qam);
output_64qam = uint8(l_64qam);
output_64qam = output_64qam(1:len);
% Sampling back to 8-bit symbols  
b3 = reshape(output_64qam,8,N)';
% Binary-to-decimal conversion from the symbols
dec_64qam = bi2de(b3,'left-msb');
% Bit error rate calculation for 64-QAM
BER_64qam = biterr(input,l_64qam)/len
% Reconstructed image for 64-QAM, 729x730x3
im_64qam = reshape(dec_64qam(1:N),730,729,3);

%% Plot the demodulated and reconstructed images side-by-side
figure(1);
subplot(141);
imshow(im_qpsk);
title('QPSK');

subplot(142);
imshow(im_qpsk);
title('16-PSK');

subplot(143);
imshow(im_16qam);
title('16-QAM');

subplot(144);
imshow(im_64qam);
title('64-QAM');
