/****************************************************************** 
• Name: Kavit Girish Shah
• Purpose: allocate libraries for the course.
• SAS Program: Problem_1 and Problem_2
• Date:11/05/2020 
• Description:Final_exam 
• Data Dependencies:  PCA_data 
 ******************************************************************/
libname sasdata "C:\Users\shahk\Desktop\BIA652\SAS_data";

ods pdf file = "Problem_1_2_Output.pdf" ;
proc copy in= sasdata out= work;
select pca_data;
run;
*Q1)•	Create an output dataset “out_PCA” containing the results of your PCA transformation for X1 to X6.;
 
title 'Principle Component analysis';
proc standard data= pca_data mean=0 std=1 out=pca;
var X1 - X6;
run; 
proc princomp data= pca out=out_PCA;
var X1 - X6;
run;


/*** Problem _2
1)	Selection=Stepwise. What is the final model? Is it a good model?
2)	Selection=MaxR. What is the best model for two predictors? Is that a good model? Why
*****/
proc reg data = out_PCA ;
model y = prin1-prin6     / selection = stepwise;
      OUTPUT OUT=regout_reg_lung  PREDICTED=predict   RESIDUAL=Res   
					L95M=C_195m  U95M=C_u95m  L95=C_195 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredict STDR=C_s_residual STUDENT=C_student;  
     
run; 
quit;
proc reg data = out_PCA ;
model y = prin1-prin6     / selection = MaxR;
      OUTPUT OUT=regout_reg_lung  PREDICTED=predict   RESIDUAL=Res   
					L95M=C_195m  U95M=C_u95m  L95=C_195 U95=C_u95
       rstudent=C_rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=C_spredict STDR=C_s_residual STUDENT=C_student;  
     
run; 
ods pdf close;
quit;
