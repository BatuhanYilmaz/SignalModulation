%% M-PSK
function [mpskSignal mpskSyms_const mpskSyms] =...
    myMPSK(bitStream, digitalSignal, t, time,  M, fc)

    digitalSignal = [];
    
    mpskSignal = [];
    mpskSyms = [];
    mpskSyms_const = [];

    bpSym = log2(M);
    numOfSyms = length(bitStream)/bpSym
    bitStream_rshp=reshape(bitStream,bpSym,length(bitStream)/bpSym)';      %Reshaping bit stream wrt. symbols

    symC = dec2bin(0:2^bpSym-1) - '0';                                     %All possible symbols, represented with bits
    A = 1/sqrt(2);                                                         %Amplitude for fitting the signals into a unit circle

    for m = 1:M
        mpskSym_const = cos((2*pi/M)*(m-1)) - 1j*sin((2*pi/M)*(m-1));
        mpskSyms_const = [mpskSyms_const mpskSym_const]

    end   
        for idx = 1:1:(numOfSyms)
                mpskFunc = zeros(length(t),1)';
            for m = 1:M

                if isequal(bitStream_rshp(idx,:),symC(m,:))
                    mpskFunc = mpskFunc+...
                        (sin(2*pi*fc*t - (2*pi/M)*(m-1)));

                    mpskSym = cos((2*pi/M)*(m-1)) - 1j*sin((2*pi/M)*(m-1));
                end
            end  

            for b = 1:bpSym
                mpskSignal = [mpskSignal mpskFunc];
            end
            mpskSyms = [mpskSyms mpskSym]

        end
    
end