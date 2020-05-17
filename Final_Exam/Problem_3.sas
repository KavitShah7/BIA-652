/* 
   First Name: Kavit
   Last Name:  Shah
   Student ID: 10452991
   Course:     BIA 652 Multivariate Data Analysis
   Assignment: HW_final
*/

/*
•	Establish a logistic regression model to predict admission (admit=1) using rank as a predictor. 
	Using rank=1 as your base answer the following questions:
•	Is this a good model?

Assuming the model is a good model
•	What are the odds of admission for rank=1
•	What is the P(admit=1/rank=1)
•	What is P(admit=1/rank=2)
•	What is the odds ratio of rank=2 over rank=1?

*/

ods pdf file="Problem_3.pdf"; /* Adobe PDF format */

libname sasdata "C:\Users\shahk\Desktop\BIA652\SAS_data";

proc copy in=sasdata out=work;
  select admission;
run;

proc logistic data=admission descending  ;
  		class rank(ref='1')/ param = ref;
		model ADMIT=RANK  /outroc=roc1;
		output out=Out_admission perdicted=Prob;
run;

data classificagtion;
  set Out_admission;
  if  Prob>= 0.50 then event='1' ;
  else event='0';
run;

proc freq data=classificagtion ;
  table ADMIT*event;
run;


* Yes, this is a good model as we have a acceptable accuracy rate (69.50%). ROC rate is acceptable (64.41%). 

* What are the odds of admission for rank=1

* Logit = 0.1643 - 0.75 * RANK_2 - 1.3647 * RANK_3 - 1.6867 * RANK_4;
* Logit = 0.1643 - 0.75 * 0 - 1.3647 * 0 - 1.6867 * 0;
* Logit = 0.1643
* EXP(0.1643) = 1.178567832 <- answer

* What is the P(admit=1/rank=1)

	int			RANK	RANK		RANK		g(x)		odds			P
1	0.1643		0		0			0			0.1643		1.178567832		0.540982849 <- answer
2	0.1643		-0.75	0			0			-0.5857		0.556716024		0.357622081
3	0.1643		0		-1.3647		0			-1.2004		0.301073758		0.231404066
4	0.1643		0		0			-1.6867		-1.5224		0.218187608		0.179108379

* What is P(admit=1/rank=2)

	int			RANK	RANK		RANK		g(x)		odds			P
1	0.1643		0		0			0			0.1643		1.178567832		0.540982849 
2	0.1643		-0.75	0			0			-0.5857		0.556716024		0.357622081 <- answer
3	0.1643		0		-1.3647		0			-1.2004		0.301073758		0.231404066
4	0.1643		0		0			-1.6867		-1.5224		0.218187608		0.179108379

* What is the odds ratio of rank=2 over rank=1?

0.556716024 / 1.178567832 = 0.472366553;

ods pdf close;
