data demographic;
	infile 'D:\SASShare\Data\github\SAS-Learning\file\mydata.txt';
	input Gender $ Age Height Weight;
	BMI = (Weight /2.2)/ (Height*.0254)**2
run;
