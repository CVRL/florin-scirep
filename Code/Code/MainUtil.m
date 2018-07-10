function [MicroNo,inputDir,Param] = MainUtil(Addr)
dat=loadjson(Addr);
MicroNo = dat.MicroStructures;
inputDir = dat.inputFile;
Param = dat.p;


end

