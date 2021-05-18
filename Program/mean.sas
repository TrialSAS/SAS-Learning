DATA test;
	input gender $ Age;
	datalines;
Male 33
Female 15
Male 55
Female 29
Male 12
Female 88
Female 46
Male 60
;
run;
proc means data = test;
	class gender;
	var Age;
	/* 分析Age,通过Gender分组. */
	title1 'means using class var';
run;

proc sort data = test;
	by gender;
run;
proc means data = work.test;
	by gender;
	var age;
	title 'proc means using by';
run;

/*例2  */
data meantest;
	input males females;
	datalines;
12 56
15 88
79 56
14 67
46 55
37 46
12 7
44 65
;
run;

proc means data = work.meantest;
	output out = test_means
	mean(females males)=femaleAge maleAge;
run;

proc print data = test_means;
	title 'proc means data with output statistic list';
run;

/*MEAN 描述统计
语法: MEAN assignment <, assignment …>; 
by 为每个by group生成单独的统计信息.使用by 需要先排序.
class  指定通过哪个变量的值分成子组进行分析.
freq  频率.指定一个数值变量,包含每个观测的频率.也就是N值.
id   在输出数据集中包含其他变量.	
output  将statistics统计结果写入到一个SAS数据集.
types	标识类变量的哪个可能组合来生成. type A*(B C)  等价于 types A*B A*C;
var	   在output中标识分析变量 和他们的顺序. 比如var Age; 即对Age统计分析.
ways	指定ways的数量,to make unique combinations of class variables.
weight  指定权重.
  */

*****************************************;
proc means data=test;
	title;
	freq age;
	var age;
run;