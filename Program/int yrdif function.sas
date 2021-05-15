data employees;
	infile 'd:/sharesas/data/github/SAS-Learning/file/Employees.dat' truncover;
	input 
		SSN $11.
		Name $16-46
		DOB DATE9.
		Grade $
		Salary_Month DOLLAR10.2
		Title $ 73-99;
		Age_At_revew=int(yrdif(DOB,TODAY(),'AGE'));


RUN;
