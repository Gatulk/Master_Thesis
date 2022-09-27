function [spatialx,spatialy] = spatial_distortion(pixelx,pixely,ii,U2,V2,A_csx,B_csy,driftx,drifty)
spatialx= U2(pixelx,pixely,ii)- A_csx-  driftx;
spatialy= V2(pixelx,pixely,ii)- B_csy - drifty;
end
