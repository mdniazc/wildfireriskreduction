use "C:\Users\16056\OneDrive\Desktop\Resource Economics-Research\Stata  Resource Economics\testdataset_thesis.dta" 


******************************************************************
*********************************************************************
/* WTP analysis*/
/* generate binary bid variables for community and priavte program */



tab1 pribid1 pribid2 pribid3 pribid4 pribid5 pribid6
tab1 pubbid1 pubbid2 pubbid3 pubbid4 pubbid5 pubbid6

tab1 prv_1 prv_2 prv_3 prv_4 prv_5 prv_6
tab1 pub_1 pub_2 pub_3 pub_4 pub_5 pub_6

* would you like to spend $100 if you were sure it would reduce fire risk from 6% to 2%

gen prvbid1 = prv_1
recode prvbid1 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid1 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid1= . 
replace privatebid1 = 1 if prvbid1 == 75 | prvbid1== 100 
replace privatebid1 = 0 if  prvbid1== 0 | prvbid1== 25 | prvbid1== 50


* would you like to spend $400 if you were sure it would reduce fire risk from 6% to 2%

gen prvbid2 = prv_2
recode prvbid2 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid2 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid2= . 
replace privatebid2 = 1 if prvbid2 == 75 | prvbid2== 100 
replace privatebid2 = 0 if  prvbid2== 0 | prvbid2== 25 | prvbid2== 50


gen prvbid3 = prv_3
recode prvbid3 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid3 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid3= . 
replace privatebid3 = 1 if prvbid3 == 75 | prvbid3== 100 
replace privatebid3 = 0 if  prvbid3== 0 | prvbid3== 25 | prvbid3== 50



gen prvbid4 = prv_4
recode prvbid4 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid4 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid4= . 
replace privatebid4 = 1 if prvbid4 == 75 | prvbid4== 100 
replace privatebid4 = 0 if  prvbid4== 0 | prvbid4== 25 | prvbid4== 50


gen prvbid5 = prv_5
recode prvbid5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid5 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid5= . 
replace privatebid5 = 1 if prvbid5 == 75 | prvbid5== 100 
replace privatebid5 = 0 if  prvbid5== 0 | prvbid5== 25 | prvbid5== 50


gen prvbid6 = prv_6
recode prvbid6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid6 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid6= . 
replace privatebid6 = 1 if prvbid6 == 75 | prvbid6== 100 
replace privatebid6 = 0 if  prvbid6== 0 | prvbid6== 25 | prvbid6== 50




tabulate privatebid1  pribid1, column nofreq
probit privatebid1  pribid1
nlcom (WTP:-_b[_cons]/_b[pribid1]), noheader
probit privatebid3  pribid3
nlcom (WTP:-_b[_cons]/_b[pribid3]), noheader

/* generate varibles for community program*/
********************************************************************
*********************************************************************


*************************************************************************************


gen publbid1 = pub_1
recode publbid1 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid1 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid1= . 
replace publicbid1 = 1 if publbid1== 75 | publbid1== 100 
replace publicbid1 = 0 if  publbid1== 0 | publbid1== 25 | publbid1== 50



gen publbid2 = pub_2
recode publbid2 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid2 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid2= . 
replace publicbid2 = 1 if publbid2== 75 | publbid2== 100 
replace publicbid2 = 0 if  publbid2== 0 | publbid2== 25 | publbid2== 50


gen publbid3 = pub_3
recode publbid3 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid3 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid3= . 
replace publicbid3 = 1 if publbid3== 75 | publbid3== 100 
replace publicbid3 = 0 if  publbid3== 0 | publbid3== 25 | publbid3== 50



gen publbid4 = pub_4
recode publbid4 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid4 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid4= . 
replace publicbid4 = 1 if publbid4== 75 | publbid4== 100 
replace publicbid4 = 0 if  publbid4== 0 | publbid4== 25 | publbid4== 50


gen publbid5 = pub_5
recode publbid5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid5 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid5= . 
replace publicbid5 = 1 if publbid5== 75 | publbid5== 100 
replace publicbid5 = 0 if  publbid5== 0 | publbid5== 25 | publbid5== 50


