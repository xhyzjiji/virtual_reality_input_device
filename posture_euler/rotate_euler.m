function [new_model] = rotate_euler(old_model, yaw, pitch, roll)
% new_model:新模型锚点，old_model:旧模型锚点，yaw:物体坐标系竖轴(偏航角)，pitch:物体坐标系横轴(仰角)，roll:物体坐标系纵轴(倾斜角)，角度都是从轴正方向看下去

yaw2theta   = yaw/180*pi;
pitch2theta = pitch/180*pi;
roll2theta  = -roll/180*pi;

Carray = [cos(roll2theta)*cos(yaw2theta)+sin(roll2theta)*sin(pitch2theta)*sin(yaw2theta), -cos(roll2theta)*sin(yaw2theta)+sin(roll2theta)*sin(pitch2theta)*cos(yaw2theta), -sin(roll2theta)*cos(pitch2theta);
          cos(pitch2theta)*sin(yaw2theta), cos(pitch2theta)*cos(yaw2theta), sin(pitch2theta);
          sin(roll2theta)*cos(yaw2theta)-cos(roll2theta)*sin(pitch2theta)*sin(yaw2theta), -sin(roll2theta)*sin(yaw2theta)-cos(roll2theta)*sin(pitch2theta)*cos(yaw2theta), cos(roll2theta)*cos(pitch2theta)];
new_model = Carray * old_model.';
new_model = new_model.';