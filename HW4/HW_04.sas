*------------------------------------------------------------------------;
* Project        : BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Kavit Shah	                 ;
* Comments       : HW_04, Q = 8.11, 8.12, 8.13                           ;
*------------------------------------------------------------------------;

libname source 'C:\Users\shahk\Desktop\BIA652\SAS_data';
proc copy in=lungdata out=work;
	select lung;
run;
ods pdf file ="output_8.11, 8.12, 8.13.pdf";

* Q 8.11 Using the methods described in this chapter and the family lung function
data described in Appendix A, and choosing from among the variables
OCAGE, OCWEIGHT, MHEIGHT, MWEIGHT, FHEIGHT, and
FWEIGHT, select the variables that best predict height in the oldest child.
Show your analysis.*;


* Selecting the variable that most predicts the height of the oldest child we use Stepwise selection to find out the best variable;
title "Stepwise selection";
proc reg data=lung outest= est_lung;
model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother Height_father Weight_father/ dwprob selection=stepwise;
run;
quit;

* Regression Analysis of Height_oldest_child vs Age_oldest_child as Age_oldest_child has best predict height in the oldest child;
title " Regression Analysis of age of oldest child";
proc reg data=lung ;
ods graphics on;
model Height_oldest_child =  Age_oldest_child;
run;
ods graphics off;
quit;

*Q 8.12 From among the candidate variables given in Problem 8.11, find the subset
of three variables that best predicts height in the oldest child, separately for
boys and girls. Are the two sets the same? Find the best subset of three
variables for the group as a whole. Does adding OCSEX into the regression
equation improve the fit?*

* Selecting the variable that most predicts the height of the oldest child by gender.
We use Stepwise selection to find out the best variable and select a subset of
three best variables;
* Sort the data by sex of the oldest child;

proc sort data=lung;
by Sex_oldest_child;
run;

* Forward Selection;
title " forward ";
proc reg data=lung ;
by Sex_oldest_child;
model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_mother Weight_mother Height_father Weight_father/  selection=forward;
run;
quit;

* We selected the three variables Age_oldest_child Weight_oldest_child Height_father to be the best predictors;
title " Multiple linear Regression for predicting Height_oldest_child by taking Age_oldest_child Weight_oldest_child Height_father ";
proc reg data=lung;
by Sex_oldest_child;
model Height_oldest_child = Age_oldest_child Weight_oldest_child Height_father / dwprob vif ;
run;
quit;

 * Creating a dummy variable called Male_or_female which contains the value of:
  1 - Male
  0 - Female ;

 data lung_data2;
 set lung;
 if Sex_oldest_child=1 then Male_or_female=1;
 else Male_or_female=0;
 drop Sex_oldest_child;
 run;

* We selected the three variables Age_oldest_child Weight_oldest_child Height_father to be the best predictors;
title " Adding Sex of oldest child ";
proc reg data=lung_data2;
model Height_oldest_child = Male_or_female Age_oldest_child Weight_oldest_child Height_father / dwprob vif ;
run;
quit;

*Q 8.13*; 
libname parhiv 'C:\Users\shahk\Desktop\BIA652\SAS_data';
proc copy in=parhiv out=work;
	select parhiv;
run;

proc reg data=parhiv;
	model AGEALC = AGESMOKE AGEMAR NGHB11 / SS1 SS2 STB DWPROB VIF selection = stepwise;
	output  out=parhiv predicted= c_predict RESIDUAL=c_res
	L95M=c_l95m U95m=c_u95m L95=c_u95 h=lev cookd=dist dffits=c_dffits;
quit;
run;
ods pdf close;
