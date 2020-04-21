*-------------------------------------------------------------------------;
* Project        :  BIA652  Mulivariate Analysis                          ;
* Developer(s)   : Kavit Shah                                          ;
* Comments       : Soluition to homework #3                               ;
*                  problem 7.2 of Afifi                                   ;
*-------------------------------------------------------------------------;

libname sasdata 'C:\Users\shahk\Desktop\BIA652\SAS_data';
ODS PDF FILE='HW03-7.2-Kavit_Shah.pdf';

proc copy in=sasdata out=work;
   select lung ;
run;
proc univariate data=lung normaltest plot;
   var  FVC_father  Age_father Height_father ;  
   
run;


title " Multiple Regression FVC_father vs. Age_Father Height_father : Lung dataset ";
proc reg data=lung  outest=lungest_FVC_f  ;
     model   FVC_father= Age_father Height_father   / VIF   dwProb STB   ;
      OUTPUT OUT=regout_lung_FVC_f  PREDICTED=predict   RESIDUAL=Res 
                      L95M=l95m  U95M=u95m  L95=l95 U95=u95
       rstudent=rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=s_predicted  STDR=s_residual  STUDENT=student     ;  
     
  quit;


proc univariate data=regout_lung_FVC_f  normaltest plot;
   var  Res rstudent  ;  
   
run;

title " Multiple Regression FVC_father vs. Age_Father Height_father : Lung dataset ";
proc reg data=lung  outest=lungest_FVC_f  ;
     model   FEV1_father= Weight_father Height_father   / VIF   dwProb STB   ;
      OUTPUT OUT=regout_lung_FVC_f  PREDICTED=predict   RESIDUAL=Res 
                      L95M=l95m  U95M=u95m  L95=l95 U95=u95
       rstudent=rstudent h=lev cookd=Cookd  dffits=dffit
     STDP=s_predicted  STDR=s_residual  STUDENT=student     ;  
     
  quit;
ods pdf close;
