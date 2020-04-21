/************
Name: Kavit Shah
CWID:10452991
Purpose:Midterm Question 4
Program Dependencies: _libname.sas
Data Dependencies: cereal.sas
**************/
libname source "C:\Users\shahk\Desktop\BIA652\SAS_data";
run;
proc copy in=source out=work;
	select cereal_ds;
run;
ODS PDF FILE='MidtermQuestion03_Output.pdf';
title"Scatter Plot for rating of a cereal and the number of calories present in it";
/**** Scatter Plot for Rating and Calories****/
proc sgplot data=cereal_ds;
	scatter x=rating y=calories/;
run;
title;
title"Scatter Plot for rating of a cereal and shelf";
/****** Scatter Plot for Rating and Shelf******/
proc sgplot data=cereal_ds;
	scatter x=rating y=shelf/;
run;
title;
/***** Creating a variable shelf2******/
data cereal;
	set cereal_ds;
	if shelf=2 then shelf2=1;
	else shelf2=0;
run;
proc standard data=cereal mean=0 std=1
	out=stnd_cereals;
	var rating shelf shelf2;
run;
/********* Regression Model********/
proc reg data=stnd_cereals outest=cereal_est;
	model rating=shelf shelf2/r;
	output out=reg_cereal predicted=predict residual=res
	L95M=l95m U95M=u_95m L95=l95 U95=u95
	h=lev cookd=Cookd dffits=dffit
	STDP=spredict;
run;
quit;
/**** To compare results without the variable shelf2******/
proc standard data=cereal_ds mean =0 std=1
	out=stnd_cereals;
	var rating shelf;
run;
proc reg data=cereal_ds outest=cereal_es;
	model rating=shelf/r;
	output out=reg_cerealds predicted=predict residual=res
	L95M=l95m U95M=u_95m L95=l95 U95=u95
	h=lev cookd=Cookd dffits=dffit
	STDP=spredict;
run;
quit;

ODS PDF close;
