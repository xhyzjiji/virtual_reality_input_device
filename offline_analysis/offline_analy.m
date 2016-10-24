clc, clear;

fh = fopen('/Users/pan/project2016_1/vr_input_device/offline_analysis/offline_data/data1.txt', 'r');
fs = 50;

cur_e = [0 0 0];
cur_a = [0 0 1];
update_flag = 0;
core = [0 0 0];
base = [1 0 0;
        0 1 0;
        0 0 1];
v0 = [0 0 0];
qiancaiyang = 1;

all_e = [];
all_a = [];
while ~feof(fh)
    lineString = fgetl(fh);
    if strcmp(lineString(1:2), 'e3') == 1
        cur_e = sscanf(lineString, 'e3 %f,%f,%f');
        all_e = [all_e; cur_e.'];
    elseif strcmp(lineString(1:2), 'a3') == 1
        cur_a = sscanf(lineString, 'a3 %f,%f,%f');
        all_a = [all_a; cur_a.'];
    else
        %nothing
    end
end
ax = all_a(:,1);
ay = all_a(:,2);
az = all_a(:,3);

% Ïû³ýÆ×Ïß·¨
fftax = fft(all_a(:,1));
stem(abs(fftax));
fftax = [fftax(1), zeros(1,length(fftax)-1)];
newax = ifft(fftax);
figure;
plot(1:length(fftax), fftax, 'r'); hold on;
plot(1:length(all_a(:,1)), all_a(:,1), 'g');

% ÑÓÍØax,ay,az
windowN = 128;
extend_ax = [ones(1,ceil(windowN/2))*all_a(1,1), all_a(:,1)', ones(1,floor(windowN/2))*all_a(end,1)];
extend_ay = [ones(1,ceil(windowN/2))*all_a(1,2), all_a(:,2)', ones(1,floor(windowN/2))*all_a(end,2)];
extend_az = [ones(1,ceil(windowN/2))*all_a(1,3), all_a(:,3)', ones(1,floor(windowN/2))*all_a(end,3)];

median_ax = zeros(1,length(all_a(:,1)));
median_ay = zeros(1,length(all_a(:,2)));
median_az = zeros(1,length(all_a(:,3)));
for i=1:length(median_ax)
    median_ax(i) = median(extend_ax(i:i+windowN));
    median_ay(i) = median(extend_ay(i:i+windowN));
    median_az(i) = median(extend_az(i:i+windowN));
end

figure;
plot(1:length(median_ax), median_ax, 'g'); hold on
plot(1:length(median_ax), all_a(:,1)'-median_ax); hold off
figure;
plot(1:length(median_ay), median_ay, 'g'); hold on
plot(1:length(median_ay), all_a(:,2)'-median_ay); hold off
figure;
plot(1:length(median_az), median_az, 'g'); hold on
plot(1:length(median_az), all_a(:,3)'-median_az); hold off

extend_ex = [ones(1,ceil(windowN/2))*all_e(1,1), all_e(:,1)', ones(1,floor(windowN/2))*all_e(end,1)];
extend_ey = [ones(1,ceil(windowN/2))*all_e(1,2), all_e(:,2)', ones(1,floor(windowN/2))*all_e(end,2)];
extend_ez = [ones(1,ceil(windowN/2))*all_e(1,3), all_e(:,3)', ones(1,floor(windowN/2))*all_e(end,3)];
median_ex = zeros(1,length(all_e(:,1)));
median_ey = zeros(1,length(all_e(:,2)));
median_ez = zeros(1,length(all_e(:,3)));
for i=1:length(median_ex)
    median_ex(i) = median(extend_ex(i:i+windowN));
    median_ey(i) = median(extend_ey(i:i+windowN));
    median_ez(i) = median(extend_ez(i:i+windowN));
end

figure;
plot(1:length(median_ex), median_ex, 'g'); hold on
plot(1:length(median_ex), all_e(:,1)'-median_ex); hold off
figure;
plot(1:length(median_ey), median_ey, 'g'); hold on
plot(1:length(median_ey), all_e(:,2)'-median_ey); hold off
figure;
plot(1:length(median_ez), median_ez, 'g'); hold on
plot(1:length(median_ez), all_e(:,3)'-median_ez); hold off

max = mean(median_ax)
may = mean(median_ay)
maz = mean(median_az)
mex = mean(median_ex)
mey = mean(median_ey)
mez = mean(median_ez)

% max=mean(afterMedian_ax)
% var(afterMedian_ax)
% may=mean(afterMedian_ay)
% var(afterMedian_ay)
% maz=mean(afterMedian_az)
% var(afterMedian_az)
% max^2+may^2+maz^2
% 
% oax = mean(all_a(:,1))
% var(all_a(:,1))
% oay = mean(all_a(:,2))
% var(all_a(:,2))
% oaz = mean(all_a(:,3))
% var(all_a(:,3))
% oax^2+oay^2+oaz^2
% 
% %--------------------
% symNum = 4;
% NperSym = 16;
% guassFilter = gaussdesign(0.5, symNum, NperSym);
% afterFilter_ax = conv(all_a(:,1), guassFilter, 'valid');
% afterFilter_ay = conv(all_a(:,2), guassFilter, 'valid');
% afterFilter_az = conv(all_a(:,3), guassFilter, 'valid');
% startPoint = ceil(length(guassFilter)/2);
% validLength = length(afterFilter_ax);
% 
% figure;
% plot(1:validLength, all_a(startPoint:startPoint+validLength-1,1), 'r'); hold on
% plot(1:validLength, afterFilter_ax, 'g'); hold off
% figure;
% plot(1:validLength, all_a(startPoint:startPoint+validLength-1,2), 'r'); hold on
% plot(1:validLength, afterFilter_ay, 'g'); hold off
% figure;
% plot(1:validLength, all_a(startPoint:startPoint+validLength-1,3), 'r'); hold on
% plot(1:validLength, afterFilter_az, 'g'); hold off
% 
% gax = mean(afterFilter_ax)
% var(afterFilter_ay)
% gay = mean(afterFilter_ay)
% var(afterFilter_ay)
% gaz =mean(afterFilter_az)
% var(afterFilter_az)
% gax^2+gay^2+gaz^2

fclose(fh);
