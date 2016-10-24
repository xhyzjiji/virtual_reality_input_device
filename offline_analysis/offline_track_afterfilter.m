clc, clear;
%加入滤波
fh = fopen('/Users/pan/project2016_1/vr_input_device/offline_analysis/offline_data/data4.txt', 'r');

%提取所有的a和e
a = []; e = [];
while ~feof(fh)
    lineString = fgetl(fh);
    if strcmp(lineString(1:2), 'e3') == 1
        tempe = sscanf(lineString, 'e3 %f,%f,%f');
        e = [e; tempe'];
    elseif strcmp(lineString(1:2), 'a3') == 1
        tempa = sscanf(lineString, 'a3 %f,%f,%f');
        a = [a; tempa'];
    end
end
fclose(fh);

%消除谱线法
% figure;
% plot(1:length(a(:,3)), a(:,3), 'r');
% azfft(

%对a e采用中值滤波
[ma, na] = size(a);
[me, ne] = size(e);
m = min(ma, me);
a = a(1:m, :);
e = e(1:m, :);

window_width = 16;
ax = a(:,1); ay = a(:,2); az = a(:,3);
ex = e(:,1); ey = e(:,2); ez = e(:,3);

extend_ax = [ones(1, ceil(window_width/2)) * ax(1), ax', ones(1, floor(window_width/2)) * ax(end)];
extend_ay = [ones(1, ceil(window_width/2)) * ay(1), ay', ones(1, floor(window_width/2)) * ay(end)];
extend_az = [ones(1, ceil(window_width/2)) * az(1), az', ones(1, floor(window_width/2)) * az(end)];

extend_ex = [ones(1, ceil(window_width/2)) * ex(1), ex', ones(1, floor(window_width/2)) * ex(end)];
extend_ey = [ones(1, ceil(window_width/2)) * ey(1), ey', ones(1, floor(window_width/2)) * ey(end)];
extend_ez = [ones(1, ceil(window_width/2)) * ez(1), ez', ones(1, floor(window_width/2)) * ez(end)];

filtered_a = zeros(m, 3);
filtered_e = zeros(m, 3);
for i = 1:m
    filtered_a(i, 1) = median(extend_ax(i:i+window_width-1));
    filtered_a(i, 2) = median(extend_ay(i:i+window_width-1));
    filtered_a(i, 3) = median(extend_az(i:i+window_width-1));
    
    filtered_e(i, 1) = median(extend_ex(i:i+window_width-1));
    filtered_e(i, 2) = median(extend_ey(i:i+window_width-1));
    filtered_e(i, 3) = median(extend_ez(i:i+window_width-1));
end
clear extend_ex extend_ey extend_ez ax ex;

% 绘制轨迹
fs = 50;
core = [0 0 0];
v0 = [0 0 0];
base = [1 0 0;
        0 1 0;
        0 0 1];
figure(1);
real_a_stat = zeros(m, 3);
delta_a_stat = zeros(m, 3);
core_base_stat = zeros(m, 3);
for i = 1:m
    c = rotate_euler(filtered_e(i, 3), filtered_e(i, 2), filtered_e(i, 1));
    real_a = c.' * filtered_a(i, :)';
    real_a_stat(i, :) = real_a';
    delta_a = [0 0 1] - real_a'; %real_a' - [0 0 1];
    delta_a_stat(i, :) = delta_a;
    
    if (delta_a(1)^2 + delta_a(2)^2 + delta_a(3)^2) > 1.5
        continue;
    end
    
    delta_a = 9.8 * delta_a;
    s = delta_a/fs/fs/2; %v0/fs + delta_a/fs/fs/2;
    v0 = v0 + delta_a/fs;
    core = core + s; %* [1 0 0;0 0 0;0 0 1];
    cur_base = c * base;
    core_base_stat(i, :) = core;
    
%     if mod(i-1, 10) == 0
%         quiver3(core(1), core(2), core(3), cur_base(1,1), cur_base(1,2), cur_base(1,3), 'r'); hold on;
%         quiver3(core(1), core(2), core(3), cur_base(2,1), cur_base(2,2), cur_base(2,3), 'g'); 
%         quiver3(core(1), core(2), core(3), cur_base(3,1), cur_base(3,2), cur_base(3,3), 'b');
%     end
end
hold off;
plot3(core_base_stat(:,1), core_base_stat(:,2), core_base_stat(:,3), 'r*');
view(225, 10);
grid on;
% axis equal;

K = [1.006291902916060   0.000583783819267   0.023718438574020;
  -0.009999355143130   1.005900609017980   0.023496738279013;
  -0.005224614803209  -0.007533652902568   1.014127109590108];
B = [0.023337489613808   0.023606179438821   0.010407677072304];
core2_stat = zeros(m, 3);
core = [0 0 0];
v0 = [0 0 0];
base = [1 0 0;
        0 1 0;
        0 0 1];
figure(2);
for i = 1:m
    c = rotate_euler(filtered_e(i, 3), filtered_e(i, 2), filtered_e(i, 1));
    real_a = c' * (K \ (filtered_a(i, :) - B)');
    delta_a = [0 0 1] - real_a';
    
    if (delta_a(1)^2 + delta_a(2)^2 + delta_a(3)^2) > 1.5
        continue;
    end
    
    delta_a = 9.8 * delta_a;
    s = delta_a/fs/fs/2; %v0/fs + delta_a/fs/fs/2;
    v0 = v0 + delta_a/fs;
    core = core + s;
    cur_base = c * base;
    core2_stat(i, :) = core;
    
%     if mod(i-1, 10) == 0
%         quiver3(core(1), core(2), core(3), cur_base(1,1), cur_base(1,2), cur_base(1,3), 'r'); hold on;
%         quiver3(core(1), core(2), core(3), cur_base(2,1), cur_base(2,2), cur_base(2,3), 'g'); 
%         quiver3(core(1), core(2), core(3), cur_base(3,1), cur_base(3,2), cur_base(3,3), 'b');
%     end
end
hold off;
plot3(core2_stat(:,1), core2_stat(:,2), core2_stat(:,3), 'r*');
view(225, 10);
grid on;

figure;
plot(1:m, real_a_stat(:,1), 'r.'); hold on; 
plot(1:m, real_a_stat(:,2), 'g.'); 
plot(1:m, real_a_stat(:,3), 'b.'); hold off;

figure;
plot(1:m, delta_a_stat(:,1), 'r.'); hold on; 
plot(1:m, delta_a_stat(:,2), 'g.'); 
plot(1:m, delta_a_stat(:,3), 'b.'); hold off;

figure;
stem(delta_a_stat(:, 1).^2 + delta_a_stat(:, 2).^2 + delta_a_stat(:, 3).^2);
% figure;
% plot(1:m, filtered_a(:,1), 'r.'); hold on;
% plot(1:m, filtered_a(:,2), 'g.');
% plot(1:m, filtered_a(:,3), 'b.'); hold off;
