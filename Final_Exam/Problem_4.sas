/* 
   First Name: Kavit
   Last Name:  Shah
   Student ID: 10452991
   Course:     BIA 652 Multivariate Data Analysis
   FInal_Exam_new

•	Hierarchical(method=average) clustering methodology
•	k-means  clustering methodology

*/
/*Importing the data*/
libname sasdata 'C:\Users\shahk\Desktop\BIA652\SAS_data';
ods pdf file="Problem_4.pdf"; /* Adobe PDF format */

proc copy in=sasdata out=work;
   select admission;
run;

*  Hierarchical clustering methodology;
proc cluster data = admission outtree = Tree method = AVERAGE;
var gre gpa;
run;

proc tree data = Tree noprint ncl=2 out=H_cluster;
run;

* k-means  clustering methodology;
proc fastclus data=admission out=k_meanscluster maxclusters=2 ;
var gre gpa;
run;

ods pdf close;
