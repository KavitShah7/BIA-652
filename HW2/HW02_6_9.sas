*-------------------------------------------------------------------------;
* Project        : BIA652  Mulivariate Analysis                           ;
* Developer(s)   : Kavit Shah 
* CWID			 : 10452991												  ;
* Comments       : Soluition to homework #2 a,b                           ;
*                  problem 6.9 of Afifi                                   ;
*-------------------------------------------------------------------------;
libname sasdata "C:\Users\shahk\Desktop\BIA652\SAS_data";
proc copy in=sasdata out=work;
   select depression ;
run;
proc reg data= depression;
model income = age ;
run;

*** regression analysis for depression dataset vars= income and age **;

** Prep the datasets **;
data income_age;
  keep id_temp age income marker;
  retain marker 'o';
 id_temp= 1000+_n_;
  set depression;
  
run;

data add_income_age;
  infile datalines;
  input id_temp age income Marker $;
datalines;
2001 42  120 A
2002 80  150 A
2003 180 15  A
;
run;

data income_age_all;
  set income_age 
      add_income_age;
run;

title " Simple Regression for the income and age with additional obs : Depression dataset ";
proc reg data=income_age_all  outest=income_age_est ;
     model     income  =  age   /   dwProb STB   ;
      OUTPUT OUT=regout_income_age  PREDICTED=predict   RESIDUAL=Res 
                      L95M=l95m  U95M=u95m  L95=l95 U95=u95
       rstudent=rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=s_predicted  STDR=s_residual  STUDENT=student     ;  
     
  quit;


