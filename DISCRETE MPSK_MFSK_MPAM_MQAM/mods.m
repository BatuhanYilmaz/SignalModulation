%% Preparing the signal representation
    bitStream = [1 0 1 1 1 1 0 0];

    fc = 3;             % Hz
    fs = 100;

    t = 0:1/fs:1;
    time = [];          % for plotting purposes
    digitalSignal = [];

    for idx=1:1:length(bitStream)
        digitalFunc = (bitStream(idx)==0)*zeros(1,length(t)) +...
            (bitStream(idx)==1)*ones(1,length(t));
        digitalSignal = [digitalSignal digitalFunc];

        time = [time t];
        t=t+1;

    end   

%% a) BPSK
    M=2;
    [mpskSignal mpskSyms_const mpskSyms] = myMPSK(bitStream, digitalSignal, t, time, M, fc);

    figure(1)
    % Digital signal on time domain
    subplot(2,1,1);
    plot(time,digitalSignal,'lineWidth',2.5);grid on;
    axis([ 0 (1/fs)*length(digitalSignal) -.5 1.5]);
    ylabel('Amplitude');
    xlabel(' Time(sec)');
    title('Digital input signal');
    
    % Modulated signal
    subplot(2,1,2);
    plot(time,mpskSignal,'LineWidth',2);
    xlabel('Time');
    ylabel('Amplitude');
    title('Modulated BPSK signal');
    axis([0 time(end) -1.5 1.5]);
    grid  on;

    % Signals on constellation plane
    figure(2)
    subplot(1,2,1);
    scatter(real(mpskSyms_const), imag(mpskSyms_const))
    axis([-1.5 1.5 -1.5 1.5]);
    title('All possible constellations for BPSK');
    grid on;

    subplot(1,2,2);
    scatter(real(mpskSyms), imag(mpskSyms))
    title('Available constellations for BPSK');
    axis([-1.5 1.5 -1.5 1.5]);
    grid on;    
%% b) QPSK
    M=4;
    [mpskSignal mpskSyms_const mpskSyms] = myMPSK(bitStream, digitalSignal, t, time, M, fc);
    
    figure(3)
    % Digital signal on time domain
    subplot(2,1,1);
    plot(time,digitalSignal,'lineWidth',2.5);grid on;
    axis([ 0 (1/fs)*length(digitalSignal) -.5 1.5]);
    ylabel('Amplitude');
    xlabel(' Time(sec)');
    title('Digital input signal');
    
    subplot(2,1,2);
    % Modulated signal
    plot(time,mpskSignal,'LineWidth',2);
    xlabel('Time');
    ylabel('Amplitude');
    title('Modulated QPSK signal');
    axis([0 time(end) -1.5 1.5]);
    grid  on;

    % Signals on constellation plane
    figure(4)
    subplot(1,2,1);
    scatter(real(mpskSyms_const), imag(mpskSyms_const))
    axis([-1.5 1.5 -1.5 1.5]);
    title('All possible constellations for QPSK');
    grid on;

    subplot(1,2,2);
    scatter(real(mpskSyms), imag(mpskSyms))
    axis([-1.5 1.5 -1.5 1.5]);
    title('Available constellations for QPSK');
    grid on;    
    


%% c) 4-PAM

    M=4;
    [mpamSignal mpamSyms_const mpamSyms] = myMPAM(bitStream, digitalSignal, t, time, M, fc);

    figure(5)
    % Digital signal on time domain
    subplot(2,1,1);
    plot(time,digitalSignal,'lineWidth',2.5);grid on;
    axis([ 0 (1/fs)*length(digitalSignal) -.5 1.5]);
    ylabel('Amplitude');
    xlabel(' Time(sec)');
    title('Digital input signal');
    
    subplot(2,1,2);
    % Modulated signal
    plot(time,mpamSignal,'LineWidth',2);
    xlabel('Time');
    ylabel('Amplitude');
    title('Modulated 4-PAM signal');
    axis([0 time(end) -5 5]);
    grid  on;

    % Signals on constellation plane
    figure(6)
    subplot(1,2,1);
    
    scatter(real(mpamSyms_const), imag(mpamSyms_const))
    axis([-M M -M M]);
    title('All constellations for 4-PAM');
    grid on;

    subplot(1,2,2);
    scatter(real(mpamSyms), imag(mpamSyms))
    axis([-M M -M M]);
    title('Available constellations for 4-PAM');
    grid on;    

%% d) 16-QAM
    M = 16;
    M1 = 4;
    M2 = M1;
    [mqamSignal mqamSyms_const mqamSyms] = myMQAM(bitStream, digitalSignal, t, time, M, M1, M2, fc);

    figure(7)
    % Digital signal on time domain
    subplot(2,1,1);
    plot(time,digitalSignal,'lineWidth',2.5);grid on;
    axis([ 0 (1/fs)*length(digitalSignal) -.5 1.5]);
    ylabel('Amplitude');
    xlabel(' Time(sec)');
    title('Digital input signal');
    
    subplot(2,1,2);
    % Modulated signal
    plot(time,mqamSignal,'LineWidth',2);
    xlabel('Time');
    ylabel('Amplitude');
    title('Modulated 16-QAM signal');
    axis([0 time(end) -5 5]);
    grid  on;

    % Signals on constellation plane
    figure(8)
    subplot(1,2,1);
    
    scatter(real(mqamSyms_const), imag(mqamSyms_const))
    axis([-M/2 M/2 -M/2 M/2]);
    title('All constellations for 16-QAM');
    grid on;

    subplot(1,2,2);
    scatter(real(mqamSyms), imag(mqamSyms))
    axis([-M/2 M/2 -M/2 M/2]);
    title('Available constellations for 16-QAM');
    grid on;    

%% e) Binary FSK
    M = 2;
    [mfskSignal mfskSyms_const mfskSyms] = myMFSK(bitStream, digitalSignal, t, time, M, fc)

    figure(9)
    % Digital signal on time domain
    subplot(2,1,1);
    plot(time,digitalSignal,'lineWidth',2.5);grid on;
    axis([ 0 (1/fs)*length(digitalSignal) -.5 1.5]);
    ylabel('Amplitude');
    xlabel(' Time(sec)');
    title('Digital input signal');
    
    subplot(2,1,2);
    % Modulated signal
    plot(time,mfskSignal,'LineWidth',2);
    xlabel('Time');
    ylabel('Amplitude');
    title('Modulated BFSK signal');
    axis([0 time(end) -5 5]);
    grid  on;

    % Signals on constellation plane
    figure(10)
    subplot(1,2,1);
    
    scatter(real(mfskSyms_const), imag(mfskSyms_const))
    axis([-M M -M M]);
    title('All constellations for BFSK');
    grid on;

    subplot(1,2,2);
    scatter(real(mfskSyms), imag(mfskSyms))
    axis([-M M -M M]);
    title('Available constellations for BFSK');
    grid on;    


