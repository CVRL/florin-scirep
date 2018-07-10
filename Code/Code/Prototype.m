PrepFuncs('FLoRIN prototype is running ..');
[MicroNo,imgInput,p]=MainUtil('E:\Code\param.json');
ImStack = CubeMaker(imgInput,1,1,40);
[ind1,ind2,NoObj] = Identification(ImStack,p);
p1 = PCMat(ind1,1);
p2 = PCMat(ind2,1);
display(NoObj);

fName = 'Cell';
pcwrite(pointCloud(pl),strcat('E:\Code\',fName),'PLYFormat','binary');
fName = 'Vas';
pcwrite(pointCloud(pl),strcat('E:\Code\',fName),'PLYFormat','binary');



