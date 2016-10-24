clear, clc;

%使用双缓冲buffer，[N N] 省去移位操作
global bufferSize; %N
global lindex;
global hindex;
global windex;
global buffer;
global count;
global qiancaiyang;
global guassFilter;

count = 0;
qiancaiyang = 0;
windex = 1;
bufferSize = 128;
lindex = 1;
hindex = lindex+bufferSize-1;
buffer = zeros(3,bufferSize*2);

figure(1);
h1 = plot(0,0,'r'); hold on
h2 = plot(0,0,'g');
h3 = plot(0,0,'b'); hold off
axis([0, bufferSize, -2, 2]);
grid on;
figure(2);
h21 = plot(0,0,'r'); hold on
h22 = plot(0,0,'g');
h23 = plot(0,0,'b'); hold off
axis([0, bufferSize, -2, 2]);
grid on

h = [h1 h2 h3];
h2 = [h21 h22 h23];

guassFilter = gaussdesign(0.5, 4, 16);  %高斯滤波冲击响应
try
    scom = serial('/dev/cu.usbmodem1451');
catch
    error('can not serial');
end
scom.BytesAvailableFcnMode = 'terminator';
scom.Terminator = 10;
scom.BytesAvailableFcn = {@scomHandler, h, h2}; %{@scomHandler, h};
set(scom, 'BaudRate', 115200, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none');

fopen(scom);
pause;
fclose(scom);
delete(scom);
clear scom;
close all;