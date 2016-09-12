clear, clc;

%Ê¹ÓÃË«»º³åbuffer£¬[N N]
global bufferSize; %N
global lindex;
global hindex;
global windex;
global buffer;
global count;
global qiancaiyang;

count = 0;
qiancaiyang = 0;
windex = 1;
bufferSize = 128;
lindex = 1;
hindex = lindex+bufferSize-1;
buffer = zeros(3,bufferSize*2);

try
    scom = serial('/dev/cu.usbmodem1451');
catch
    error('can not serial');
end
scom.BytesAvailableFcnMode = 'terminator';
scom.Terminator = 10;
scom.BytesAvailableFcn = @scomHandler; %{@scomHandler, h};
set(scom, 'BaudRate', 115200, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none');

fopen(scom);
pause;
fclose(scom);
delete(scom);
clear scom;
close all;