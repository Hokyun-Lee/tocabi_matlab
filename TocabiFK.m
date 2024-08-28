clear all
close all
clc

addpath(genpath(strcat(pwd, '\tocabi_description\robots')))
tocabi = importrobot('dyros_tocabi_0714.urdf');
axes = show(tocabi);
axes.CameraPositionMode = 'auto';

% for i = 1:500
%     config = randomConfiguration(tocabi);
%     show(tocabi,config);
%     pause(0.01)
% end