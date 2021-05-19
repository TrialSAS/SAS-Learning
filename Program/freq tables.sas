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

/*

PROC FREQ  <options> ; 
	BY variables; 		//by group 分组分析.
	EXACT statistic-options </ computation-options> ;   //精准检验,
	OUTPUT  <OUT=SAS-data-set> output-options;   //指定统计结果输出到数据集.
	TABLES requests </ options> ; 	//指定表和请求分析.  one-way和n-way表.
	TEST options; 	指定检验方法.如pcorr,plcorr
	WEIGHT variable </ option> ;    权重.
*/
/*
tables 如果使用了TABLES语句,FREQ生成one-way对所有的其他statement没有列出的 数据集变量生成频数表.
语法:TABLES requests </ options> ; 
	requests:指定要生成的频数和交叉表. (由一个或多个变量名组成,
		多个变量名由星号*分隔.如A*(B C) ,(A B)*(C D) )
*/

/*
	<> 取最大值运算符 
a = { 2  4  6,
     10 11 12};
b = { 1  9  2,
     20 10 40};
c = a<>b;
print c;
结果:
    c
 2  9  6 
20 11 40 
*/

/*
取最小值运算符 ><
a = { 2  4  6,
     10 11 12};
b = { 1  9  2,
     20 10 40};
c = a><b;
print c;
结果:
   c
1   4 2 
10 10 12 
*/


/*
垂直连接操作符 //
a = {1 1 1,
     7 7 7};
b = {0 0 0,
     8 8 8};
c = a//b;
print c;

结果:
  c
1 1 1 
7 7 7 
0 0 0 
8 8 8 
*******************;
例2:
d = {"AB" "CD",
     "EF" "GH"};
e = {"I" "J",
     "K" "L",
     "M" "N"};
f = d//e;
print f;

结果:
  f
AB CD 
EF GH 
I J 
K L 
M N 
*/

/*
水平连接操作符 ||
a = {1 1 1,
     7 7 7};
b = {0 0 0,
     8 8 8};
c = a||b;
print c;

结果:
	c
1 1 1 0 0 0 
7 7 7 8 8 8 
*/





