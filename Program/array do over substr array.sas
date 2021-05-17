data conference;
    infile 'D:\ShareSAS\Data\github\SAS-Learning\file\Conference.dat' truncover;
/*
	overrides the defaultbehavior of the INPUT statement
	when an input data record is shorter than the INPUT statement expects.
	By default, the INPUT statement automatically 
	reads the next input data record. TRUNCOVER enables you to read 
	variable-length records when some records are shorterthan 
	the INPUT statement expects. Variables without any values assignedare set to missing. 
*/
/*默认情况下，当遇到的记录长度比预期长度短时，input会跳过这个记录，;
  选项TRUNCOVER使得SAS可以读取小于预期长度的记录。*/

    input
        first_name $
        last_name $
        attendee_id
        bsiness_phone $ 47-59
        home_phone $ 61-73
        mobile_phone $ 75-87
        ok_business $
        ok_home $
        ok_mobile $
        registration_rate
        wednesday_mixer $
        thursday_lunch $
        will_volunteer $
        dietary_restrictions $ 117-150
        ;
		
	/*SUBSTR( )截取字段: 
	语法: SUBSTR(matrix, position <, length> ); 	
		从变量business_phone,从第2位开始截取3位长度。
		(650)484-3147截取后得到650*/
    if length(business_phone) = 13 then area_code = substr(business_phone,2,3);
    else if length(home_phone) = 13 then area_code= substr(home_phone,2,3);
    else if length(mobile_phone) = 13 then area_code= substr(mobile_phone,2,3);
    else area_code = 'None';

	/*findw()  语法:FINDW(string, word<, chars>)  返回word在string中的character position位置	*/
    if findw(upcase(dietary_restrictions),'WEGAN') then vegan_veg_meal=1;
    else if findw(upcase(dietary_restrictions),'WEGETARIAN')  then vegan_veg_meal = 1 ;
    else vegan_veg_meal =0;

    array type registration_rate;   *数组,数组名：type,registration_rate为数组变量;


/*DO <key>, <var> OVER <value>; 
...more CASL statements ...;

END; */

    do over type;  *type 数组名;
	/*do over :  Iterates over an array, dictionary, or table
	遍历数组*/
        if registration_rate= 350 then attendee_type='Academic Regular';
        else if registration_rate = 200 then attendee_type='Student Regular';
        else if registration_rate = 450 then attendee_type='Regular';
        ELSE IF registration_rate = 295 THEN attendee_type = "Academic Early";
        ELSE IF registration_rate = 150 THEN attendee_type = "Student Early";
        ELSE IF registration_rate = 395 THEN attendee_type = "Early";
        ELSE IF registration_rate = 550 THEN attendee_type = "On-Site";
        ELSE attendee_type = "Unknown";
    END;
run;

proc print data=conference;
/*只打印 attendee_id为1082,1083的记录*/
where attendee_id IN (1082,1083);
run;

/*SUBSTR(matrix, position <, length> ); 
The SUBSTR function takes a character matrix as an argument 
(along with starting positions and lengths) and produces a character matrix
with the same dimensions as the argument. 
Elements of the result matrix are substrings of the corresponding argument elements. 
*/



	
