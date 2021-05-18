data donations;
	infile 'D:\ShareSAS\Data\github\SAS-Learning\file\Donations.dat' truncover;
	input id 1-4 first $ 6-19 last $ 20-33 address $ 34-58 city $ 59-88 zip $ 94-98
		amount 101-105 month 106-107;
run;

data donations_fill;
	set donations;

	retain _first_last_adress_city_zip;
	if not missing(first) then _first=first;
	if not missing(last) then _last=last;
	if not missing(adress) then _adress=adress;
	if not missing(city) then _city=city;
	if not missing(zip) then _zip=zip;

	first=_first;
	last=_last;
	address=_adress;
	city=_city;
	zip=_zip;

	drop _:;
run;

data _null_;
	set donations _summary;
	by id;

	if month=1 then monthtext='Jan';
	else if month=2 then monthtext='Feb';
	ELSE IF month = 3 THEN monthtext = "Mar";
	ELSE IF month = 4 THEN monthtext = "Apr";
	ELSE IF month = 5 THEN monthtext = "May";
	ELSE IF month = 6 THEN monthtext = "Jun";
	ELSE IF month = 7 THEN monthtext = "Jul";
	ELSE IF month = 8 THEN monthtext = "Aug";
	ELSE IF month = 9 THEN monthtext = "Sep";
	ELSE IF month = 10 THEN monthtext = "Oct";
	ELSE IF month = 11 THEN monthtext = "Nov";
	ELSE IF month = 12 THEN monthtext = "Dec";
	ELSE monthtext = "Unknown";

	format amount DOLLAR8.2;
	FILE 




