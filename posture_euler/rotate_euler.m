function [new_model] = rotate_euler(old_model, yaw, pitch, roll)
% new_model:��ģ��ê�㣬old_model:��ģ��ê�㣬yaw:��������ϵ����(ƫ����)��pitch:��������ϵ����(����)��roll:��������ϵ����(��б��)���Ƕȶ��Ǵ�����������ȥ

yaw2theta   = yaw/180*pi;
pitch2theta = pitch/180*pi;
roll2theta  = -roll/180*pi;

Carray = [cos(roll2theta)*cos(yaw2theta)+sin(roll2theta)*sin(pitch2theta)*sin(yaw2theta), -cos(roll2theta)*sin(yaw2theta)+sin(roll2theta)*sin(pitch2theta)*cos(yaw2theta), -sin(roll2theta)*cos(pitch2theta);
          cos(pitch2theta)*sin(yaw2theta), cos(pitch2theta)*cos(yaw2theta), sin(pitch2theta);
          sin(roll2theta)*cos(yaw2theta)-cos(roll2theta)*sin(pitch2theta)*sin(yaw2theta), -sin(roll2theta)*sin(yaw2theta)-cos(roll2theta)*sin(pitch2theta)*cos(yaw2theta), cos(roll2theta)*cos(pitch2theta)];
new_model = Carray * old_model.';
new_model = new_model.';