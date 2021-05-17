filename wl 'D:\SASShare\Data\github\SAS-Learning\file\WLSurveys.dat';

/*dsd delimiter-sensitive-data分隔符敏感数据.
1.当数据使用引号包围时,引号里面的分隔符被看作数据的一部分.
2.当使用DSD后,SAS会将两个连续的分隔符作为一个缺失值.*/
/* Read tab delimited raw data file */
data weightloss;
	infile wl dsd dlm='09'x;  /* '09'x 在ASCII中表示tab . */
	input id height  
		v1w  v2w  v3w  v4w  v5w 
		v1q1 v1q2 v1q3 v1q4 v1q5 v1q6
		v2q1 v2q2 v2q3 v2q4 v2q5 v2q6
		v3q1 v3q2 v3q3 v3q4 v3q5 v3q6
		v4q1 v4q2 v4q3 v4q4 v4q5 v4q6
		v5q1 v5q2 v5q3 v5q4 v5q5 v5q6
	;
run;
/*The data set WORK.WEIGHTLOSS has 333 observations and 37 variables.*/

/* Correct data for questions 2, 3 and 5 
Replace values of -99 with missing numeric (.)*/
data weightloss_clean(drop=n);  /*去除在代码"do n=1 to 15;"中生成的变量n。*/
	set weightloss;
	/*qupdate{15}是(weightloss的2,3,5列.)*/
	array qupdate{15}
		v1q2 v2q2 v3q2 v4q2 v5q2 
		v1q3 v2q3 v3q3 v4q3 v5q3
		v1q5 v2q5 v3q5 v4q5 v5q5;

	/*这里生成了变量n，但在生成数据集weight_clean的时候drop了。	*/
	do n=1 to 15;
		/*数组值,0-3,1-2,2-1,3-0换值.*/
		if qupdate{n} = 0 then
			qupdate{n}=3;
		else if qupdate{n} =1 then
			qupdate{n}=2;
		else if qupdate{n} = 2 then
			qupdate{n} = 1;
		else if qupdate{n} = 3 then
			qupdate{n} = 0;
	end;
	/*missupdate{30}所取数据都是weight_loss.	*/
	array missupdate{30}
		v1q1 v1q2 v1q3 v1q4 v1q5 v1q6
		v2q1 v2q2 v2q3 v2q4 v2q5 v2q6
		v3q1 v3q2 v3q3 v3q4 v3q5 v3q6
		v4q1 v4q2 v4q3 v4q4 v4q5 v4q6
		v5q1 v5q2 v5q3 v5q4 v5q5 v5q6;
	do n=1 to 30;
		/*将值为-99的 改为缺失值.*/
		if missupdate{n}= -99 then
			missupdate{n}=.;
	end;
run;
/*The data set WORK.WEIGHTLOSS_CLEAN has 333 observations and 37 variables.*/

/* Calculate BMI at each visit */
data weightloss_bmi;
	set weightloss_clean;
	array weight {5} v1w v2w v3w v4w v5w;
	array bmi {5} v1bmi v2bmi v3bmi v4bmi v5bmi;

	do n=1 to 5;
		bmi{n}=(weight{n}/height**2)* 703;
	end;
run;
/*The data set WORK.WEIGHTLOSS_BMI has 333 observations and 43 variables.*/
/*weightloss_bmi相较weightloss_clean多出来 的六个变量是：
v1bmi v2bmi v3bmi v4bmi v5bmi，n*/ 

/* Subset final data as only obese patients */
data weightloss_obese;
	set weightloss_bmi;
	/*只选取v5bmi >= 25.0 的观测。*/
	where v5bmi >= 25.0;
run;
/*NOTE: The data set WORK.WEIGHTLOSS_OBESE has 246 observations and 43 variables.*/