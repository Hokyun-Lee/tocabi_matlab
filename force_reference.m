clear all
close all
clc

d= load('walking_motion.txt');

start_pose = [0.0, 0.0, -0.24, 0.6, -0.36, 0.0, ...
            0.0, 0.0, -0.24, 0.6, -0.36, 0.0, ...
            0.0, 0.0, 0.0, ...
            0.3, 0.3, 1.5, -1.27, -1.0, 0.0, -1.0, 0.0, ...
            0.0, 0.0, ...
            -0.3, -0.3, -1.5, 1.27, 1.0, 0.0, 1.0, 0.0];

cycle_start_idx = 31112;
cycle_end_idx = 34712;

data = zeros(cycle_end_idx-cycle_start_idx, 1 + size(start_pose,2) + 2 + 1);

data(1:cycle_end_idx-cycle_start_idx, 1) = (0:cycle_end_idx-cycle_start_idx-1)/2000.0;
data(1:cycle_end_idx-cycle_start_idx, 2:13) = d(cycle_start_idx:cycle_end_idx-1, 1:12);
data(1:cycle_end_idx-cycle_start_idx, 14:34) = repmat(start_pose(13:33), cycle_end_idx-cycle_start_idx , 1);

%% Force Reference
f_z_max = -1025;

%DSP (left decrease, right increase)
for i=3300:3600
    data(i,35) = cubic(i-3300,g 0, 600, f_z_max, 0.0,  0, 0); %f_z_max + (i-3300)/600 * abs(f_z_max);
    data(i,36) = cubic(i-3300, 0, 600, 0.0, f_z_max, 0, 0);%-(i-3300)/600 * abs(f_z_max);
end
for i=1:300
    data(i,35) = cubic(i+300, 0, 600, f_z_max, 0.0,  0, 0); %f_z_max + (i-3300)/600 * abs(f_z_max);
    data(i,36) = cubic(i+300, 0, 600, 0.0, f_z_max, 0, 0);%-(i-3300)/600 * abs(f_z_max);
end
%Right
for i=300:1500
    data(i,35) = 0.0;
    data(i,36) = f_z_max;
end
% DSP (left increase, right decrease)
for i=1500:2100
    data(i,35) = cubic(i-1500, 0, 600, 0.0, f_z_max, 0, 0);%-(i-1500)/600 * abs(f_z_max);
    data(i,36) = cubic(i-1500, 0, 600, f_z_max, 0.0, 0, 0);%f_z_max + (i-1500)/600 *abs(f_z_max);
end
% Left
for i=2100:3300
    data(i,35) = f_z_max;
    data(i,36) = 0.0;
end
