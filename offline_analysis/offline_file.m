clear,clc;

try
    scom = serial('/dev/cu.usbmodem1451');
    fh = fopen('/Users/pan/project2016_1/vr_input_device/offline_analysis/offline_data/flat.txt', 'w+');
catch
    error('can not serial');
end
scom.BytesAvailableFcnMode = 'terminator';
scom.Terminator = 10;
scom.BytesAvailableFcn = {@scomHandler, fh}; %@scomHandler; %{@scomHandler, h};
set(scom, 'BaudRate', 115200, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none');

fopen(scom);
pause;
fclose(scom);
fclose(fh);
delete(scom);
clear scom;
close all;