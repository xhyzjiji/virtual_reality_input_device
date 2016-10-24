clc, clear;

fh = fopen('/Users/pan/project2016_1/vr_input_device/offline_analysis/static_object.txt', 'r');
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

K = [1.430855096346337  -0.703267764555780  -5.233018113069133;
   0.722939250204101  -0.320797378752847   0.791211921170467;
  -0.027733123054059   0.005141506285074   1.193232863789603];
B = [5.393922370381349;  -0.579233097004316;  -0.011627193257180];

figure(1);
while ~feof(fh)
    lineString = fgetl(fh);
    if strcmp(lineString(1:2), 'e0') == 1
        cur_e = sscanf(lineString, 'e0 %f,%f,%f');
    elseif strcmp(lineString(1:2), 'a0') == 1
        temp = sscanf(lineString, 'a0 %f,%f,%f');
        cur_a = K \ (temp - B);

%         cur_a = sscanf(lineString, 'a0 %f,%f,%f');
    else
        %nothing
        update_flag = 1;
    end
    
    %calculate shifting and plot on the figure
    if update_flag == 1
        c = rotate_euler(cur_e(3), cur_e(1), cur_e(2));
        real_a = c*cur_a;
        delta_a = real_a' - [0 0 1];
        s = v0/fs + delta_a/fs/fs/2;
        v0 = v0+delta_a/fs;
        core = core + s;
        cur_base = c*base;
        
        if mod(qiancaiyang, 10)==0
            quiver3(core(1), core(2), core(3), cur_base(1,1), cur_base(1,2), cur_base(1,3), 'r'); hold on;
            quiver3(core(1), core(2), core(3), cur_base(2,1), cur_base(2,2), cur_base(2,3), 'g'); 
            quiver3(core(1), core(2), core(3), cur_base(3,1), cur_base(3,2), cur_base(3,3), 'b');
        end
        qiancaiyang = qiancaiyang + 1;
    end
    update_flag = 0;
%     pause(1/fs);
end