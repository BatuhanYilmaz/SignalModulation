%% M-PAM
function [mpamSignal mpamSyms_const mpamSyms] =...
    myMPAM(bitStream, digitalSignal, t, time, M, fc)
    g_t = rectwin(64);
    delta = 1;

    mpamSignal = [];
    mpamSyms = [];
    mpamSyms_const = [];

    bpSym = log2(M);
    numOfSyms = length(bitStream)/bpSym
    bitStream_rshp=reshape(bitStream,bpSym,length(bitStream)/bpSym)';      %Reshaping bit stream wrt. symbols
    symC = dec2bin(0:2^bpSym-1) - '0';                                     %All possible symbols, represented with bits

    for m = 1:M
        A_m = (2*m-1-M)*delta;
        mpamSym_const = A_m;
        mpamSyms_const = [mpamSyms_const mpamSym_const]

    end  
    for idx = 1:numOfSyms
        mpamFunc = zeros(length(t),1)';
        for m = 1:M

            if isequal(bitStream_rshp(idx,:),symC(m,:))
            %delta = 1;
                A_m = (2*m-1-M)*delta;
                mpamFunc =  A_m*g_t*sin(2*pi*fc*t);
                mpamSym = A_m;
            end
        end

        for b = 1:bpSym
            mpamSignal = [mpamSignal mpamFunc];
        end 

        mpamSyms = [mpamSyms mpamSym]


    end
end
