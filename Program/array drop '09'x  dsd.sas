filename wl 'D:\SASShare\Data\github\SAS-Learning\file\WLSurveys.dat';

/*dsd delimiter-sensitive-data�ָ�����������.
1.������ʹ�����Ű�Χʱ,��������ķָ������������ݵ�һ����.
2.��ʹ��DSD��,SAS�Ὣ���������ķָ�����Ϊһ��ȱʧֵ.*/
/* Read tab delimited raw data file */
data weightloss;
	infile wl dsd dlm='09'x;  /* '09'x ��ASCII�б�ʾtab . */
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
data weightloss_clean(drop=n);  /*ȥ���ڴ���"do n=1 to 15;"�����ɵı���n��*/
	set weightloss;
	/*qupdate{15}��(weightloss��2,3,5��.)*/
	array qupdate{15}
		v1q2 v2q2 v3q2 v4q2 v5q2 
		v1q3 v2q3 v3q3 v4q3 v5q3
		v1q5 v2q5 v3q5 v4q5 v5q5;

	/*���������˱���n�������������ݼ�weight_clean��ʱ��drop�ˡ�	*/
	do n=1 to 15;
		/*����ֵ,0-3,1-2,2-1,3-0��ֵ.*/
		if qupdate{n} = 0 then
			qupdate{n}=3;
		else if qupdate{n} =1 then
			qupdate{n}=2;
		else if qupdate{n} = 2 then
			qupdate{n} = 1;
		else if qupdate{n} = 3 then
			qupdate{n} = 0;
	end;
	/*missupdate{30}��ȡ���ݶ���weight_loss.	*/
	array missupdate{30}
		v1q1 v1q2 v1q3 v1q4 v1q5 v1q6
		v2q1 v2q2 v2q3 v2q4 v2q5 v2q6
		v3q1 v3q2 v3q3 v3q4 v3q5 v3q6
		v4q1 v4q2 v4q3 v4q4 v4q5 v4q6
		v5q1 v5q2 v5q3 v5q4 v5q5 v5q6;
	do n=1 to 30;
		/*��ֵΪ-99�� ��Ϊȱʧֵ.*/
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
/*weightloss_bmi���weightloss_clean����� �����������ǣ�
v1bmi v2bmi v3bmi v4bmi v5bmi��n*/ 

/* Subset final data as only obese patients */
data weightloss_obese;
	set weightloss_bmi;
	/*ֻѡȡv5bmi >= 25.0 �Ĺ۲⡣*/
	where v5bmi >= 25.0;
run;
/*NOTE: The data set WORK.WEIGHTLOSS_OBESE has 246 observations and 43 variables.*/