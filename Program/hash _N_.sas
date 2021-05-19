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
    /*ִ��DATA���ĵ�һ��ѭ��ʱ,����hash����,���������ݵ�hash����.*/
		do;
		declare hash product_desc(dataset:'work.product');
		product_desc.definekey('Product_ID');
		product_desc.definedata('Product_Name','Description');
		product_desc.definedone();
        /*call missing()������־�в��ֱ���û�г�ʼ������Ϣ.*/
		call missing (Product_ID,Product_Name,Description);
	end;

	set work.sales;
	rc=product_desc.find();
    /*ϵͳ����find()��Hash�����м�������.*/
    /*find()����ָ��sales���ݼ��е�KEY����,��δָ���κ�KEY����������
    ϵͳĬ��Sales���ݼ���KEY������HASH�����KEY����ͬ��.*/
    /*��ϵͳ ������HASH�����д��ڵ�ĳ��KEYֵ��PDV��KEY������ֵ���ʱ,�򷵻ش���rc��ȡֵΪ0,
    ͬʱ��HASH�����ж�Ӧ��DATA������ֵ����PDV��.*/
	if rc=0 then 
    /*ϵͳ�ж�rc=0,��PDV�е�����д�뵽���ݼ�work.sales_description��.*/
		output sales_description;
	else	
		do;
			ErrorDesc='No Product Description';
			output exception;
		end;
	drop rc;
run;