PrepFuncs('Statistic Reports ...');
mDir ='E:\SR_Paper\Learning Methods\unet3d\EM\Special\manual\';
md = dir(mDir);
tl=[];
for j=3:length(md)
    RDir = strcat(mDir,'\',md(j).name,'\*\');
%     disp(md(j).name);
    filePattern = fullfile(RDir, 'performance.json');
    fileList = dir(filePattern);
     disp(md(j).name);
    
    for k=1:length(fileList)
     FileNames=strcat(fileList(k).folder,'\',fileList(k).name);
%      disp(FileNames);
     dat=loadjson([FileNames]);
     tl(j-2,k)=(dat.train_time);
    end
end
% RDir = 'E:\Daug_Evaluation\model_store\unet\srb\cell\manual\*\*\';
