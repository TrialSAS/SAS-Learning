data icecream;
	infile 'd:/sasshare/data/github/sas-learning/file/BenAndJerrys.dat'
	dsd dlm = ','  truncover encoding = 'wlatin1';
	input flavor :$200. portion_size_g calories calories_fat fat_g saturated_fat_g trans_fat_g
		cholesterol_mg sodium_mg carbs_g fiber_g $ sugar_g protein_g introduced_year 
		retired_year description :$200. notes :$200.;
run;
/*NOTE: 数据集 WORK.ICECREAM 有 71 个观测和 17 个变量。*/

/*去除retired_year有缺失值的观测,去掉含有变量notes含有"Scoop Shop"的观测.*/
data icecream_current;
	set icecream;
	if (retired_year>.)then delete;
	if (index(notes,'Scoop Shop')>0) then delete;
run;
/*NOTE: 数据集 WORK.ICECREAM_CURRENT 有 59 个观测和 17 个变量。*/


/* Calculate calories per tablespoon.计算每勺的卡路里 */
data calories_tbs;
	set icecream_current;
	Tbs_Per_Serving=portion_size_g/15;

	/*每勺的卡路里 calories_tbs*/
	calories_tbs=calories/Tbs_Per_Serving;
	if calories_tbs=. then delete;
run;
/*数据集 WORK.CALORIES_TBS 有 58 个观测和 19 个变量。*/


* Calculate running total of calories consumed if one were to eat one ;
* tablespoon of each icecream ;
data cumulative_sampling;
	set calories_tbs;
	cumulative_calories+calories_tbs; /*累加*/
run;
/*NOTE: 数据集 WORK.CUMULATIVE_SAMPLING 有 58 个观测和 20 个变量。*/

data highest_calories;
	set cumulative_sampling;
	retain MaxCalories;
	MaxCalories=max(MaxCalories,calories);
run;
/*NOTE: 数据集 WORK.HIGHEST_CALORIES 有 58 个观测和 21 个变量。*/

*1. MAX();
/*max()返回一个matrix或一组matrix中的 最大值。matrix可以是numeric或character。
语法： MAX(matrix1 <, matrix2, …, matrix15> ); */

*2.RETAIN;
/*retain() 在data步中的一次迭代到下一次迭代中保留变量值，*/

*3. ENCODING= ;
/*encoding= 数据转码
wlatin1  西文 Windows
utf-8  Unicode (UTF-8)
dec-cn  简体中文 DEC
*/

*4. INDEX () ;
/*Syntax: INDEX(source, excerpt) 
在source中搜索excerpt,并返回该string第一次出现的位置.
例如:x = index(a, b); 在变量a中搜索b,并返回b第一次出现的位置.
*/