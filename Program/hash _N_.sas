data work.sales;
	input Emp_ID $ Dept $ Sales Product_ID $;
DATALINES;
ET001 TSG 100 P001
ED001 DSG 120 P001
ET001 TSG 50 P002
EC001 CSG 230 P004
EQ001 QSG 150 P003
ET001 TSG 210 P004
ET001 TSG 40 P002
ET001 TSG 150 P003
;
run;
data work.product;
	infile datalines dsd;
	length Product_ID $4 Product_Name Description $35;
	input Product_ID $ Product_Name $ Description $;
	datalines;
p001,ManufacturingIndustry Solutions,ManufacturingIndustry Solutions V2
p002,Logistics Solutions,Logistics Solutions V1
p003,Financial Service Solutions,Financial Service Solutions V3
p004,Insurance Solutions,Insurance Solutions V2
;
run;

data work.sales_description(drop = ErrorDesc)
	work.exception;
	length Product_ID $8 Product_Name Description $35;
	if _N_ =1 then 
    /*执行DATA步的第一次循环时,创建hash对象,并加载数据到hash对象.*/
		do;
		declare hash product_desc(dataset:'work.product');
		product_desc.definekey('Product_ID');
		product_desc.definedata('Product_Name','Description');
		product_desc.definedone();
        /*call missing()消除日志中部分变量没有初始化的信息.*/
		call missing (Product_ID,Product_Name,Description);
	end;

	set work.sales;
	rc=product_desc.find();
    /*系统调用find()在Hash对象中检索数据.*/
    /*find()可以指定sales数据集中的KEY变量,当未指定任何KEY变量的死后
    系统默认Sales数据集的KEY变量和HASH对象的KEY变量同名.*/
    /*当系统 检索到HASH对象中存在的某个KEY值和PDV中KEY变量的值相等时,则返回代码rc的取值为0,
    同时将HASH对象中对应的DATA变量的值读入PDV中.*/
	if rc=0 then 
    /*系统判断rc=0,将PDV中的数据写入到数据集work.sales_description中.*/
		output sales_description;
	else	
		do;
			ErrorDesc='No Product Description';
			output exception;
		end;
	drop rc;
run;