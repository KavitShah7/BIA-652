/*
Multivariate BIA652
Name: Kavit Shah
CWID: 10452991

*/


Libname sasdata "C:\Users\shahk\Desktop\BIA652\SAS_data";
proc copy in=sasdata out=work;
select lung;
run;

proc corr data= lung;
var FEV1_oldest_child Weight_oldest_child;
var FEV1_oldest_child Height_oldest_child;
var FVC_oldest_child Weight_oldest_child;
var FVC_oldest_child Height_oldest_child;
run;

proc reg data= lung;
model FEV1_oldest_child= Weight_oldest_child;
model FEV1_oldest_child= Height_oldest_child;
model FVC_oldest_child= Weight_oldest_child;
model FVC_oldest_child= Height_oldest_child;
run;
