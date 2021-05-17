/*读取数据,时间格式为time8. ,读取后打印格式format为time8.  */
data newyear;
	infile 'D:\ShareSAS\Data\github\SAS-Learning\file\NewYears.dat' dsd truncover;
	input id (in1-in119 out1-out119)(:TIME8.);
	format in1-in9 time8. out1-out119 time8.;
run;

/*创建数组,判如果out的值不为缺失值,则计算diff(分钟数)  */
data visitlength (keep=id gym_visit1-gym_visit119);
	set newyear;
	array in {119} in1-in119;
	array out {119} out1-out119;
	array diff {119} gym_visit1-gym_visit119;
	do n=1 to 119;
		if out{n} >. then diff{n}=(out{n}-in{n})/60;
	end;
run;

/*计算平均gym_visit. 
如果disc 超过30分钟,则visits_Over_30_Min加1.
 */
data discount (keep=id Has_Discount Visits_Over_30_Min Mean_Duration);
	set visitlength;
	Visit_Over_30_Min=0;
	Mean_Duration=mean(of gym_visit1-gym_visit119);
	array disc {119} gym_visit1-gym_visit119;
	do i=1 to 119;
		if disc{i}>30 then Visits_Over_30_Min+1;
	end;
	/*如果visit_Over_30_min等于119,则享受折扣.*/
	if Visits_Over_30_Min=119 then Has_Discount=1;
	else Has_Discount=0;
run;

/* 1.INPUT*/
/*语法： INPUT <specification(s)> <@ | @@>; */
/* specification（s）可以是variable，可以是variable-list； */

data _null_;
/* 符号/表示 */
input name $ age / id 3-4;
datalines;
zhangsan 11 
1210
;
run;
/*结果:zhangsan 11 10  */
/*先从第1条观测读取到name,age,然后通过 / 跳到第二条观测,读取第3-4 columns.  */