gen publbid6 = pub_6
recode publbid6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define publbid6 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen publicbid6= . 
replace publicbid6 = 1 if publbid5== 75 | publbid5== 100 
replace publicbid6 = 0 if  publbid6== 0 | publbid6== 25 | publbid6== 50



* Maximam Likelihood to estimate WTP 
*cleaning the data set with missing value, *************************



*Data cleaning  for missing values ****


sum privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

list privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

mdesc privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

egen nmis=rmiss (privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6)

mvpatterns privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

misschk privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6, gen (miss)



list prvbid1 prvbid2 prvbid3 prvbid4 prvbid5 prvbid6

mdesc prvbid1 prvbid2 prvbid3 prvbid4 prvbid5 prvbid6

egen nmis1=rmiss (prvbid1 prvbid2 prvbid3 prvbid4 prvbid5 prvbid6)

mvpatterns prvbid1 prvbid2 prvbid3 prvbid4 prvbid5 prvbid6

misschk prvbid1 prvbid2 prvbid3 prvbid4 prvbid5 prvbid6, gen (miss1) 

WTP  variables *
*******************************



/* generate varibles using YES NO response for private bid*/

gen pvid6=privatebid6*100000
gen pvid5=privatebid5*10000
gen pvid4=privatebid4*1000
gen pvid3=privatebid3*100
gen pvid2=privatebid2*10
gen pvid1=privatebid1*1


gen combinepvid= (pvid1+pvid2+pvid3+pvid4+pvid5+pvid6)

tab1 combinepvid


recode combinepvid (0=1) (1=2) (11=3) (111=4) (1111=5) (11111=6) (111111=7), gen (depvar)

gen depvar1 = . 
replace depvar1 = 1 if depvar==1 /* No */ 
replace depvar1 = 2 if depvar==2 /* Yes, No No No No No */
replace depvar1 = 3 if depvar==3  /* Yes, Yes, No No No No */
replace depvar1 = 4 if depvar==4  /* Yes, Yes, Yes No No No */
replace depvar1 = 5 if depvar==5   /* Yes, Yes, Yes Yes No No */
replace depvar1 = 6 if depvar==6    /* Yes, Yes, Yes Yes Yes No */
replace depvar1 = 7 if depvar==7     /* Yes, Yes, Yes Yes Yes yes */


tab2 pribid1 privatebid1 loss, row col taub
tab2 pribid1 privatebid1 loss, row col taub



/* Yes NO response variables generation end */

/* Final code for reponse varibles for private program*/

generate response1=.
replace response1=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 | depvar1==7
replace response1=0 if depvar1==1

generate response2=.
replace response2=1 if depvar1==7
replace response2=0 if depvar1==1 | depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 



order privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6 combinepvid depvar



/* Final Code for bid1 and bid2 variables for private bid*/

gen bid1=.
replace bid1=pribid1 if response1==1 & depvar1==1
replace bid1=pribid1 if response1==0 & depvar1==1
replace bid1=pribid1 if response1==1 & depvar1==2
replace bid1=pribid1 if response1==0 & depvar1==2
replace bid1=pribid2 if response1==1 & depvar1==3
replace bid1=pribid2 if response1==0 & depvar1==3
replace bid1=pribid3 if response1==1 & depvar1==4
replace bid1=pribid3 if response1==0 & depvar1==4
replace bid1=pribid4 if response1==1 & depvar1==5
replace bid1=pribid4 if response1==0 & depvar1==5
replace bid1=pribid5 if response1==1 & depvar1==6
replace bid1=pribid5 if response1==0 & depvar1==6
replace bid1=pribid5 if response1==1 & depvar1==7

gen bid1N=bid1
replace bid2=0 if response1==0 & response2==0

order bid1 bid2 response1 response2


gen bid2N=.
replace bid2N=pribid1 if response1==1 & depvar1==1
replace bid2N=pribid1 if response1==0 & depvar1==1
replace bid2N=pribid2 if response1==1 & depvar1==2
replace bid2N=pribid2 if response1==0 & depvar1==2
replace bid2N=pribid3 if response1==1 & depvar1==3
replace bid2N=pribid3 if response1==0 & depvar1==3
replace bid2N=pribid4 if response1==1 & depvar1==4
replace bid2N=pribid4 if response1==0 & depvar1==4
replace bid2N=pribid5 if response1==1 & depvar1==5
replace bid2N=pribid5 if response1==0 & depvar1==5
replace bid2N=pribid6 if response1==1 & depvar1==6
replace bid2N=pribid6 if response1==0 & depvar1==6
replace bid2N=pribid6 if response1==1 & depvar1==7


