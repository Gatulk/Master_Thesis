function [driftx,drifty] = drift_integrate_main(pixelx,pixely,upto_time,T_elapsed,Vx,Vy)
% this function fits a spline and integrates the drift velocity vector till
% time upto_time

% extract velocity data for pixelx,pixely
velox(:) =Vx(pixelx,pixely,:);
veloy(:)=Vy(pixelx,pixely,:);
timedata(:)=T_elapsed(pixelx,pixely,:);
% fit splines through the velocity data
dt=(max(timedata) - min(timedata))/(100*length(timedata)); %densify timedata 100 times
tt=min(timedata):dt:max(timedata);
vvx=spline(timedata,velox,tt);
vvy=spline(timedata,veloy,tt);

% integrate velocity data till upto_time
if upto_time >= min(timedata) && upto_time <= max(timedata)
ii=find(tt<=upto_time);
t_integrate=tt(ii);
vx_integrate=vvx(ii);
vy_integrate=vvy(ii);
driftx=trapz(t_integrate,vx_integrate);
drifty=trapz(t_integrate,vy_integrate);
% figure;
% plot(t_integrate,vx_integrate,t_integrate,vy_integrate)
else
    disp('ERROR: Time for integration is outside range')
end    

end

      
   
