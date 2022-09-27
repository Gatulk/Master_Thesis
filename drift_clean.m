calib_or_not=0; %0: calibration stage, 1 experiment stage
% cleaned drift and spatial correction code for in-situ DIC
% ==========================================================
% Basic machine data
% ==========================================================
T_d=1e-4; %machine takes dwell time, tD(in seconds) , to define the intensity of image at each pixel location
T_r=0.0529; %time required to scan an entire row(in seconds)
T_f=40.6;%time required to scan a entire frame(s)
basic_data=[T_d T_r T_f];


% ===========================================================
% user inputs for drift velocity calculation
% ===========================================================
disp('STARTING DRIFT VELOCITY CALCULATION PHASE');
% load images and crop
%------------------------------
load_or_calc=input('Fetch stored images or load new images? (0/1):');
if load_or_calc == 1
  [C,csx,csy]=calibration_input;
  saveimages='all_images.mat';
  save(saveimages,'C');
  savecsx='csx.mat';
  save(savecsx,'csx');
  savecsy='csy.mat';
  save(savecsy,'csy');
end
if load_or_calc == 0
    load('all_images.mat');
end  
% compute disparity data through DIC
% it has to be done for stationary pairs for drift calculation and
% moving pairs for spatial distortion
%--------------------------------------------------------
load_or_calc=input('Load disparity data or compute it? (0/1):');
if load_or_calc == 1
[U,V,U2,V2] = disparity_calc(C);
savefilex1 = 'disparity_data_x_stationarypairs.mat';
savefiley1 = 'disparity_data_y_stationarypairs.mat';
save(savefilex1, 'U');
save(savefiley1, 'V');
savefilex2 = 'disparity_data_x_movingpairs.mat';
savefiley2 = 'disparity_data_y_movingpairs.mat';
save(savefilex2, 'U2');
save(savefiley2, 'V2');
end
if load_or_calc == 0
    load('disparity_data_x_stationarypairs.mat')
    load('disparity_data_y_stationarypairs.mat')
    load('disparity_data_x_movingpairs.mat')
    load('disparity_data_y_movingpairs.mat')

end  

% ===============================================================
% computing the time matrix
%=================================================================

for ii = 1:size(C,3) 
    xlsfname = 'calibration_data.xlsx';
[num,~,~] = xlsread(xlsfname);
starttime(ii)=num(ii,5);
endtime(ii)=num(ii,6);
delay_time(ii)= num(ii,7);
end
[T_t,T_elapsed] = calc_timematrix(C,endtime,delay_time,starttime,basic_data);


% =======================================================================
% computing the Drift Velocities in both X and Y direction i.e. Vx &Vy
%========================================================================


[Vx,Vy]=drift_velocity(C,U,V,basic_data,starttime,endtime);

%=========================================================================
% save all calculated data
% ========================================================================
if calib_or_not == 0
saveVx='Vxcalib.mat';
save(saveVx,'Vx');
saveVy='Vycalib.mat';
save(saveVy,'Vy');
saveT_t='T_t_calib.mat';
save(saveT_t,'T_t');
saveT_elapsed='T_elapsed_calib.mat';
save(saveT_elapsed,'T_elapsed');
end
if calib_or_not == 1
saveVx='Vx.mat';
save(saveVx,'Vx');
saveVy='Vy.mat';
save(saveVy,'Vy');
saveT_t='T_t.mat';
save(saveT_t,'T_t');
saveT_elapsed='T_elapsed.mat';
save(saveT_elapsed,'T_elapsed');
end




