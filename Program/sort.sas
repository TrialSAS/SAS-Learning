data weights;
	input age  sex $ weight;
	datalines;
18 Male 201
18 Female 188
18 Male 183
18 Female 121
18 Female 150
16 Female 109
23 Male 210
33 Female 198
12 Female 78
14 Male 98
;
run;

proc sort data=weights out=weights_sort;
	/*age?????,sex,weight??????*/
	by age descending sex descending weight;
run;

proc print data=weights_sort;
run;
