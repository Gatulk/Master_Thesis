function [C] = crop_tool(n,A)
% [cropped_1, Rect ] = imcrop(A(:,:,1)) ;
% s = size(cropped_1);
% C(s(1),s(2),3)=zeros();
% A(:,:,1) = i_1;
% A(:,:,2) = i_2;
% A(:,:,3) = i_3;
% A(:,:,4) = i_4;

clear C
clear cropped_1
for i = 1:n 
    if i == 1
   [cropped_1, Rect ] = imcrop(A(:,:,1)) ;
   C(:,:,i) = cropped_1;
    else
    C(:,:,i)= imcrop(A(:,:,i),Rect);
    end
%     figure(i)
%     imshow(C(:,:,i));
end
end
