clear
N = 10^6; % number of bits or symbols
rand('seed',1); % initializing the rand() function so that random bits produced are same in every simulation
randn('seed',1);
% Transmitter
ip1 = rand(1,N/2)>0.5; % generating 0,1 with equal probability
ip2 = rand(1,N/2)>0.5;
ip=[ip1;ip2];

% BPSK modulation
m1 = 2*ip1-1;  % 0 -> -1; 1 -> 1 
m2 = 2*ip2-1;
msg=[m1;m2];

SNR = -3:10 ; % in dB

nErr=zeros(length(SNR),1); %initializing error with 0.

h1 = 1/sqrt(2)*(randn(1,1) + 1i*randn(1,1));
h2 = 1/sqrt(2)*(randn(1,1) + 1i*randn(1,1));
h=[h1,h2;-conj(h2),conj(h1)];
hin=pinv(h);

s = h * msg;

for ii = 1:length(SNR)

   %Addition Of Noise 
   y = awgn(s,SNR(ii));
   
   % receiver - zero forcing decoding
   xg = hin * y;
   sr = real(xg) > 0;

   % counting the errors
   nErr(ii) = size(find(ip - sr),1);

end

simBer = nErr/N; % simulated ber

% plot
close all
figure
semilogy(SNR,simBer,'b.-');
axis([-3 10 10^-5 0.7])
grid on
legend( 'simulation');
xlabel('SNR, dB');
ylabel('Bit Error Rate');
title('Bit error probability curve for BPSK modulation');