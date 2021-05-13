options ls=72;
title;

/* 生成临时数据集WORK.NASA */
data nasa;
   input YEAR 4. @7 TOTAL comma6.
   		/*@15 绝对列控制符,将指针移动到15位置。*/
   		/* comma6. 读取数字值，并将嵌入的字符删除 */
   		/*原始数值 5,933   读后： 5993*/
         @15 PTOTAL comma6. @20 PFLIGHT comma6.
         @28 PSCIENCE comma6. @37 PAIRTRAN comma6.
         @43 FTOTAL comma6. @49 FFLIGHT comma6.
         @58 FSCIENCE comma6. @64 FAIRTRAN comma6.;

	/*添加标签*/
	/*  */
    label     total='Total Outlays'	
             ptotal='Performance: Total'
            pflight='Performance: Space Flight'
           pscience='Performance: Space Science Applications'
           pairtran='Performance: Air Transport and Other'
             ftotal='Facilities: Total'
            fflight='Facilities: Space Flight'
           fscience='Facilities: Space Science Applications'
           fairtran='Facilities: Air Transport and Other' ;

cards;
1966  5,933  5,361 3,819   1,120    422   572   391      63    118
1967  5,426  5,137 3,477   1,160    500   289   172      47     70
1968  4,726  4,599 3,028   1,061    510   127    69      29     29
1969  4,252  4,187 2,754     893    540    65    27      21     17
1970  3,753  3,699 2,195     963    541    54    14      21     19
1971  3,382  3,338 1,877     926    535    44     8       6     30
1972  3,423  3,373 1,727   1,111    535    50    13       7     30
1973  3,316  3,271 1,532   1,220    519    45     5      11     29
1974  3,256  3,181 1,448   1,156    577    75    25      12     38
1975  3,266  3,181 1,500   1,076    606    85    35       9     42
1976  3,670  3,549 1,934     969    646   121    66      11     43
1977  3,945  3,840 2,195   1,002    643   105    56       4     45
1978  3,984  3,860 2,204     964    692   124    56       8     60
1979  4,187  4,054 2,175   1,144    735   133    41       9     83
1980  4,850  4,710 2,556   1,341    813   140    38       5     97
1981  5,241  5,274 3,026   1,380    868   147    26       4    117
1982  6,035  5,926 3,526   1,454    946   109    17       3     89
1983  6,664  6,556 4,027   1,486  1,043   108    26       .     82
1984  7,048  6,856 4,037   1,667  1,152   192    44      20    128
1985  7,251  7,004 3,852   1,834  1,318   247    70      23    154
1986  7,404  7,105 3,787   2,101  1,317   299   107      26    166
;

/*contents过程 显示数据集nasa的contents*/
proc contents data=nasa;
run;


/* 使用nasa生成数据集perform，含有的变量为keep= 后的变量。 */
data perform;
   set nasa (keep=year ptotal pflight pscience pairtran);
run;
proc print data=perform;
   title 'NASA Performance-Related Expenditures';
run;


data perform2;
   set nasa (drop=total ftotal fflight fscience fairtran);
run;
proc print data=perform2;
   title 'NASA Performance-Related Expenditures';
run;


data NASA2;
	/* firstobs=12  表示以NASA数据集的12行为第一行生成数据集NASA2。 */
   set NASA(firstobs=12);
run;
proc print;
	/*双标题   title2*/
   title 'NASA Expenditures';
   title2 '1977-1986';
run;

/* 生成两个数据集perform、facil。 */
data perform(keep=ptotal pflight pscience pairtran)
     facil  (keep=ftotal fflight fscience fairtran);
   set nasa;
run;
proc print data=perform;
   title 'NASA Expenditures: Performance';
run;
proc print data=facil;
   title 'NASA Expenditures: Facilities';
run;
