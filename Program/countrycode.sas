data info;
	City='shanghai';
	Country='China';
	CountryCode=86;
	CityCode=21;
run;
proc print data=info;
run;

/**********************************************
                                Country    City
 Obs      City      Country      Code     Code

  1     shanghai     China        86       21

************************************************/
