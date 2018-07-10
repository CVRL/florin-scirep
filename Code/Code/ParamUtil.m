function [wmin,wmax,hmin,hmax,dmin,dmax,amin,amax] = ParamUtil(Addr)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dat=loadjson(Addr);
if (dat.params.width(1)~='-')
    wmin = dat.params.width(1);
else
    wmin = 0;
end
if (dat.params.width(2)~='-')
    wmax = dat.params.width(2);
else
    wmax = 10000000000;
end
if (dat.params.height(1)~='-')
    hmin = dat.params.height(1);
else
    hmin = 0;
end
if (dat.params.height(2)~='-')
    hmax = dat.params.height(2);
else
    hmax = 10000000000;
end    
if (dat.params.depth(1)~='-')
    dmin = dat.params.depth(1);
else
    dmin = 0;
end
if (dat.params.depth(2)~='-')
    dmax = dat.params.depth(2);
else
    dmax = 10000000000;
end  
if (dat.params.area(1)~='-')
    amin = dat.params.area(1);
else
    amin = 0;
end
if (dat.params.area(2)~='-')
    amax = dat.params.area(2);
else
    amax = 10000000000;
end  
end

