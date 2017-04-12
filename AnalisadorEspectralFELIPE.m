% ANALISADOR ESPECTRAL - FELIPE

recObj = audiorecorder; % gravando por delfault (8000Hz, 8 Bits, 1 Canal)
disp('Começa a Gravar.')
recordblocking(recObj, 5); % Grava a voz por 5s
disp('Fim da Gravação');

% Toca o audio
play(recObj);

% Armazena o audio, em um vetor de dupla precisão.
vetor = getaudiodata(recObj);



tamVetor = length(vetor); % tamanho do vetor(8000Hz por 5s)
t = 0:1:length(vetor)-1; %indices da amostragem -> Pega de 0 ao tamanho do vetor-1, espaçamento das amostras no dominio da frequencia

subplot(1,2,1); 
stem(t, vetor, '.');

f = fft(vetor)/tamVetor; %faz a transformada de fourier

amplitude(1) = abs(f(1));   % primeiro espectro
upper = tamVetor/2; %calcula os intervalos
amplitude(2:upper) = 2*abs(f(2:upper)); %calcula a amplitude do segundo até o penultimo
amplitude(upper+1) = abs(f(upper+1)); %amplitude para o ultimo

subplot(1,2,2); 
stem(t, f, '.');

frequencias = [0:8000/tamVetor:8000/2];

%subplot(1,3,3);

% Plot the waveform.
plot(frequencias, amplitude);
xlabel('Tempo (s)');
ylabel('Amplitude (V)');

