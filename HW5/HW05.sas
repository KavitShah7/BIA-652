/****************************************************************** 
• Name: Kavit Shah
• Purpose: Understanding and implementing Binary Logisitic Regression model
• SAS Program: HW_05 
• Dependencies: _libname.sas   
******************************************************************/

libname sasdata 'C:\Users\shahk\Desktop\BIA652\SAS_data';
/*Importing the data*/
proc copy in=sasdata out=work;
select parhiv;
run;

proc contents data=parhiv;
run;

proc freq data=parhiv;
	table hookey;
run;

proc logistic data=parhiv desc;
	model hookey = age gender livwith siblings jobmo edumo howrel attserv NGHB1-NGHB11 monfood finsit ethn agesmoke smokep3m agealc
				   agemar frnds school likesch hmonth PB01-PB25 BSI01-BSI53;

run;
quit;

proc means data=parhiv;
run;
/*Logistic model*/
proc logistic data=parhiv outest=out_parhiv_log;
	class gender livwith siblings jobmo edumo howrel attserv monfood finsit ethn frnds school smokep3m nghb1 nghb2 nghb3 nghb4 nghb5 nghb6 nghb7
		nghb8 nghb9 nghb10 nghb11 likesch PB01-PB25 BSI01-BSI53;
	model hookey= age gender livwith siblings jobmo edumo howrel attserv monfood finsit ethn frnds school smokep3m nghb1 nghb2 nghb3 nghb4 nghb5 nghb6 nghb7
		nghb8 nghb9 nghb10 nghb11 likesch PB01-PB25 BSI01-BSI53 / selection=stepwise;
	output out=pred p=phat lower=lcl upper=ucl;
run;


title "Logisitic Regression for the Parhiv2 dataset  ";

proc logistic data=Parhiv desc plots(only)=roc;
  class GENDER LIVWITH SIBLINGS JOBMO
          EDUMO HOWREL ATTSERV NGHB1-NGHB11 MONFOOD FINSIT
          ETHN SMOKEP3M FRNDS
          LIKESCH HMONTH PB01-PB25  BSI01-BSI53;

  model  HOOKEY= AGE GENDER LIVWITH SIBLINGS JOBMO
          EDUMO HOWREL ATTSERV  NGHB1-NGHB11 MONFOOD FINSIT
          ETHN AGESMOKE SMOKEP3M AGEALC AGEMAR FRNDS
          LIKESCH NHOOKEY HMONTH 
PB01-PB25  BSI01-BSI53 /  selection=backward slentry=0.10 slstay=0.10 lackfit ctable;

run;
quit;


/*
The test in the program is for logistic regression, In this test I have used the backward selection model to eliminate 
the variables that do not correlate to explaining whether an absence has happened with or without a reason. 
However, before using this process I have applied a data cleaning procedure where I have eliminated all the individuals
who do not attend school, this is done based on the logic that if an individual does not attend school then we do not
need variables to predict whether they will have a reason or not for their absence. The selection test then uses the 
wald statistics to eliminate the variable and the final variables that allow us to make a prediction are AGE,AGEMAR and AGEALC
these variables provide us a significance of <0.001 and they have a positive and direct relation with the dependent variable 
HOOKEY. I then ran a goodness of fit by adding the parameter likefit. Looking at the Association of Predicted Probabilities and Observed Responses table, we can see that the C-test value which is a measure of fitness of a model is 0.873 which ensures goodness of fit. Any value over 0.5 and closer to 1.0 is a good messure of a fit model.
If we use slentry=.05 slstay=.05, the c-test value turns out to be 0.894. 
*/

/*AGE AGEMAR PB13 PB24 PB20 AGEALC*/

proc logistic data=parhiv;
model hookey=AGE AGEMAR AGEALC/ ctable;
run;
ods graphics on;
proc logistic data=parhiv desc plots(only)=roc;
model hookey=AGE AGEMAR AGEALC;
run;
quit;
proc logistic data=parhiv desc plots(only)=roc;
model hookey=AGE AGEMAR AGEALC/outroc=rocdata;
run;
proc gplot data=rocdata;
plot _sensit_*_1mspec_;
run;
quit;
/*
Youden's index is used to select the optimal predicted probability cut-off. It is the maximum vertical distance between ROC curve and diagonal line.
In other words, Youden's index is nothing but the maximum value of (Sensitivity+Specificity) which comes up to 158.3 for Sensitivity = 83.3 and Specificity = 75 which corresponds to prob level of 0.380 as can be seen from the Classification Table
Therefore, 0.380 should be the appropriate cutoff to discriminate between adolescents who were absent with or without a reason.
*/
 
