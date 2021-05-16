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
/*?????,??????????????,INPUT??????????????;
  ?TRUNCOVER?,????,??????????????*/

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
		
	/*SUBSTR()??: 
	??: SUBSTR(matrix, position <, length> ); 	
		???business_phone,??2?????3??
		? (650)484-3147??650*/
    if length(business_phone) = 13 then area_code = substr(business_phone,2,3);
    else if length(home_phone) = 13 then area_code= substr(home_phone,2,3);
    else if length(mobile_phone) = 13 then area_code= substr(mobile_phone,2,3);
    else area_code = 'None';

	/*findw()??:FINDW(string, word<, chars>)  ??word?string?????	*/
    if findw(upcase(dietary_restrictions),'WEGAN') then vegan_veg_meal=1;
    else if findw(upcase(dietary_restrictions),'WEGETARIAN')  then vegan_veg_meal = 1 ;
    else vegan_veg_meal =0;

    array type registration_rate;   *??????,????type,registration_rate???;


/*DO <key>, <var> OVER <value>; 
...more CASL statements ...;

END; */

    do over type;  *type ???;
	/*do over :  Iterates over an array, dictionary, or table
	????,?????*/
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
/*??? attendee_id?1082,1083???*/
where attendee_id IN (1082,1083);
run;

/*SUBSTR(matrix, position <, length> ); 
The SUBSTR function takes a character matrix as an argument 
(along with starting positions and lengths) and produces a character matrix
with the same dimensions as the argument. 
Elements of the result matrix are substrings of the corresponding argument elements. 
*/



	
