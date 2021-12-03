%% M-QAM
function [mqamSignal mqamSyms_const mqamSyms] =...
    myMQAM(bitStream, digitalSignal, t, time, M, M1, M2, fc)

    g_t = rectwin(646);
    delta = 1;

    mqamSignal = [];
    mqamSyms = [];
    mqamSyms_const = [];

    bpSym = log2(M);
    numOfSyms = length(bitStream)/bpSym;
    bitStream_rshp=reshape(bitStream,bpSym,length(bitStream)/bpSym)';      %Reshaping bit stream wrt. symbols
    symC = dec2bin(0:2^bpSym-1) - '0';                                     %All possible symbols, represented with bits

    for ix = 1:M1         
        for qx = 1:M2
            A_m_i = ((2*ix)-1-M1)*delta;
            mqamSym_const = A_m_i;
            A_m_q = ((2*qx)-1-M2)*delta;
            mqamSym_const = mqamSym_const + 1j*A_m_q;
            mqamSyms_const = [mqamSyms_const mqamSym_const];
        end
    end
        
      
    for idx = 1:numOfSyms

        mqamFunc = zeros(length(t),1)';
        mqamSym = [];
        for ix = 1:M1         
            for qx = 1:M2
                if isequal(bitStream_rshp(idx,:),symC(ix*qx,:))
                    A_m_i = ((2*ix)-1-M1)*delta;
                    mqamFunc =  A_m_i.*g_t.*cos(2*pi*fc*t);
                    mqamSym = A_m_i;

                    A_m_q = ((2*qx)-1-M2)*delta;
                    mqamFunc =  mqamFunc - A_m_q.*g_t.*sin(2*pi*fc*t);
                    mqamSym = mqamSym + 1j*A_m_q;
                    
                    for b = 1:bpSym
                        mqamSignal = [mqamSignal mqamFunc];
                    end

                    mqamSyms = [mqamSyms mqamSym]
                end
            end
        end

    end
end
