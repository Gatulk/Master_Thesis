function[U,V,U2,V2] = disparity_calc(C)
 numimages=size(C,3);
 % invoke ncorr and set ROI from the first pair
 handles_ncorr=ncorr;
 handles_ncorr.set_ref(C(:,:,1)); 
 handles_ncorr.set_cur(C(:,:,2)); 
 pause;
 S = size(C(:,:,1));
 nrow = S(1);
 ncol = S(2);
 ROI = handles_ncorr.data_dic.displacements.roi_dic.mask;



%% loop over all stationary pairs of calibration images
%% get the disparity data between images 2*i-1, and 2*i
%% store dispx, dispy data in U, V respectively

 
for i= 1:numimages/2
handles_ncorr=ncorr;
handles_ncorr.set_ref(C(:,:,2*i - 1)); 
handles_ncorr.set_cur(C(:,:,2*i ));
handles_ncorr.set_roi_ref(ROI);
pause;
U(:,:,i) = handles_ncorr.data_dic.displacements.plot_u_dic;
V(:,:,i) = handles_ncorr.data_dic.displacements.plot_v_dic;

close;
disp('Computed disparity matrices successfully')
end


%% loop over all moving pairs of calibration images
%% get the disparity data between images 1, and 2*ii+1
%% store dispx, dispy data in U2, V2 respectively


 for ii= 1:numimages/2 -1
handles_ncorr=ncorr;
handles_ncorr.set_ref(C(:,:,2*ii - 2*ii +1)); 
handles_ncorr.set_cur(C(:,:,2*ii +1 ));
handles_ncorr.set_roi_ref(ROI);
pause;
U2(:,:,ii) = handles_ncorr.data_dic.displacements.plot_u_ref_formatted;
V2(:,:,ii) = handles_ncorr.data_dic.displacements.plot_v_ref_formatted;
close;
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
end
