function[T_t,T_elapsed] = calc_timematrix(C,endtime,delay_time,starttime,basic_data)
T_d=basic_data(1); %machine takes dwell time, tD(in seconds) , to define the intensity of image at each pixel location
T_r=basic_data(2); %time required to scan an entire row(in seconds)
T_f=basic_data(3);%time required to scan a entire frame(s)
[k,l] = meshgrid(1:size(C,2),1:size(C,1));
% Every pixel is scanned at a unique time and we can associate every pixel
% location (x,y) with time at which it is scanned given as;
T(:,:)= k*T_d + l*T_r ;
for ii = 1:size(C,3) 
    xlsfname = 'calibration_data.xlsx';
[num,~,~] = xlsread(xlsfname);
starttime(ii)=num(ii,5);
endtime(ii)=num(ii,6);
delay_time(ii)= num(ii,7);
end
for  N = 1:size(C,3)
     T_t(:,:,N) = starttime(N) + T(:,:);
end
t1 = T_t(:,:,1:2:size(C,3));
t2 = T_t(:,:,2:2:size(C,3));
T_elapsed = (t1+t2)/2;
upto_time = 0:T_t(:,:,N);
end