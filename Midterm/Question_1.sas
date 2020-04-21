*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Kavit Shah                                          	  ;
* Comments       : Mid term, Problem 1 									  ;				   	  
*-------------------------------------------------------------------------;

/** Selecting the Directory of the Baseball.data**/

libname sasdata 'C:\Users\shahk\Desktop\BIA652\SAS_data';

proc copy in=sasdata out=work;
	select baseball;
run;

ODS PDF FILE='Midterm Question 1.pdf';
proc reg data=baseball  outest=baseball_est ;
     model    homeruns  = doubles strikeouts at_bats  /  dwProb   ;
      OUTPUT OUT=regout_homeruns  PREDICTED=predict   RESIDUAL=Res 
                      L95M=l95m  U95M=u95m  L95=l95 U95=u95
       rstudent=rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=s_predicted  STDR=s_residual  STUDENT=student     ;  
     
  quit;

  /**The model is good as we have a high R-Squared value and vwey low P-Value **/

data baseball2 alfonso;
set baseball;
if firstname='Alfonso' then output alfonso;
else output baseball2;
run;

proc reg data=baseball2 outest=RegOut;
   model homeruns=doubles strikeouts at_bats;
run;

proc score data=alfonso score=RegOut out=RScoreP type=parms;
   var homeruns doubles strikeouts at_bats ;
run;

proc score data=alfonso score=RegOut out=NewPred type=parms
           nostd predict;
   var homeruns doubles strikeouts at_bats;
run;

proc print data=NewPred;
run;

proc reg data = baseball plots= (dffits(label) cooksd(label) rstudentbypredicted(label));
	model homeruns=doubles strikeouts at_bats/r;
	OUTPUT OUT = baseball_out student = sresidents rstudent= h = Leverage cookd = cookd_dep dffits= dffits_dep;
	quit;
	run;
	ODS PDF CLOSE;
