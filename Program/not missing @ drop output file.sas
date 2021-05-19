* Read data from DAT file ;
DATA donations;
	INFILE "D:\SASShare\Data\github\SAS-Learning1\file\Donations.dat" TRUNCOVER;
	INPUT id 1-4 first $ 6-19 last $ 20-33 address $ 34-58 city $ 59-88 zip $ 94-98 amount 101-105 month 106-107 ;
RUN;

* Use RETAIN to fill in missing data down columns ;
DATA donations_fill;
	SET donations;
	
	/* RETAIN 从DATA步的一次迭代到下一次迭代保留值. */
	RETAIN _first _last _address _city _zip;
	IF NOT MISSING(first) THEN _first = first;
	
	/*如果first有缺失值,则用上一个first的值来填充该缺失值.*/
	/*如果first不是缺失值,则MISSING(first)值为0, 所以not missing()就为1,如此将first的值保存在_first中*/
	
	IF NOT MISSING(last) THEN _last = last;
	IF NOT MISSING(address) THEN _address = address;
	IF NOT MISSING(city) THEN _city = city;
	IF NOT MISSING(zip) THEN _zip = zip;
	
	/*MISSING function:  返回一个数字,表明参数是否包含一个缺失值.
	有缺失值,返回1；无缺失值，返回0.*/
	
	/*当first是缺失值时,用_first的值来补全first的值.*/
	first = _first;
	last = _last;
	address = _address;
	city = _city;
	zip = _zip;

	DROP _:;
	/*表示,输出数据集中不包含以"_"开头的变量.*/
	
RUN;

PROC MEANS data = donations_fill NOPRINT; 
	VAR amount ;
	BY id first last address city zip month;
	OUTPUT OUT = donations_summary
	/*将统计结果写入到一个新数据集中. out= 对新数据集命名.*/
				sum(amount)=;
RUN;

DATA _NULL_;
	SET donations_summary;
	BY id;
	
	IF month = 1 THEN monthtext = "Jan";
	ELSE IF month = 2 THEN monthtext = "Feb";
	ELSE IF month = 3 THEN monthtext = "Mar";
	ELSE IF month = 4 THEN monthtext = "Apr";
	ELSE IF month = 5 THEN monthtext = "May";
	ELSE IF month = 6 THEN monthtext = "Jun";
	ELSE IF month = 7 THEN monthtext = "Jul";
	ELSE IF month = 8 THEN monthtext = "Aug";
	ELSE IF month = 9 THEN monthtext = "Sep";
	ELSE IF month = 10 THEN monthtext = "Oct";
	ELSE IF month = 11 THEN monthtext = "Nov";
	ELSE IF month = 12 THEN monthtext = "Dec";
	ELSE monthtext = "Unknown";
	
	FORMAT amount DOLLAR8.2;
	
	FILE "D:\SASShare\Data\github\SAS-Learning1\output\Donations.txt" PRINT;
	
	/*FILE: Specifies the current output file for PUT statements.*/
	TITLE;
	IF first.id THEN DO;
	PUT _PAGE_ ;
	PUT	@1 "To: " first " " last /   
	/*一个/ 表示向下跳1行,(越过一个记录)advances the pointerto column 1 of the next input record.*/
	    @5 address /
	    @5 city " " zip //
		
	/*两个//表示向下跳2行,越过两个记录.  */
		/*@5 绝对列控制符,将指针移动到第5列.*/
		
	    @5 "Thank you for your support!  Your donations help us save hundreds of cats and dogs each year" /
		@5 "Donations to Coastal Humane Society" /
		@5 "(Tax ID: 99-5551212)" ;
	end;
	/* Forward slash not needed, as a new line will print on each iteration */
	PUT	@5 monthtext " " amount;
	
RUN;

/*Donations.txt的内容：
To: Carrie  Morales
    10713 View Wy.
    Los Angeles  90097

    Thank you for your support!  Your donations help us save hundreds of cats and dogs each year
    Donations to Coastal Humane Society
    (Tax ID: 99-5551212)
    May  $155.00
    Jun  $50.00
    Sep  $65.00
*/

/*
PROC MEANS <options> <statistic-keyword(s)>;
	BY <DESCENDING> variable-1 <<DESCENDING> variable-2 …>
		<NOTSORTED>;
	CLASS variable(s) </ options>;
	FREQ variable;
	ID variable(s);
	OUTPUT <OUT=SAS-data-set> <output-statistic-specification(s)>
		<id-group-specification(s)> <maximum-id-specification(s)>
		<minimum-id-specification(s)> </ options> ;
	TYPES request(s);
	VAR variable(s) </ WEIGHT=weight-variable>;
	WAYS list;
	WEIGHT variable;
*/

/*
FILE Statement: Specifies the current output file for PUT statements.
语法: FILE file-specification <device-type> <options> <operating-environment-options>; 
*/
/*例如:
DATA _NULL_;
  FILE log dsd;    /*表示将put语句输出的内容打印到log*/
  x='"lions, tigers, and bears"';
  put x ' "Oh, my!"';
run;
结果:
"""lions, tigers, and bears""", "Oh, my!"
*/

/*例：
DATA _NULL_;
  FILE log dsd;
  PUT 'lions, tigers, and bears';
run;

结果：
lions, tigers, and bears
*/



