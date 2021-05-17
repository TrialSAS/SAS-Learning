data age;
	input ID Age;
	if 0 <= Age <=50 then Group='A';
	else if 50 <=Age <= 70 then Group='B';
	else if Age > 70 then Group = 'C';
	datalines;
1  18
2  50
3  65
4  70
5  71
;
run;
proc print data=age;
var Group ID Age;
run;
/*
 Obs    Group    ID    Age

 1       A       1     18
 2       A       2     50
 3       B       3     65
 4       B       4     70
 5       C       5     71
*/


/*QTR()计算一个SAS日期值 在一年中的季度。 */
data pts;
	Quarter=QTR(MDY(04,05,2063));
run;
proc print data=pts;
run;
/*结果：Quarter=2 */

DATA _NULL_;
	x='20jan94'd;
	y=qtr(x);
	put y=;   /* y=1 */
run;

data sumexample;
	input Number;
	cumsum+Number;   *累加;
	datalines;
1
6
10
11.1
18
5.6
1.1
;
run;
proc print data=sumexample;
run;

/*
   Obs    Number    cumsum

    1       1.0       1.0
    2       6.0       7.0
    3      10.0      17.0
    4      11.1      28.1
    5      18.0      46.1
    6       5.6      51.7
    7       1.1      52.8
*/


data runners;
	input Age Gender $;
	if 4 < Age and Age < 9 then Group=1;
	else if 9 <= Age  and Age <13 then Group=2;
	else if Age >= 13 then Group=3;
	else Group=4;
	datalines;
4   male
1   female
2   male
3   female
8   female
9   male
12  male
70  male
65  female
;
run;
proc print data=runners;
	var Group Gender Age;
run;

/*
  bs    Group    Gender    Age

  1       4      male        4
  2       4      female      1
  3       4      male        2
  4       4      female      3
  5       1      female      8
  6       2      male        9
  7       2      male       12
  8       3      male       70
  9       3      female     65
*/

data smokers;
	input Smoke Sbp Dbp;
	length Risk $ 8;
	format Risk $8.;

	if Smoke>0 then do;
		if Sbp >=140 or Dbp >= 90 then Risk = "Severe";
		else if (Sbp >= 120 and Sbp < 140 ) or  (Dbp >=80 and Dbp <90) then Risk= "High";
		else if (Sbp > 0 and Sbp < 120) or (Dbp >0 and Dbp < 80) then Risk = "Medium";
		else Risk= "Unknow";
	end;

	else if Smoke= 0 then do;
		if Sbp >= 140 or Dbp >= 90 then Risk="High";
		else if (Sbp >=120 and Sbp <= 140) or (Dbp>=80 and Dbp <= 90) then Risk="Medium";
		else if (Sbp >0 and Sbp < 120) or (Dbp > 0 and Dbp< 80 ) then Risk="Low";
		else Risk = "Unknow";
	end;

	else Risk = "Unknow";
	
datalines;

1 140 80
1 130 90
1 120 100
1 110 85
1 100 75
1 75 75
0 140 80
0 130 90
0 120 100
0 110 85
0 100 75
0 75 75
1 0 0
0 0 0
;
run;

proc print data=smokers;
run;
