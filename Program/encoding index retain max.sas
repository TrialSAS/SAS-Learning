data icecream;
	infile 'd:/sasshare/data/github/sas-learning/file/BenAndJerrys.dat'
	dsd dlm = ','  truncover encoding = 'wlatin1';
	input flavor :$200. portion_size_g calories calories_fat fat_g saturated_fat_g trans_fat_g
		cholesterol_mg sodium_mg carbs_g fiber_g $ sugar_g protein_g introduced_year 
		retired_year description :$200. notes :$200.;
run;
/*NOTE: ���ݼ� WORK.ICECREAM �� 71 ���۲�� 17 ��������*/

/*ȥ��retired_year��ȱʧֵ�Ĺ۲�,ȥ�����б���notes����"Scoop Shop"�Ĺ۲�.*/
data icecream_current;
	set icecream;
	if (retired_year>.)then delete;
	if (index(notes,'Scoop Shop')>0) then delete;
run;
/*NOTE: ���ݼ� WORK.ICECREAM_CURRENT �� 59 ���۲�� 17 ��������*/


/* Calculate calories per tablespoon.����ÿ�׵Ŀ�·�� */
data calories_tbs;
	set icecream_current;
	Tbs_Per_Serving=portion_size_g/15;

	/*ÿ�׵Ŀ�·�� calories_tbs*/
	calories_tbs=calories/Tbs_Per_Serving;
	if calories_tbs=. then delete;
run;
/*���ݼ� WORK.CALORIES_TBS �� 58 ���۲�� 19 ��������*/


* Calculate running total of calories consumed if one were to eat one ;
* tablespoon of each icecream ;
data cumulative_sampling;
	set calories_tbs;
	cumulative_calories+calories_tbs; /*�ۼ�*/
run;
/*NOTE: ���ݼ� WORK.CUMULATIVE_SAMPLING �� 58 ���۲�� 20 ��������*/

data highest_calories;
	set cumulative_sampling;
	retain MaxCalories;
	MaxCalories=max(MaxCalories,calories);
run;
/*NOTE: ���ݼ� WORK.HIGHEST_CALORIES �� 58 ���۲�� 21 ��������*/

*1. MAX();
/*max()����һ��matrix��һ��matrix�е� ���ֵ��matrix������numeric��character��
�﷨�� MAX(matrix1 <, matrix2, ��, matrix15> ); */

*2.RETAIN;
/*retain() ��data���е�һ�ε�������һ�ε����б�������ֵ��*/

*3. ENCODING= ;
/*encoding= ����ת��
wlatin1  ���� Windows
utf-8  Unicode (UTF-8)
dec-cn  �������� DEC
*/

*4. INDEX () ;
/*Syntax: INDEX(source, excerpt) 
��source������excerpt,�����ظ�string��һ�γ��ֵ�λ��.
����:x = index(a, b); �ڱ���a������b,������b��һ�γ��ֵ�λ��.
*/