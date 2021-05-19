libname file 'D:\SASShare\Data\github\SAS-Learning1\file';

proc contents data =file.sff varnum;
run;

proc freq data = file.sff;
	tables Continent;  /*one-way 表.计算Continent的频数,统计分析*/
	title 'Frequency of Countries by Countinent';
run;

proc freq data = file.sff;
	tables Continent;
	title 'Frequency of Countries with No OutBreak in April by Continent';
	where Apr = .;   /*对不包含Apr月份的数据进行分析*/
run;

proc freq data = file.sff;
	tables Continent;
	title 'Frequency of Countries with 1+ Outbreaks in august by Continent';
	where aug>0;  /*分析八月份有爆发病例的continent*/
run;

proc print data = file.sff;
	var Continent Country FirstCase FirstDeath;
	where FirstCase=. and FirstDeath<>.;    
	/*FirstCase和FirstDeath是日期变量*/
	title 'countries with firstcase date and no first case date';
	format FirstDeath MMDDYY10.;
run;

proc sort data = file.sff out = sffsort;
	by Continent;
run;

proc print data = sffsort;
	var Continent Country FirstCase FirstDeath;
	where FirstCase =. and FirstDeath<>.;
	title 'countries with firstDeath Date and no frist Case Date';
	footnote 'Sorted by Continent';
	FORMAT FirstDeath MMDDYY10.;
run;