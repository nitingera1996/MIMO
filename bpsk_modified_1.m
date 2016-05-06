clear
N = 10^6; % number of bits or symbols
rand('seed',1); % initializing the rand() function so that random bits produced are same in every simulation
% Transmitter
ip = rand(1,N)>0.5; % generating 0,1 with equal probability

% BPSK modulation
s = 2*ip-1;  % 0 -> -1; 1 -> 1 

SNR = -3:10 ; % in dB

nErr=zeros(length(SNR),1); %initializing error with 0.

for ii = 1:length(SNR)
    
   %Addition Of Noise 
   y = awgn(s,SNR(ii));
   
   % receiver - hard decision decoding
   sr = real(y)>0;

   % counting the errors
   nErr(ii) = size(find(ip - sr),2);

end

simBer = nErr/N; % simulated ber

% plot
close all
figure
semilogy(SNR,simBer,'b.-');
axis([-3 10 10^-4 0.5])
grid on
legend( 'simulation');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation');