gen bid2=bid2N
replace bid2=0 if response1==0 & response2==0



gen bid4N=.
replace bid4N=pribid2 if response1==0 & depvar1==1
replace bid4N=pribid2 if response1==0 & depvar1==1
replace bid4N=pribid2 if response1==1 & depvar1==2
replace bid4N=pribid2 if response1==0 & depvar1==2
replace bid4N=pribid3 if response1==1 & depvar1==3
replace bid4N=pribid3 if response1==0 & depvar1==3
replace bid4N=pribid4 if response1==1 & depvar1==4
replace bid4N=pribid4 if response1==0 & depvar1==4
replace bid4N=pribid5 if response1==1 & depvar1==5
replace bid4N=pribid5 if response1==0 & depvar1==5
replace bid4N=pribid6 if response1==1 & depvar1==6
replace bid4N=pribid6 if response1==0 & depvar1==6
replace bid4N=pribid6 if response1==1 & depvar1==7




/*WTP estimates using doubleb command*/


doubleb bid1 bid2 response1 response2
doubleb bid1 bid2 response1 response2 riskreduction


/* Create New Varibales for who said no for private program */ 

gen pribid0=0

gen prvbid0 = fx_prv_5
recode prvbid0 (0=0) (1=25) (2=50) (3=75) (4=100)
label define prvbid0 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen privatebid0= . 
replace privatebid0 = 1 if prvbid0 == 75 | prvbid0== 100 
replace privatebid0 = 0 if  prvbid0== 0 | prvbid0== 25 | prvbid0== 50


gen privatebid00= . 
replace privatebid00 = 0 if prvbid0 == 75 | prvbid0== 100 
replace privatebid00 = 1 if  prvbid0== 0 | prvbid0== 25 | prvbid0== 50


gen npvid6=privatebid6*1000000
gen npvid5=privatebid5*100000
gen npvid4=privatebid4*10000
gen npvid3=privatebid3*1000
gen npvid2=privatebid2*100
gen npvid1=privatebid1*10
gen npvid0=privatebid0*1


gen combinepvidN= (npvid0+npvid1+npvid2+npvid3+npvid4+npvid5+npvid6)

tab1 combinepvidN

recode combinepvidN (0=1) (1=2) (11=3) (10=3) (111=4) (110=4) (1111=5) (1110=5) (11111=6) (11110=6) (111110=7) (1111111=8) (1111110=8), gen (depvar3)


gen depvar4 = . 
replace depvar4 = 1 if depvar3==1 /* No No */ 
replace depvar4 = 2 if depvar3==2 /* Yes, No  */
replace depvar4 = 3 if depvar3==3  /* Yes, Yes, No  */
replace depvar4 = 4 if depvar3==4  /* Yes, Yes, Yes No  */
replace depvar4 = 5 if depvar3==5   /* Yes, Yes, Yes Yes No */
replace depvar4 = 6 if depvar3==6    /* Yes, Yes, Yes Yes Yes No */
replace depvar4 = 7 if depvar3==7     /* Yes, Yes, Yes Yes Yes yes no */
replace depvar4 = 8 if depvar3==8    /*  Yes, Yes, Yes Yes Yes yes yes*/

tab1 depvar4


/* Yes NO response variables generation end */

/* Final code for reponse varibles for private program*/

generate response5=.
replace response5=1 if depvar4==2| depvar4==3 | depvar4==4 | depvar4==5 | depvar4==6 | depvar4==7 | depvar4==8
replace response5=0 if depvar4==1

generate response6=.
replace response6=1 if depvar4==8
replace response6=0 if depvar4==1 | depvar4==2| depvar4==3 | depvar4==4 | depvar4==5 | depvar4==6 | depvar4==7




/* Final Code for bid1 and bid2 variables for private bid*/

