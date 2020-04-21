/**********
Name:Kavit Shah
CWID:10452991
Purpose: Midterm Question-4
Program Dependencies: _libname.sas
Data Dependencies: calif.sas
************/
libname source "C:\Users\shahk\Desktop\BIA652\SAS_data";
run;
proc copy in=source out=work;
	select calif;
run;
data calif_subset;
	set calif;
	Log_population=log(population);
	Log_pct_over=log(pct_over);
run;
ODS PDF FILE='MidtermQuestion04_output.pdf';
/****** Regression model for pct_over on population****/
proc univariate data=calif_subset normal plot;
	var pct_over population ;
run;
proc reg data=calif_subset;
	title "Regression of pct_over on population";
	model pct_over=population / r;
	output out=output_l h=lev cookd=Cookd dffits=dffit;
run;
/****** Regression model for pct_over on Log_population****/
proc univariate data=calif_subset normal plot;
	var pct_over Log_population ;
run;
proc reg data=calif_subset;
	title "Regression of pct_over Log_population";
	model pct_over=Log_population / r;
	output out=output_l h=lev cookd=Cookd dffits=dffit;
run;
/****** Regression model for Log_pct_over on Log_population****/
proc univariate data=calif_subset normal plot;
	var Log_pct_over Log_population ;
run;
proc reg data=calif_subset;
	title "Regression of Log_pct_over on Log_population";
	model Log_pct_over=Log_population / r;
	output out=output_l h=lev cookd=Cookd dffits=dffit;
run;
quit;
ODS PDF close;

