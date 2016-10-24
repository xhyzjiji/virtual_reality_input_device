clear,clc;

global demoModel;
global getlTime;

demoModel = [-1,-1,1;-1,1,1;-1,1,-1;1,1,-1;1,1,1;-1,1,1;-1,1,-1;-1,-1,-1;-1,-1,1;
    1,-1,1;1,1,1;1,1,-1;1,-1,-1;1,-1,1;-1,-1,1;-1,-1,-1;1,-1,-1];
getlTime = 0;

try
    scom = serial('/dev/cu.usbmodem1451');
catch
    error('can not serial');
end

figure(1);
xobject = newobject(:,1);
yobject = newobject(:,2);
zobject = newobject(:,3);
axis equal;
h = plot3(xobject,yobject,zobject);
axis([-2, 2, -2, 2, -2, 2]);
grid on;
scom.BytesAvailableFcnMode = 'terminator';
scom.Terminator = '\n';
scom.BytesAvailableFcn = {@scomHandler, h};
set(scom, 'BaudRate', 115200, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none');
