options nocenter;

data bodymass;
	Weight=150;
	Height=68;
	BMI=(Weight/Height**2)*703;
run;

proc print data=bodymass;
run;

/*  Obs    Weight    Height      BMI
*
*    1       150       68      22.8049
*/

