data hotelstemp;
	infile 'd:/sharesas/data/github/SAS-Learning/file/Hotel.dat';
	input 
		room
		num_guests
		_checkin_month
		_checkin_day
		_checkin_year
		_checkout_month
		_checkout_day
		_checkout_year
		used_internet $
		internet_use_days 49-52
		room_type $53-68
		room_rate;
run;
proc print data=hotelstemp;
run;

data hotels;
	set hotelstemp;
	/*CATX( ) 移除开头和末尾的空格,插入分隔符,返回一个连续的字符串.*/
	date_in=input(catx('-',_checkin_year,_checkin_month,_checkin_day),yymmdd10.);
	/*input表示将catx()产生的结果character string 转换成'yymmdd10.'格式的日期*/
	date_out=input(catx('-',_checkout_year,_checkout_month,_checkout_day),yymmdd10.);

	stay_length_days=date_out - date_in;
	room_charge=stay_length_days * room_rate;
	added_guest_fee=(num_guests-1)*10*stay_length_days;
	internet_fee=9.95 + (internet_use_days * 4.95);
	total_charges=sum(room_charge,added_guest_fee,internet_fee);
	grand_total=total_charges+(total_charges*0.075);

	format
		date_in yymmdd10.
		date_out yymmdd10.;
	drop _:;
run;
proc print data=hotels;
	title 'Processed Data';
run;


*语法:CALL CATX(delimiter, result<, item-1 , … item-n> );
/*例:CATX 的演示*/

/*DROP语句: 从输出SAS 数据集中排除变量.
语法: DROP variable-list;
*/

data _null_;
length answer $ 50;
separator='%%$%%';
x='Athens is t ';
y='he Olym ';
z=' pic site for 2004. ';
call catx(separator,answer,x,y,z);
put answer;
run;
/*结果:
Athens is t%%$%%he Olym%%$%%pic site for 2004.
*/

/***********************************
*Input(): Returns the value that is produced when SAS converts an expression using the specified informat
*语法:INPUT(source, <? | ??>informat.) 
***********************************/

/*将字符值转换为数字值.*/
data testin;
	input sale $9.;
	fmtsale=input(sale,comma9.);
	datalines;
2,115,353
;
run;
proc print data=testin;
run;
/* Obs  	sale       fmtsale

    1     2,115,353    2115353
*/

data testinput;
	numdate=122591;
	chardate=put(numdate,z6.);
	sasdate=input(chardate,mmddyy6.);
run;
proc print data=testinput;
run;
/*
  Obs   numdate    chardate    sasdate

  1      122591     122591      11681
*/


/*CAT FUNCTION*/
/*不移除前后的空格,返回一个连续的字符串.
Does not remove leading or trailing blanks,and returns a concatenated character string.
语法:CAT(item-1 <, …, item-n> ) */
data cat2012;
	x='  The 2012 Olym'; 
	y='pic Arts Festi';
	z='  val  included works by D   ';
	a='ale Chihuly.';
	result=cat(x,y,z,a);
	put result $char.;
run;
proc print data=cat2012;
run;
/*结果:
  Obs          x                y                      z                     a

   1     The 2012 Olym    pic Arts Festi    val  included works by D    ale Chihuly.

  Obs                                   result

   1     The 2012 Olympic Arts Festi  val  included works by D   ale Chihuly.
*/
