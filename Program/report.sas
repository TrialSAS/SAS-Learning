data house;
input city $ hb_index same_index def_index;
cards;
北京 99.9 100.3 102.4
天津 99.8 100.2 103.1
秦皇岛 99.8 100.5 106.3
石家庄 99.7 101.3 107.7
包头 99.8 100.0 103.9
太原 100.0 100.9 101.7
;
run;


proc print data=house;
run;

proc report data=house headline headskip;   /*一级目录,二级目录,*/
title '六个大中城市住宅销售价格指数（2012年2月）';
title2 '单月城市销售价格';

column city hb_index same_index def_index dif;     /*列:4个变量,*/
define city/order format=$6. width=6 '城市';     /**/
define hb_index/display format=5.1 width=5 '环比';
define same_index/display format=5.1 width=5 '同比';
define def_index/display format=5.1 width=5 '定基';
define dif/computed format=5.1 width=5 '差比';  
/*city顺序变量,
hb_index,same_index,def_index是显示变量
dif 是计算变量.  dif  = same_index-hb_index;
  */

/*符号/后面的都是define 的选项options. 如display,computed,format,width.*/
/*其中,display定义item,它必须是一个数据集变量,作为 显示变量.*/
/*computed:定义item作为一个 计算变量.*/
/*format 指定FORMAT格式*/
/*width 定义每一个column的宽度.*/  

compute dif;                                   
dif  = same_index-hb_index;
endcomp;                                      
run;


**********************************************************;
/*REPORT 结合了print,means,tabulate等的特征.用来生成一些reports.
语法: 
PROC REPORT<options>;
	BREAK location break-variable </ options>   中断时生成默认摘要summary.
	BY variable-1  在单独页面为每个by group生成单独的报告.
        <<DESCENDING> variable-2 …> <NOTSORTED>;
	COLUMN column-specification(s);   描述所有columns的排列,描述跨多个column的标题的排列.
    COMPUTE location <target>
        </ STYLE=<style-override(s)> >;
    LINE specification(s);
        . . . select SAS language elements . . .
        ENDCOMP;
    COMPUTE report-item </ type-specification>;
        CALL DEFINE (column-id ', < ' attribute-name', value>
            | _ROW_, < 'attribute-name', value>);
        . . . select SAS language elements . . .
        ENDCOMP;
    DEFINE report-item / <options>;   //Define 描述如何使用和展示一个report item.
    FREQ variable;
    RBREAK location </ options>;
    WEIGHT variable;
    
    ****************************************
    其中,Define
    语法:DEFINE report-item / <options>;
    Options的选项有:【控制值和列标签的位置】CENTER, COLOR=color,column-header,LEFT,RIGHT；
        【设置report item的显示】EXCLUSIVE,
             ORDER 定义item,必须时一个data set variable,作为order variable.
 */      
 */

