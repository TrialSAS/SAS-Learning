/*代码功能：员工加薪。
建立employees数据集，根据Grade参数确定最高和最低薪资；
然后根据Salary_Month确定	Expected_Salary ；
给高管额外奖金。
*/
data employees;
	infile 'd:/sharesas/data/github/SAS-Learning/file/Employees.dat' truncover;
	input 
		SSN $11.
		Name $16-46
		DOB DATE9.
		Grade $
		Salary_Month DOLLAR10.2
		Title $ 73-99;
		/*yrdif()函数：计算年龄*/
		/*int()函数： 取整。*/
		Age_At_revew=int(yrdif(DOB,TODAY(),'AGE'));
	
	IF Grade = 'GR20' THEN DO;
		MinSalary = 50000.00;
		MaxSalary = 70000.00;
	END;

	ELSE IF Grade = 'GR21' THEN DO;
		MinSalary = 55000.00;
		MaxSalary = 75000.00;
	END;

	ELSE IF Grade = 'GR23' THEN DO;
		MiSalary =70000.00;
		MaxSalary = 100000.00;
	END;

	ELSE IF Grade = "GR24" THEN DO;
	MinSalary = 80000.00;
	MaxSalary = 120000.00;
	END;	

	ELSE IF Grade = "GR25" THEN DO;
	MinSalary = 100000.00;
	MaxSalary = 150000.00;
	END;	

	ELSE IF Grade = "GR26" THEN DO;
	MinSalary = 120000.00;
	MaxSalary = 200000.00;
	END;	
	
	ELSE DO
	MinSalary = .;
	MaxSalary = .;
	END;
END;

IF (Salary_Month * 12 * 1.025) > MaxSalary THEN 
	Expected_Salary = MaxSalary;
ELSE 
	Expected_Salary = (Salary_Month * 12 * 1.025);

* Give a $1000.00 bonus to leads, directors, and managers.;
/*FINDW()函数： 返回一个word在string中的字节位置。
语法：FINDW(string, word <, chars> )*/
/*/*FINDW(Title,'Lead')在字串Title中查找word“Lead”并返回位置。*/*/
IF FINDW(Title, "Lead") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;

ELSE IF FINDW(Title, "Manager") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;

ELSE IF FINDW(Title, "Director") THEN DO;
	Expected_Salary = Expected_Salary + 1000.00;
	Bonus = "Yes";
END;
	
ELSE DO;
	Expected_Salary = Expected_Salary;
	Bonus = "No";
END;
	
FORMAT 
	DOB DATE9.
	Salary_Month DOLLAR10.2
	MinSalary DOLLAR10.2
	MaxSalary DOLLAR10.2
	Expected_Salary DOLLAR10.2
;

RUN;

PROC PRINT data = employees;
WHERE Name IN ("William Stone", "Mark Harrison");
RUN;


/*FINDW() 例：*/
data _null_;
	whereisshe=findw('She sells sea shells? Yes, she does.','she');
	put whereisshe=;
run;
/*结果：whereisshe=28	*/
