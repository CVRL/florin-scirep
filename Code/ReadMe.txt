FLoRIN Prototype

This prototype code, prepaid by MATLAB, simply shows how FLoRIN sparsly threshold, identify and reconstruct microscopic images.

---------------------------------------------------------------------------------------------------------------------------------
How to run FLoRIN
---------------------------------------------------------------------------------------------------------------------------------

1- Run NDNT to threshold and make a B&W stack

NDNT parameters are 
	-i : input path
	-o : output path
	-t : threshold value
	--Shape : 3D cubic volume (z x y : 4 64 64)
	--Step  : 3D overlapping on Shape (z x y : 2 32 32)

example : python segment.py -i /images/ -o /threshold/ -t 0.3 --shape 4 64 64 --step 2 32 32

2- Run Prototy.m over the result of thresholding
	all the parameters will be set on .json files


Note: 
* To prepare this prototype simple we took advantage of json reader library (Qianqian Fang) and stlwrite (Sven) from MATLAB Matwork website. Note that FLoRIN will be released as online sofware (writtern in Python) on summer 2018
