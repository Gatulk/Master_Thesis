function [csx,csy,Vx,Vy,T_t,T_elapsed,U2,V2] = load_data()
% load files for spatial distortion calculation
% load cumulative displacements during calibration
load('csx.mat');
load('csy.mat');
% load drift velocities calculated during calibration
load('Vxcalib.mat');
load('Vycalib.mat');
load('T_t_calib.mat');
load('T_elapsed_calib.mat');
load('disparity_data_x_movingpairs.mat');
load('disparity_data_y_movingpairs.mat');
end