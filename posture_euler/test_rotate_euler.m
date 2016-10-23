clear, clc;

% 正方体轮廓模型
% model = [-1,-1,1;-1,1,1;-1,1,-1;1,1,-1;1,1,1;-1,1,1;-1,1,-1;-1,-1,-1;-1,-1,1;1,-1,1;1,1,1;1,1,-1;1,-1,-1;1,-1,1;-1,-1,1;-1,-1,-1;1,-1,-1];

% 正方体实体模型
model = [-1,-1,1;-1,1,1;-1,1,-1;-1,-1,-1;
    -1,-1,1;1,-1,1;1,-1,-1;-1,-1,-1;
    -1,1,-1;1,1,-1;1,-1,-1;-1,-1,-1;
    1,-1,-1;1,1,-1;1,1,1;1,-1,1;
    -1,-1,1;-1,1,1;1,1,1;1,-1,1];
figure(1);
while(1)
    lineString = input('input yaw,pitch,roll > ', 's');
    if strcmp(lineString, 'bye') == 1
        break;
    end
    euler = sscanf(lineString, '%f,%f,%f');
    newmodel = rotate_euler(model, euler(1), euler(2), euler(3));
%     clf;
    xobject = newmodel(:,1);
    yobject = newmodel(:,2);
    zobject = newmodel(:,3); 
    axis equal;
%     h = plot3(xobject,yobject,zobject); hold on;  绘制正方体轮廓
    fill3(xobject(1:4), yobject(1:4), zobject(1:4), 'g'); hold on;
    fill3(xobject(5:8), yobject(5:8), zobject(5:8), 'r');
    fill3(xobject(9:12), yobject(9:12), zobject(9:12), 'b');
    fill3(xobject(13:16), yobject(13:16), zobject(13:16), 'y');
    fill3(xobject(17:20), yobject(17:20), zobject(17:20), 'c'); hold off;
    view(45, 10);
    grid on;
end