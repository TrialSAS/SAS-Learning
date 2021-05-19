libname file 'D:\SASShare\Data\github\SAS-Learning1\file';

proc contents data = file.gas;
run;

proc means data = file.gas
	maxdec = 2;
	by year;
	var GasPrice;
run;

data gas_qtr;
	set file.gas;
	DummyDate = MDY(Month,01,Year);
	Qtr=QTR(DummyDate);
	DROP DummyDate;
run;

proc means data = gas_qtr
	maxdec=2;
	by year qtr;
	var gasPrice;
	output out = gas_summary(drop=_FREQ_ _TYPE_)
		MEAN(GasPrice)= AvergePrice
		STD(GasPrice)=stdDev
	;
	format AveragePrice dollar6.2
		stdDve dollar6.2;
run;