gen bid5=.
replace bid5=pribid0 if response5==1 & depvar4==1
replace bid5=pribid0 if response5==0 & depvar4==1
replace bid5=pribid0 if response5==1 & depvar4==2
replace bid5=pribid0 if response5==0 & depvar4==2
replace bid5=pribid1 if response5==1 & depvar4==3
replace bid5=pribid1 if response5==0 & depvar4==3
replace bid5=pribid2 if response5==1 & depvar4==4
replace bid5=pribid2 if response5==0 & depvar4==4
replace bid5=pribid3 if response5==1 & depvar4==5
replace bid5=pribid3 if response5==0 & depvar4==5
replace bid5=pribid4 if response5==1 & depvar4==6
replace bid5=pribid4 if response5==0 & depvar4==6
replace bid5=pribid5 if response5==1 & depvar4==7
replace bid5=pribid5 if response5==0 & depvar4==7
replace bid5=pribid5 if response5==1 & depvar4==8


gen bid5N=bid5
replace bid5N=10 if response5==0 & response6==0

gen bid6=.
replace bid6=pribid0 if response5==1 & depvar4==1
replace bid6=pribid0 if response5==0 & depvar4==1
replace bid6=pribid1 if response5==1 & depvar4==2
replace bid6=pribid1 if response5==0 & depvar4==2
replace bid6=pribid2 if response5==1 & depvar4==3
replace bid6=pribid2 if response5==0 & depvar4==3
replace bid6=pribid3 if response5==1 & depvar4==4
replace bid6=pribid3 if response5==0 & depvar4==4
replace bid6=pribid4 if response5==1 & depvar4==5
replace bid6=pribid4 if response5==0 & depvar4==5
replace bid6=pribid5 if response5==1 & depvar4==6
replace bid6=pribid5 if response5==0 & depvar4==6
replace bid6=pribid6 if response5==1 & depvar4==7
replace bid6=pribid6 if response5==0 & depvar4==7
replace bid6=pribid6 if response5==1 & depvar4==8



/*WTP estimates using doubleb command*/


doubleb bid5N bid6 response5 response6
doubleb bid5N bid6 response5 response6 riskreduction 



/* generate varibles using YES NO response for public bid*/

gen pubid6=publicbid6 *100000
gen pubid5=publicbid5 *10000
gen pubid4=publicbid4 *1000
gen pubid3=publicbid3 *100
gen pubid2=publicbid2 *10
gen pubid1=publicbid1 *1


gen combinepubid= (pubid1+pubid2+pubid3+pubid4+pubid5+pubid6)
tab1 combinepubid


recode combinepubid (0=1) (1=2) (11=3) (111=4) (1111=5) (11111=6) (111111=7), gen (depvarpublic)

gen depvar2 = . 
replace depvar2 = 1 if depvarpublic==1 /* No No */ 
replace depvar2 = 2 if depvarpublic==2 /* Yes, No No No No No */
replace depvar2 = 3 if depvarpublic==3  /* Yes, Yes, No No No No */
replace depvar2 = 4 if depvarpublic==4  /* Yes, Yes, Yes No No No */
replace depvar2 = 5 if depvarpublic==5   /* Yes, Yes, Yes Yes No No */
replace depvar2 = 6 if depvarpublic==6    /* Yes, Yes, Yes Yes Yes No */
replace depvar2 = 7 if depvarpublic==7     /* Yes, Yes, Yes Yes Yes yes */


tab1 depvar2




/* Yes NO response variables generation end */

/* Final code for reponse varibles for public program*/

generate response3=.
replace response3=1 if depvar2==2| depvar2==3 | depvar2==4 | depvar2==5 | depvar2==6 | depvar2==7
replace response3=0 if depvar2==1

generate response4=.
replace response4=1 if depvar2==7
replace response4=0 if depvar2==1 | depvar2==2| depvar2==3 | depvar2==4 | depvar2==5 | depvar2==6 


/* Final Code for bid1 and bid2 variables for private bid*/

gen bid3=.
replace bid3=pubbid1 if response3==1 & depvar2==1
replace bid3=pubbid1 if response3==0 & depvar2==1
replace bid3=pubbid1 if response3==1 & depvar2==2
replace bid3=pubbid1 if response3==0 & depvar2==2
replace bid3=pubbid2 if response3==1 & depvar2==3
replace bid3=pubbid2 if response3==0 & depvar2==3
replace bid3=pubbid3 if response3==1 & depvar2==4
replace bid3=pubbid3 if response3==0 & depvar2==4
replace bid3=pubbid4 if response3==1 & depvar2==5
replace bid3=pubbid4 if response3==0 & depvar2==5
replace bid3=pubbid5 if response3==1 & depvar2==6
replace bid3=pubbid5 if response3==0 & depvar2==6
replace bid3=pubbid5 if response3==1 & depvar2==7


