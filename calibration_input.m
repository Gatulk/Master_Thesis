function[C,csx,csy] = calibration_input(xlsfname)
xlsfname = 'calibration_data.xlsx';
[num,txt,raw] = xlsread(xlsfname);
ndum=size(txt);
numimages=length(txt(2:ndum,2));
if rem(numimages,2) ~= 0
    disp('ERROR: Need even number of calibration images');
    return;
end 
numpairs=numimages/2;
%--------------------------------------------------------------------------------------
for ii = 1:numpairs
disp(['Gathering data for stationary pair ' num2str(ii)]);
if ii == 1
     xinmicrons(2*ii-1) = 0;
     yinmicrons(2*ii-1) = 0;
     xinmicrons(2*ii) = 0;
     yinmicrons(2*ii) = 0;
end   
if ii ~=1
     xinmicrons(2*ii-1) = num(2*ii-1,3) - num(1,3);
     yinmicrons(2*ii-1) = num(2*ii-1,4)- num(1,4);
     xinmicrons(2*ii) = xinmicrons(2*ii-1);
     yinmicrons(2*ii) = yinmicrons(2*ii-1);
end  
end
%    first image in pair
for ii = 1:numpairs
filename = string(txt(2*ii,2))
currentimage = imread(filename);
images{2*ii-1} = currentimage;
A(:,:,2*ii-1) = images{2*ii-1};
A(:,:,2*ii-1) = uint8(A(:,:,2*ii-1));
%second image in pair
filename = string(txt(2*ii+1,2))
currentimage = imread(filename);
% endtime = num(2:nnum,6);
images{2*ii} = currentimage;
A(:,:,2*ii) = images{2*ii};
A(:,:,2*ii) = uint8(A(:,:,2*ii));
end
%---------------------------------------------------------
disp("Define region in the image for cropping.");
C = crop_tool(numimages,A);
disp("Successfully obtained and cropped all images in the directory:");
disp("Now obtaining calibration displacements between image pairs")
for ii = 1:size(C,3)/2 - 1
Given_x(ii) = num(2*ii+1,3) - num(2*ii-1,3);
Given_y(ii) = num(2*ii+1,4) - num(2*ii-1,4);
end
csx= cumsum(Given_x);
csy= cumsum(Given_y);
disp("Finished obtaining calibration displacements between image pairs")
end