DATA answer;
	x=min(sum(1,2,3),65/8,N(8));
RUN;
PROC PRINT data=answer;
RUN;

/*结果：
* obs     x
*  1      1
*/

/*函数N(),返回非缺失值的数量.
x1=n(1,0,.,2,5,.,.);  结果为:4。

*/
