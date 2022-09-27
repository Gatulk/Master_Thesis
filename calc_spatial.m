function[spatialx,spatialy] = calc_spatial(pixelx,pixely,iupto)
[csx,csy,Vx,Vy,T_t,T_elapsed,U2,V2] = load_data();
A_csx = csx(iupto);
B_csy = csy(iupto);
till_time = T_elapsed(pixelx,pixely,iupto);

[driftx,drifty] = drift_integrate_main(pixelx,pixely,till_time,T_elapsed, Vx,Vy);

% =======================================================================================
% computing the Spatial distortion in both X and Y direction i.e. spatialx
% & spatialy at pixelx, pixely upto upto_time
%========================================================================================

[spatialx,spatialy] = spatial_distortion(pixelx,pixely,iupto,U2,V2,A_csx,B_csy,driftx,drifty); 


