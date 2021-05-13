data demographic;
	infile 'D:\SASShare\Data\github\SAS-Learning\file\mydata.txt';
	input Gender $ Age Height Weight;
run;

title 'Gender Frequencies';
proc freq data=demographic;
	/* 表示用变量Gender来计算频率 */
	/* Following the word TABLES, you list those 
	  *variables for which you want frequency counts. */
	tables Gender;
run;

title 'Summary Statistics';
proc means data=demographic;
	/*只计算Age,Height,Weight的描述统计.*/
	var Age Height Weight;
run;

/****************************************************** 
*                                  累积       累积
* Gender      频数      百分比       频数      百分比
* ---------------------------------------------------
* F                2     40.00            2     40.00
* M                3     60.00            5    100.00
*******************************************************/

/*********************************************************
* MEANS 过程
*
* 变量     N           均值       标准偏差         最小值         最大值
* ----------------------------------------------------------------------
* Age      5     37.6000000     20.2188031     15.0000000     65.0000000
* Height   5     67.2000000      4.8682646     60.0000000     72.0000000
* Weight   5    155.0000000     44.0056815    101.0000000    220.0000000
* ----------------------------------------------------------------------
**********************************************************/
