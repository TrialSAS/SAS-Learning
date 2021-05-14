data pharse;
	input id original_phrase $2-50;
	/*用dog 替换所有的cat*/
	better_phrase=tranwrd(original_phrase,'cat','dog');
	datalines;
1 A cat is the best pet ever,I love my cat.
;
run;
proc print data=pharse;
run;
/*tranwrd: 替换一个character string中出现的所有子串 */

/*语法:TRANWRD(source,target,replacement)*/

data list;
	input salelist $;
	length target $10 replacement $3;
	target='FISH';
	replacement='NIP';
	salelist=tranwrd(salelist,trim(target),replacement);
	put salelist;
	datalines;
CATFISH
;
run;
proc print data=list;
run;
/* Obs    salelist    target    replacement

  1     CATFISH      FISH         NIP
可见CATFISH并没有被替换.这是因为target变量中有空格,需要去除空格
使用trim(target)
*/

/*salelist=tranwrd(salelist,trim(target),replacement);*/
/*
结果:
 Obs    salelist    target    replacement

  1      CATNIP      FISH         NIP
*/


data _null_;
	/*	|| 连接操作符  */
	/*这里的tranwrd()将字符串中的'abc'去除。 */
	string1='*' || tranwrd('abcxabc','abc',trimn(''))||'*';
	put string1=;		  *   string1=* x *     ;
	string2='*' || tranwrd('abcxabc','abc','')||'*';
	put string2=;
run;
proc print data=_null_;
run;
/*
string1=* x *
string2=* x *
*/


data _null_;
	mytxt='if you exercise your power to vote,,,then your opinion will be heard,,';
	newtext=tranwrd(mytxt,',,,',',');  *用一个逗号代替3个逗号;
	newtext2=tranwrd(newtext,',,','.');  *用句号代替2个逗号;
	put // mytxt= / newtext= / newtext2=;
run;

/*
mytxt=if you exercise your power to vote,,,then your opinion will be heard,,
newtext=if you exercise your power to vote,then your opinion will be heard,,
newtext2=if you exercise your power to vote,then your opinion will be heard.
*/
