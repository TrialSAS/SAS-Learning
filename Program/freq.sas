libname file 'D:\SASShare\Data\github\SAS-Learning1\file\';
/*原始文件crayons中的变量：Number,Color,Hex,RGB,Pack,Issued,Retired*/
proc contents data = file.crayons;
run;

proc freq data = file.crayons;
	table Issued;
run;

proc sort data = file.crayons out = crayons_sort sortseq = linguistic (numeric_collation= on);
	by rgb;
run;

proc print data = crayons_sort noobs;
	var color rgb;
run;

/*
FREQ  统计描述.
语法: 
PROC FREQ  <options> ; 
	BY variables; 
	EXACT statistic-options </ computation-options> ; 
	OUTPUT  <OUT=SAS-data-set> output-options; 
	TABLES requests </ options> ; 
	TEST options; 
	WEIGHT variable </ option> ; 
其中,
	by: 分组统计.
	exact: 要求选定的统计方法的精确测试和置信区间
		统计方法:agree,barnard,binomial|bin, chisq,comor,lrchi,smdcr等。
		计算选项(computation-options):alpha,maxtime,mc,N,point,seed等。
	output:生成一个sas数据集，包含统计结果.
	tables: 语法:TABLES requests < / options > ; 要求这些表的1-way到n-way的频率和交叉表和统计
			TABLES requests: A*(B C) , (A B)*(C D) , (A B C)*D 等。
			选项 agree,all,chisq,cl,cmh,cmh1,cmh2,fisher,measures,missing,plcorr,trend,stdres,nocol,等。
				选项的功能：控制统计分析,控制额外的表信息,控制显示输出,生成统计结果，创建输出数据集。
	test:要求渐进检验asymptotic tests. 指定用哪一个test(检验方法来进行计算。
		语法:EST test-options ;    其中选项：agree,gamma,kappa,pcorr,plcorr,smdcr等。
	weight:	语法:WEIGHT variable < / option > 权重.
		
*/

**********************************;
data cellcounts;
	input r c count @@;
	datalines;
1 1 5  1 2 3 
2 1 4  2 2 3
;
run;
proc  freq data = cellcounts;
	tables r*c;
	weight count;
run;

/*R*C表，count是频数/
/* r	c	count */
/* 1	1	5	*/
/* 1	2	3	*/
/* 2	1	4	*/
/* 2	2	3	*/




