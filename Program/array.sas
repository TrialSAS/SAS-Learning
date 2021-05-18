data lastnames;
	input lastname $ 10.;
	datalines;
de Bie
De Leon
DeVere
DeMesa
Dewey
;
run;

/* 在这里使用linguistic 使忽略大小写。 */
/*使用linguistic  顺序排序，并使用了linguistic的选项strength
primary指定两个base characters的不同。*/
proc sort data = lastnames out = answera
	sortseq = linguistic(strength=primary);
	by lastname;
run;
/* Obs	lastname */
/* 1	de Bie */
/* 2	De Leon */
/* 3	DeMesa */
/* 4	DeVere */
/* 5	Dewey */
proc sort data = lastnames out = answerb
	sortseq = ascii;
	by lastname;
run;
/* Obs	lastname */
/* 1	De Leon */
/* 2	DeMesa */
/* 3	DeVere */
/* 4	Dewey */
/* 5	de Bie */
proc sort data = lastnames out =answerc
	nodupkey;
	by lastname;
run;
/* Obs	lastname */
/* 1	De Leon */
/* 2	DeMesa */
/* 3	DeVere */
/* 4	Dewey */
/* 5	de Bie */



/*SORT 排序 
语法:PROC SORT <collating-sequence-option> <other option(s)>; 
选项：
datecopy：排序，但不更改。
nodupkey：删除有重复 by值 的观测。
nouniquekey：从output数据集中删除具有唯一sort key的观测。
排列顺序：ASCII、DANISH（丹麦）、FINNISH（芬兰）、SORTSEQ=collating-sequence。
其中，collating-sequence-option的选项有：
•translation_table
•encoding-value

•LINGUISTIC
而，LINGUISTIC<(collating-options)>中，collating-options的选项有：
CASE_FIRST=
COLLATION=
LOCALE= locale_name

STRENGTH=  本例中出现的就是这个，STRENGTH=的选项有：
PRIMARY or 1、SECONDARY or 2、TERTIARY or 3、QUATERNARY or 4、IDENTICAL or 5。
其中，primary指定： 基础字符的差异，比如 （"a" < "b"). 

 */