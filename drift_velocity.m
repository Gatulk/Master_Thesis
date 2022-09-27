function [Vx,Vy] = drift_velocity(C,U,V,basic_data,starttime,endtime)
T_d=basic_data(1); %machine takes dwell time, tD(in seconds) , to define the intensity of image at each pixel location
T_r=basic_data(2); %time required to scan an entire row(in seconds)
T_f=basic_data(3);%time required to scan a entire frame(s)
for i= 1:size(C,3)/2 
%    dtn_s(i) = seconds(starttime(2*i) - endtime(2*i-1));
   dtn_s(i)= starttime(2*i) - endtime(2*i-1);
   tdisp(:,:,i) =   T_d .* U(:,:,i) +  T_r .* V(:,:,i) ;
   delta(:,:,i) = (T_f + dtn_s(i)) .* ones(size(C,1),size(C,2)) + tdisp(:,:,i);
   Vx(:,:,i) = U(:,:,i)./(delta(:,:,i));
   Vy(:,:,i) = V(:,:,i)./(delta(:,:,i));
end