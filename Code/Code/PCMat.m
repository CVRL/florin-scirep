function [ B3D ] = PCMat( A ,sl)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
[a , b, c]=size(A);
MT = [];
% tdi = zeros(a,b);
for idx=1:c
   bw = A(:,:,idx);
    bw = bwareaopen(imcomplement(bw),5,8);
    FName = strcat('E:\cell_co-reg\EM\drk2-res\r',num2str(sl,'%04d'),'.png');
%       tdi = tdi & bw;  
    imwrite(bw,FName);
%     bw = edge(bw,'Canny');
%     bw = img;
    [x, y] = find(bw==1);
        T2 = [x,y];
        [r,~] = size(T2);
        cl = zeros(r, 1);
        if r>0
            cl(:,1)=sl;
            T1 = cl;
            M = [array2table(T1),array2table(T2)];
            if idx == 1
                MT = M;
            else
%                 M = array2table(M);
                MT = [MT;M];
            end
        end
%      display([sl toc/60]);
     sl = sl+1;
end
                    [Z] = table2array(MT(:,1));
                    [X] = table2array(MT(:,2)); 
                    [Y] = table2array(MT(:,3));
                    B3D = [X Y Z];
end

