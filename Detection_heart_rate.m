clc; clear;close;
load('FPT_Pariichehr_1.mat');
sig=data(1:length(data)/2);
N=length(data);
TIME = [0:N-1]/samplerate;
figure('position',[50,200,1000,300],'Name','Heart impulse');
subplot(2,1,1);
plot(TIME,data,'r');
% [b,a] = butter(4,.1); 
% [b,a] = ellip(6,5,40,0.04);
n = 61;
wo = 0.05;
dp = 0.02;	
ds = 0.008;
h = fircls1(n,wo,dp,ds);
% fvtool(h,1);
sig2=filter(h,1,data);
subplot(2,1,2);
plot(TIME,sig2,'r');

x=mean(data);
[~,locs_peak]=findpeaks(data,'MinpeakHeight',x+0.2,...
                            'MinpeakDistance',0.2*samplerate );
   for i=1:length(locs_peak)-1         
    Distance_pulse(i)=(locs_peak(i+1)-locs_peak(i))/samplerate;
    Heart_rate_online=60/Distance_pulse(i)
   end
   
   Distance_mean=mean(Distance_pulse);
   Heart_rate=60/Distance_mean;
   Heart_rate=floor((Heart_rate*100))/100

    figure('position',[50,200,1000,300],'Name','Heart impulse');
hold on;
plot(TIME,data,'r');
plot(locs_peak/samplerate,data(locs_peak),'rs','MarkerFaceColor','b')
legend(mat2str(Heart_rate),'Heart Rate Pariichehr');