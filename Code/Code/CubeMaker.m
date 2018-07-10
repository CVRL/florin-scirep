function [ Mask_3D ] = CubeMaker( Addrr,sl,st,ed )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
imgType = '*.png'; % change based on image type
images  = dir([Addrr imgType]);
lm = length(images);
warning('off','all');
Mask_3D = [];
for i=st:ed
    img =  imread([Addrr images(i).name]);
%     img = bwareaopen(img,3000);
    img = imfill(img,'holes');
    Mask_3D(:,:,sl)=img;
    sl=sl+1;
    disp(i);

end
end


