function [A,B,NoO] = Identification(Bw3D,p)
[wmin,wmax,hmin,hmax,dmin,dmax,amin,amax]=ParamUtil(p{1});

for i=1:size(p,2)
    [wmin,wmax,hmin,hmax,dmin,dmax,amin,amax]=ParamUtil(p{i});
    param(i,:)=[wmin,wmax,hmin,hmax,dmin,dmax,amin,amax];
end
CC = bwconncomp(Bw3D, 6);
    display(CC);
    
    if (CC.NumObjects <1) 
        A = zeros(size(Bw3D));
        NoO=0;
        return
    end

s = regionprops(CC);
bbx = cat(1, s.BoundingBox);
de=[bbx(:,6)];
width = [bbx(:,4)];
height=[bbx(:,5)];
TD =array2table(de,'VariableNames',{'depth'});
TW =array2table(width,'VariableNames',{'width'});
TH =array2table(height,'VariableNames',{'height'});

t = struct2table(s);
t = [t TD TW TH];
s = table2struct(t);

% jn= find(([s.width]>=300) | ([s.height]>=450));
% jn= find( ([s.depth]>3) & ([s.Area]>1000));
if size(p,2)==1
    jn= find( ([s.depth]>dmin)& ([s.depth]<dmax)& ([s.width]>=wmin)& ([s.width]<wmax)& ([s.height]>=hmin)& ([s.height]<hmax)& ([s.Area]>=amin)& ([s.Area]<amax));
else
    jn= find( ([s.depth]>param(1,1))& ([s.depth]<param(1,2))& ([s.width]>=param(1,3))& ([s.width]<param(1,4))& ([s.height]>=param(1,5))& ([s.height]<param(1,6))& ([s.Area]>=param(1,7))& ([s.Area]<param(1,8)));
    fn= find( ([s.depth]>param(1,1))& ([s.depth]<param(2,2))& ([s.width]>=param(2,3))& ([s.width]<param(2,4))& ([s.height]>=param(2,5))& ([s.height]<param(2,6))& ([s.Area]>=param(2,7))& ([s.Area]<param(2,8)));
end
    
% jn= find( ([s.depth]>5)& ([s.depth]<70)& ([s.width]>=50)& ([s.width]<500)& ([s.height]>=50)& ([s.height]<40)  );

t1 = struct2table(s(jn));
[e, answ] = size(jn);
display([e, answ]);
if (answ>0)
    A =imcomplement((ismember(labelmatrix(CC), jn)));
    B = imcomplement((ismember(labelmatrix(CC), fn)));
    NoO = answ;
else
    A = zeros(size(Bw3D));
    B = zeros(size(Bw3D));
    NoO = 0;
end
end

