%% M-FSK

function [mfskSignal mfskSyms_const mfskSyms] = myMFSK(bitStream, digitalSignal, t, time, M, fc)

    g_t = rectwin(64);
    delta_f = fc/2;

    mfskSignal = [];
    mfskSyms = [];
    mfskSyms_const = [];

    bpSym = log2(M);
    numOfSyms = length(bitStream)/bpSym
    bitStream_rshp=reshape(bitStream,bpSym,length(bitStream)/bpSym)';      %Reshaping bit stream wrt. symbols
    symC = dec2bin(0:2^bpSym-1) - '0';                                     %All possible symbols, represented with bits

    for m = 1:M
        mfskSym_const = (2-m) + 1j*(m-1);
        mfskSyms_const = [mfskSyms_const mfskSym_const];

    end  
    for idx = 1:numOfSyms
        mfskFunc = zeros(length(t),1)';
        for m = 1:M

            if isequal(bitStream_rshp(idx,:),symC(m,:))
            %delta = 1;

                mfskFunc =  g_t.*cos(2*pi*(fc + (m-1-M/2)*delta_f)*t);
                mfskSym = (2-m) + 1j*(m-1);
            end
        end

        for b = 1:bpSym
            mfskSignal = [mfskSignal mfskFunc];
        end 

        mfskSyms = [mfskSyms mfskSym]


    end


end