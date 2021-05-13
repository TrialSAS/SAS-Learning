/*nocenter 不居中，即左对齐*/
/*nonumber 是否在每页的title line打印页码*/
options nocenter nonumber;

data veg;
	infile 'D:\SASShare\Data\github\SAS-Learning\file\veggies.txt';
	input Name $ Code $ Days Number Price;
	CostPerSeed = Price / Number;
run;

title 'List of the Raw Data';
proc print data=veg;
run;

/*FREQ 生成频率表或交叉表，*/
/*计算每个变量的频数、百分比、累计频数、累计百分比*/
title 'Frequency Distribution of Vegetable Names';
proc freq data=veg;
	tables Name;
run;

/*Means 描述统计，默认计算N值，均值，标准偏差，最小值，最大值。*/
title'Average Cost of Seeds';
proc means data=veg;
	var Price Days;
run;