gen bid3WTP=bid3
replace bid3WTP=5 if response3==0 & response4==0


gen bid3N=.
replace bid3N=pubbid1 if response3==1 & depvar2==1
replace bid3N=pubbid1 if response3==0 & depvar2==1
replace bid3N=pubbid2 if response3==1 & depvar2==2
replace bid3N=pubbid2 if response3==0 & depvar2==2
replace bid3N=pubbid3 if response3==1 & depvar2==3
replace bid3N=pubbid3 if response3==0 & depvar2==3
replace bid3N=pubbid4 if response3==1 & depvar2==4
replace bid3N=pubbid4 if response3==0 & depvar2==4
replace bid3N=pubbid5 if response3==1 & depvar2==5
replace bid3N=pubbid5 if response3==0 & depvar2==5
replace bid3N=pubbid6 if response3==1 & depvar2==6
replace bid3N=pubbid6 if response3==0 & depvar2==6
replace bid3N=pubbid6 if response3==1 & depvar2==7

gen bid4=bid3N


/*WTP estimates using doubleb command*/


doubleb bid3WTP bid4 response3 response4


/*Linear Probit and bivsraite probit with convariates */


biprobit (response5=bid5N income1000 ) (response6=bid6  income1000 ) 
wtpcikr bid5N income1000, reps (20000) equation(response5)
wtpcikr bid6 income1000, reps (20000) equation(response6)

wtp  bid5N income1000 
wtp  bid6 income1000 


biprobit (response5=bid5N ) (response6=bid6 ) 
wtpcikr bid5N , reps (20000) equation(response5)
wtpcikr bid6 income1000, reps (20000) equation(response6)



biprobit (response3=bid3WTP riskreduction income1000 ) (response4=bid4 riskreduction income1000 ) 
wtpcikr bid3WTP riskreduction income1000, reps (20000) equation(response3)


biprobit (response5=bid5N income1000 ) (response6=bid6  income1000 ) 
matrix med_inc=(54)
wtpcikr bid5N income1000, reps (50000) eq(response5) mym(med_inc) dots
wtpcikr bid6 income1000, reps (50000) eq(response6) mym(med_inc) dots



biprobit (response3=bid3WTP income1000 ) (response4=bid4 income1000 ) 
matrix med_inc=(54)
wtpcikr bid3 income1000, reps (50000) eq(response3) mym(med_inc) dots
wtpcikr bid4 income1000, reps (50000) eq(response4) mym(med_inc) dots



doubleb bid5N bid6 response5 response6 

doubleb bid5N bid6 response5 response6 riskreduction
nlcom (WTP:(_b[_cons]+riskreduction_m*_b[riskreduction])), noheader





/* experiemnt */ 

gen depvar5=. 
replace depvar5=1 if npvid0==0 & npvid1==0 & npvid2==0 & npvid3==0 & npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=2 if npvid0==1 | npvid1==0 
replace depvar5=3 if npvid0==1 & npvid1==10 | npvid2==0
replace depvar5=4 if npvid0==1 & npvid1==10 & npvid2==100 | npvid3==0
replace depvar5=5 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 | npvid4==0
replace depvar5=6 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 | npvid5==0
replace depvar5=7 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 & npvid5==100000 | npvid6==0
replace depvar5=8 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 & npvid5==100000 & npvid6==1000000


gen depvar6=. 
replace depvar6=1 if npvid0==0 
replace depvar6=2 if npvid0==1 
replace depvar6=3 if npvid0==1 | npvid1==10
replace depvar6=4 if npvid0==1 | npvid1==10 | npvid2==100
replace depvar6=5 if npvid0==1 | npvid1==10 | npvid2==100 | npvid3==1000
replace depvar6=6 if npvid0==1 | npvid1==10 | npvid2==100 | npvid3==1000 | npvid4==10000
replace depvar6=7 if npvid0==1 | npvid1==10 | npvid2==100 | npvid3==1000 | npvid4==10000 | npvid5==100000
replace depvar6=8 if npvid0==1 | npvid1==10 | npvid2==100 | npvid3==1000 | npvid4==10000 | npvid5==100000 | npvid6==1000000


