% for row = 89:1:100
%     for col = 0:1:3
        %[y_input, fs] = audioread(['audio_file/person/person_' num2str(row) '_' num2str(col) '.wav']);
        [y_input, fs] = audioread(['../audio_file/person/person_1_0.wav']);
        [frequency_1, magnitude_1] = makeSpectrum(y_input, fs);
        subplot(5,1,1), plot(frequency_1, magnitude_1);
        
        y_normalize = y_input;
        y_normalize(y_normalize > +0.15) = +0.15; y_normalize(y_normalize < -0.15) = -0.15;
        y_normalize = (y_normalize(:) / max(abs(y_normalize(:)))) * 0.3;
        [frequency_2, magnitude_2] = makeSpectrum(y_normalize, fs);
        subplot(5,1,2), plot(frequency_2, magnitude_2);
        
        
        %audiowrite(['audio_file/person_ext/person_' num2str(row) '_' num2str(col) 'n.wav'], y_normalize, fs);
        [signal_low, ~]  = myFilter(y_input, fs, 1001, 'Blackman', 'low-pass', 4000);
        signal_low = (signal_low(:) / max(abs(signal_low(:)))) * 0.3;
        [frequency_3, magnitude_3] = makeSpectrum(signal_low, fs);
        subplot(5,1,3), plot(frequency_3, magnitude_3);
        
        %audiowrite(['audio_file/person_ext/person_' num2str(row) '_' num2str(col) 'l.wav'], signal_low, fs);
        [signal_high, ~]  = myFilter(y_input, fs, 1001, 'Blackman', 'high-pass', 500);
        signal_high = (signal_high(:) / max(abs(signal_high(:)))) * 0.3;
        [frequency_4, magnitude_4] = makeSpectrum(signal_high, fs);
        subplot(5,1,4), plot(frequency_4, magnitude_4);
        
        %audiowrite(['audio_file/person_ext/person_' num2str(row) '_' num2str(col) 'h.wav'], signal_high, fs);
        y_noise = (y_input(:) / max(abs(y_input(:)))) * 0.3;
        noise = (-1 + 2.*rand(size(y_input)))*0.005;
        y_noise = y_noise + noise;
        [frequency_5, magnitude_5] = makeSpectrum(y_noise, fs);
        subplot(5,1,5), plot(frequency_5, magnitude_5);
        %audiowrite(['audio_file/person_ext/person_' num2str(row) '_' num2str(col) 'd.wav'], y_noise, fs);
%         
%      end
%  end
% 
function [frequency, magnitude] = makeSpectrum( y_signal , fs )

% Transform to frequency domain
L1 = 2^nextpow2(max(size(y_signal)));
FFT = fft(y_signal,L1);
xx = fs/2*linspace(0,1,L1/2+1);

magnitude = abs(FFT(1:L1/2+1));
frequency = xx;

end