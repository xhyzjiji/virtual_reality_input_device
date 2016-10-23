clear,clc;

global demoModel;
% global getlTime;
global corePoint;
global arrows;
global qiancaiyang;
global h;

% demoModel = [-1,-1,1;-1,1,1;-1,1,-1;1,1,-1;1,1,1;-1,1,1;-1,1,-1;-1,-1,-1;-1,-1,1;
%     1,-1,1;1,1,1;1,1,-1;1,-1,-1;1,-1,1;-1,-1,1;-1,-1,-1;1,-1,-1];
demoModel = [-1,-1,1;-1,1,1;-1,1,-1;-1,-1,-1;
    -1,-1,1;1,-1,1;1,-1,-1;-1,-1,-1;
    -1,1,-1;1,1,-1;1,-1,-1;-1,-1,-1;
    1,-1,-1;1,1,-1;1,1,1;1,-1,1;
    -1,-1,1;-1,1,1;1,1,1;1,-1,1];
% getlTime = 0;
qiancaiyang = 0;
corePoint = [0 0 0];
arrows = [1 0 0; 0 1 0; 0 0 1];

figure(1);
xobject = demoModel(:,1);
yobject = demoModel(:,2);
zobject = demoModel(:,3);
axis equal;
% 正方体轮廓
% h = plot3(xobject,yobject,zobject);

% 正方体实体
h1 = fill3(xobject(1:4), yobject(1:4), zobject(1:4), 'g'); hold on;
h2 = fill3(xobject(5:8), yobject(5:8), zobject(5:8), 'r');
h3 = fill3(xobject(9:12), yobject(9:12), zobject(9:12), 'b');
h4 = fill3(xobject(13:16), yobject(13:16), zobject(13:16), 'y');
h5 = fill3(xobject(17:20), yobject(17:20), zobject(17:20), 'c'); %hold off;
h = [h1 h2 h3 h4 h5];

% 物体坐标系
% quiver3(corePoint(1), corePoint(2), corePoint(3), arrows(1,1), arrows(1,2), arrows(1,3), 'r'); hold on;
% quiver3(corePoint(1), corePoint(2), corePoint(3), arrows(2,1), arrows(2,2), arrows(2,3), 'g'); hold on;
% quiver3(corePoint(1), corePoint(2), corePoint(3), arrows(3,1), arrows(3,2), arrows(3,3), 'b');
axis([-2, 2, -3, 3, -4, 4]);
% view3说明
% 当x轴平行于观察者，y轴垂直于观察者时，AZ为0，以此为起点，绕着z轴顺时针转动，AZ为正，逆时针转动，AZ为负；
% EL为观察者眼睛与xoy平面所形成的角度。当观察者的眼睛在xoy平面上时，EL=0; 向上EL为正，即为俯视角，向下EL为负，即为仰视角；
view(45, 10);
grid on;

% 格式 "$e -28.72278,-178.85999,-135.48309"
% 分割方法
% ceshitext = '$e -28.72278,-178.85999,-135.48309' '$e -26.57554,-85.55365,-72.55238';
% gro = sscanf(ceshitext, '$e %f,%f,%f');

try
    scom = serial('/dev/cu.usbmodem1451');
catch
    error('can not serial');
end
scom.BytesAvailableFcnMode = 'terminator';
scom.Terminator = 10;
scom.BytesAvailableFcn = @scomHandler; %@scomHandler; %{@scomHandler, h};
set(scom, 'BaudRate', 115200, 'DataBits', 8, 'StopBits', 1, 'Parity', 'none', 'FlowControl', 'none');

fopen(scom);
pause;
fclose(scom);
delete(scom);
clear scom;
close all;