gen depvar5=. 
replace depvar5=1 if npvid0==0 & npvid1==0 & npvid2==0 & npvid3==0 & npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=2 if npvid0==1 | npvid1==0  & npvid2==0 & npvid3==0 & npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=3 if npvid0==1 & npvid1==10 | npvid2==0 & npvid3==0 & npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=4 if npvid0==1 & npvid1==10 & npvid2==100 | npvid3==0 & npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=5 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 | npvid4==0 & npvid5==0 & npvid6==0
replace depvar5=6 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 | npvid5==0 & npvid6==0
replace depvar5=7 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 & npvid5==100000 | npvid6==0
replace depvar5=8 if npvid0==1 & npvid1==10 & npvid2==100 & npvid3==1000 & npvid4==10000 & npvid5==100000 & npvid6==1000000

gen ex_3 = . 
replace ex_3 = 1 if exp_3_12 == 1 | exp_3_11 == 1 | exp_3_10 == 1 | exp_3_08 == 1
replace ex_3 = 0 if exp_3_07 == 1 | exp_3_0 == 1


/* Fixing the error code */ 

tab2 depvar1 fx_prv_5 


tab2 depvar1 privatebid00

gen depvarNew=depvar1
replace depvarNew=0 if privatebid00==1 | depvar1==1


gen depvarNew1=depvar1
replace depvarNew1=0 if privatebid00==1 & depvar1==1

/* Yes NO response variables generation end */

/* Final code for reponse varibles for private program*/

generate responseN1=.
replace responseN1=1 if depvarNew==2| depvarNew==3 | depvarNew==4 | depvarNew==5 | depvarNew==6 | depvarNew==7
replace responseN1=0 if depvarNew==1| depvarNew==0


generate responseN2=. 
replace responseN2=1 if depvarNew==0| depvarNew==7 
replace responseN2=0 if depvarNew==1 | depvarNew==2| depvarNew==3 | depvarNew==4 | depvarNew==5 | depvarNew==6 


tab2 responseN1 responseN2



gen bid5N=.
replace bid5N=pribid0 if response5==1 & depvar4==1
replace bid5N=pribid0 if response5==0 & depvar4==1
replace bid5N=pribid0 if response5==1 & depvar4==2
replace bid5N=pribid0 if response5==0 & depvar4==2
replace bid5N=pribid1 if response5==1 & depvar4==3
replace bid5N=pribid1 if response5==0 & depvar4==3
replace bid5N=pribid2 if response5==1 & depvar4==4
replace bid5N=pribid2 if response5==0 & depvar4==4
replace bid5N=pribid3 if response5==1 & depvar4==5
replace bid5N=pribid3 if response5==0 & depvar4==5
replace bid5N=pribid4 if response5==1 & depvar4==6
replace bid5N=pribid4 if response5==0 & depvar4==6
replace bid5N=pribid5 if response5==1 & depvar4==7
replace bid5N=pribid5 if response5==0 & depvar4==7
replace bid5N=pribid5 if response5==1 & depvar4==8


gen bid1R=.
replace bid1R=pribid1 if response1==1 & depvar1==1
replace bid1R=pribid1 if response1==0 & depvar1==1
replace bid1R=pribid1 if response1==1 & depvar1==0
replace bid1R=pribid1 if response1==0 & depvar1==0
replace bid1R=pribid1 if response1==1 & depvar1==2
replace bid1R=pribid1 if response1==0 & depvar1==2
replace bid1R=pribid2 if response1==1 & depvar1==3
replace bid1R=pribid2 if response1==0 & depvar1==3
replace bid1R=pribid3 if response1==1 & depvar1==4
replace bid1R=pribid3 if response1==0 & depvar1==4
replace bid1R=pribid4 if response1==1 & depvar1==5
replace bid1R=pribid4 if response1==0 & depvar1==5
replace bid1R=pribid5 if response1==1 & depvar1==6
replace bid1R=pribid5 if response1==0 & depvar1==6
replace bid1R=pribid5 if response1==1 & depvar1==7
