/****************************************************************** 
• Name:Kavit Shah
• Purpose: To implement regression models and analyzing residuals using given problems in SAS
• SAS Program: HW03 
• Description:
• Dependencies: _libname.sas
• Data Dependencies:   
 ******************************************************************/
/*Problem 7.5*/
libname sasdata 'C:\Users\shahk\Desktop\BIA652\SAS_data';
ODS PDF FILE='HW03-7.5-Kavit_Shah.pdf';
proc copy in=sasdata out=work;
	select  depression;
	run;
proc reg data=depression ;
     model cat_total = age income sex / dwProb; 
     OUTPUT OUT=depress  PREDICTED= pred  RESIDUAL= r   L95M=u  U95M=m  L95=l U95=u9
     rstudent=rr h=lev cookd=cookds  dffits=dff STDP = st STDR=std STUDENT=stu ;
proc univariate noprint;
	QQPLOT r / normal;
	run;
ODS PDF CLOSE;
