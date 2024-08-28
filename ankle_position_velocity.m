clear all
close all
clc
load processed_data_tocabi_walk.mat

dt = 1/2000;
dq5 = zeros(3600,1);
for i = 1:3600
    if i==1
        dq5(i) = (matsave(5,i+1) - matsave(5, i))/(2*dt);
    elseif i==3600
        dq5(i) = (matsave(5,i) - matsave(5, i-1))/(2*dt);
    else
        dq5(i) = (matsave(5,i+1) - matsave(5, i-1))/(2*dt);
    end
end

dq11 = zeros(3600,1);
for i = 1:3600
    if i==1
        dq11(i) = (matsave(11,i+1) - matsave(11, i))/(2*dt);
    elseif i==3600
        dq11(i) = (matsave(11,i) - matsave(11, i-1))/(2*dt);
    else
        dq11(i) = (matsave(11,i+1) - matsave(11, i-1))/(2*dt);
    end
end

fc = 10;
fs = 1/dt;
[b, a] = butter(4, fc/(fs/2), 'low');
dq5_filtered = filtfilt(b, a, dq5);
dq11_filtered = filtfilt(b, a, dq11);

plot(matsave(5,:), dq5_filtered)
hold on
plot(matsave(11,:), dq11_filtered)