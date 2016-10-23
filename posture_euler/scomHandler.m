function scomHandler( scom, BytesAvailable )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    global demoModel;
%     global getlTime;
    global arrows;
    global corePoint;
    global qiancaiyang;
    global h;

    lineString = fgetl(scom);
    if strcmp(lineString(1:2), 'e3') == 1
        qiancaiyang = qiancaiyang + 1;
        if mod(qiancaiyang, 40) == 0
            qiancaiyang = 1;
                gro = sscanf(lineString, 'e3 %f,%f,%f');
                gro = gro.'; 
                
                newModel = rotate_euler(demoModel, gro(3), gro(2), gro(1));

                xobject = newModel(:,1);
                yobject = newModel(:,2);
                zobject = newModel(:,3);
                
%                 绘制正方体轮廓
%                 axis equal;
%                 h = plot3(xobject,yobject,zobject);

%                 set(h(1), 'xdata', xobject(1:4), 'ydata', yobject(1:4), 'zdata', zobject(1:4));
%                 set(h(2), 'xdata', xobject(5:8), 'ydata', yobject(5:8), 'zdata', zobject(5:8));
%                 set(h(3), 'xdata', xobject(9:12), 'ydata', yobject(9:12), 'zdata', zobject(9:12));
%                 set(h(4), 'xdata', xobject(13:16), 'ydata', yobject(13:16), 'zdata', zobject(13:16));
%                 set(h(5), 'xdata', xobject(17:20), 'ydata', yobject(17:20), 'zdata', zobject(17:20));

%               绘制正方体实体
                figure(1);
                clf;
                axis equal
                fill3(xobject(1:4), yobject(1:4), zobject(1:4), 'g'); hold on;
                fill3(xobject(5:8), yobject(5:8), zobject(5:8), 'r');
                fill3(xobject(9:12), yobject(9:12), zobject(9:12), 'b');
                fill3(xobject(13:16), yobject(13:16), zobject(13:16), 'y');
                fill3(xobject(17:20), yobject(17:20), zobject(17:20), 'c'); hold off;

%               绘制物体坐标系
%               quiver3(corePoint(1), corePoint(2), corePoint(3), newArrows(1,1), newArrows(1,2), newArrows(1,3), 'r'); hold on;
%               quiver3(corePoint(1), corePoint(2), corePoint(3), newArrows(2,1), newArrows(2,2), newArrows(2,3), 'g'); hold on;
%               quiver3(corePoint(1), corePoint(2), corePoint(3), newArrows(3,1), newArrows(3,2), newArrows(3,3), 'b');
                axis([-2, 2, -3, 3, -4, 4]);
                view(45, 10);
                grid on;
        else
            fgetl(scom);
        end
    end
end

