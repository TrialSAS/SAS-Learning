/*例1:读取日期*/
data datetest;
	input date:MMDDYY10. @@;
	FORMAT date MMDDYY10.;
	DATALINES;
09/01/2015 09/01/2015
10/01/2015 10/01/2015
11/01/2015 11/01/2015
12/01/2015 12/01/2015
07/04/1776 07/04/1776
;
RUN;
PROC PRINT DATA=DATETEST;
RUN;
/*
Obs    date

1    09/01/2015
2    09/01/2015
3    10/01/2015
4    10/01/2015
5    11/01/2015
6    11/01/2015
7    12/01/2015
8    12/01/2015
9    07/04/1776
10   07/04/1776
*/

*************************************************；
/*例2:两位数的年,two-digits year*/
options yearcutoff=1950;
data _null_;
	a='26oct02'd;
	put 'SAS date='a;
	put 'formatted date='a date9.;
run;
/*当日期是两位数的年,使用YEARCUTOFF= option 指定年的范围.*/
/*
SAS date=15639
formatted date=26OCT2002
*/

***************************************************；
/*例3:当两位的年和四位的年同时出现时,YEARCUTOFF= 不影响Four-Digit Years*/
options yearcutoff=1920 nodate;
data schedule;
	input @1 jobid $ @6 projdate mmddyy10.;
	/*@1 绝对列控制符*/
	datalines;
A100 01/15/25
A110 03/15/2025
A200 01/30/96
B100 02/05/00
B200 06/15/2000
;

proc print data=schedule;
	format projdate mmddyy10.;
run;

/*
 Obs    jobid      projdate

 1     A100     01/15/1925
 2     A110     03/15/2025
 3     A200     01/30/1996
 4     B100     02/05/2000
 5     B200     06/15/2000
*/

/*informat和format的区别
* informat读取特定格式的日期时间，然后转换为SAS value存储
* format 指定打印格式。以指定的格式显示。
*/
/*https://support.sas.com/documentation/cdl/en/lrcon/62955/HTML/default/viewer.htm#a002200738.htm*/

**********************************；
options pageno=1 linesize=80 pagesize=20;
data test;
	Time1=86399;
	format Time1 datetime.;
	Date1=86339;
	format Date1 date.;
	Time2=86339;
	format Time2 timeampm.;
run;

proc print data=test;
	title 'Same Number,Different SAS Values';
	footnote1 'Time1 is a SAS DATETIME value';
	footnote2 'Date1 is a SAS DATE value';
	footnote3 'Time2 is a SAS TIME value';
run;
footnote;
/* 
Obs        Time1           Date1        Time2

 1     01JAN60:23:59:59    21MAY96    11:58:59 PM
*/
/***********************************
*Time format：between 0 and 86400.
*************************************/

/*时间日期的计算*/
date meeting;
	input region $ mtg:mmddyy8.;
	sendmail=mtg-45;
	datalines;
N  11-24-99
S  12-28-99
E  12-03-99
W  10-04-99
;
proc print data=meeting;
	format mtg sendmail date9.;
	title 'When to send announcements';
run;
