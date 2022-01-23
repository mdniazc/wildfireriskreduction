use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\2-IMDS-2.dta" 



/************************WTP  variables *******************************/


***/* generate varibles using YES NO response for private bid*/

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

* Yes NO response variables generation end */

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


tab2 depvar1 fx_prv_5 
tab2 depvar1 privatebid00

/* generate New YES NO ranking variable using recodeing*/ 

gen depvarNew=depvar1
replace depvarNew=0 if privatebid00==1 & depvar1==1




/* Yes NO response variables generation end */

/* Final code for reponse varibles for private program*/

generate responseN1=.
replace responseN1=1 if depvarNew==2| depvarNew==3 | depvarNew==4 | depvarNew==5 | depvarNew==6 | depvarNew==7
replace responseN1=0 if depvarNew==1| depvarNew==0


generate responseN2=. 
replace responseN2=1 if depvarNew==0| depvarNew==7 
replace responseN2=0 if depvarNew==1 | depvarNew==2| depvarNew==3 | depvarNew==4 | depvarNew==5 | depvarNew==6 


tab2 responseN1 responseN2

/* generating bid variables for privtae program*/


gen bid1R=.
replace bid1R=pribid1 if responseN1==1 & depvarNew==1
replace bid1R=pribid1 if responseN1==0 & depvarNew==1
replace bid1R=pribid1 if responseN1==1 & depvarNew==0
replace bid1R=pribid1 if responseN1==0 & depvarNew==0
replace bid1R=pribid1 if responseN1==1 & depvarNew==2
replace bid1R=pribid1 if responseN1==0 & depvarNew==2
replace bid1R=pribid2 if responseN1==1 & depvarNew==3
replace bid1R=pribid2 if responseN1==0 & depvarNew==3
replace bid1R=pribid3 if responseN1==1 & depvarNew==4
replace bid1R=pribid3 if responseN1==0 & depvarNew==4
replace bid1R=pribid4 if responseN1==1 & depvarNew==5
replace bid1R=pribid4 if responseN1==0 & depvarNew==5
replace bid1R=pribid5 if responseN1==1 & depvarNew==6
replace bid1R=pribid5 if responseN1==0 & depvarNew==6
replace bid1R=pribid5 if responseN1==1 & depvarNew==7



gen bid8=.
replace bid8=pribid0 if responseN1==1 & depvarNew==0
replace bid8=pribid0 if responseN1==0 & depvarNew==0
replace bid8=pribid1 if responseN1==1 & depvarNew==1
replace bid8=pribid1 if responseN1==0 & depvarNew==1
replace bid8=pribid2 if responseN1==1 & depvarNew==2
replace bid8=pribid2 if responseN1==0 & depvarNew==2
replace bid8=pribid3 if responseN1==1 & depvarNew==3
replace bid8=pribid3 if responseN1==0 & depvarNew==3
replace bid8=pribid4 if responseN1==1 & depvarNew==4
replace bid8=pribid4 if responseN1==0 & depvarNew==4
replace bid8=pribid5 if responseN1==1 & depvarNew==5
replace bid8=pribid5 if responseN1==0 & depvarNew==5
replace bid8=pribid6 if responseN1==1 & depvarNew==6
replace bid8=pribid6 if responseN1==0 & depvarNew==6
replace bid8=pribid6 if responseN1==1 & depvarNew==7

gen bid8N=bid8
replace bid8N=0 if responseN1==0 & responseN2==0


gen bid1Pr=bid1R
gen bid2Pr=bid8N


/* doubleb command to calculate WTP */ 

doubleb bid1Pr bid2Pr responseN1 responseN2


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

gen bid3W=.
replace bid3W=pubbid1 if response3==1 & depvar2==1
replace bid3W=pubbid1 if response3==0 & depvar2==1
replace bid3W=pubbid1 if response3==1 & depvar2==2
replace bid3W=pubbid1 if response3==0 & depvar2==2
replace bid3W=pubbid2 if response3==1 & depvar2==3
replace bid3W=pubbid2 if response3==0 & depvar2==3
replace bid3W=pubbid3 if response3==1 & depvar2==4
replace bid3W=pubbid3 if response3==0 & depvar2==4
replace bid3W=pubbid4 if response3==1 & depvar2==5
replace bid3W=pubbid4 if response3==0 & depvar2==5
replace bid3W=pubbid5 if response3==1 & depvar2==6
replace bid3W=pubbid5 if response3==0 & depvar2==6
replace bid3W=pubbid5 if response3==1 & depvar2==7


gen bid3=bid3W
replace bid3=5 if response3==0 & response4==0


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

doubleb bid3 bid4 response3 response4


********************************************************************************
********************************************************************************
/*Linear Probit and bivsraite probit with convariates */

biprobit (response1=bid1 income1000) (response2=bid2  income1000 ) 
wtpcikr bid1 income1000, reps (20000) equation(response1)
wtpcikr bid2 income1000, reps (20000) equation(response2)

biprobit (response1=bid1 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol ) (response2=bid2 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol )

margins, dydx(*) atmeans




wtpcikr bid1 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, reps(20000) equation (response1)


wtpcikr bid2 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, reps(20000) equation (response2)

wtpcikr  bid1 bid2 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, reps(20000) equation (response1 response2)




wtp  bid1 income1000 
wtp  bid2 income1000 

biprobit(responseN1 bid1 income1000) (responseN2 bid2 income1000), cluster(riskreduction) nolog
biprobit(responseN1 bid1 riskreduction) (responseN2 bid2 riskreduction), cluster(income1000) nolog

biprobit (responseN1=bid1 ) (responseN2=bid2 ) 
wtpcikr bid1 , reps (20000) equation(responseN1)
wtpcikr bid2, reps (20000) equation(responseN2)


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


doubleb bid3 bid4 response3 response4

doubleb bid3 bid4 response3 response4 riskreduction
nlcom (WTP:(_b[_cons]+riskreduction_m*_b[riskreduction])), noheader

biprobit (response3=bid3 income1000 riskreduction ) (response4=bid4  income1000 riskreduction ) 
wtpcikr bid3 income1000 riskreduction, reps (20000) equation(response3)
wtpcikr bid4 income1000 riskreduction, reps (20000) equation(response4)   */ ///////////

/* doubleb command analysis */

mi set wide
mi register imputed f1 f2 f3 f4 f5 f6 f7
mi impute chained ( truncreg ) f1 f2 f3 f4 f5 f6 f7, add (5) rseed (9478)


doubleb bid1 bid2 response1 response2 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7
doubleb bid3 bid4 response3 response4 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7


mi register imputed pc1 pc2 pc3 pc4 pc5 pc6 pc7
mi impute chained ( truncreg ) pc1 pc2 pc3 pc4 pc5 pc6 pc7, add (5) rseed (9478)


mi register imputed fN1 fN2 fN3  fN4 fN5 fN6 fN7 fN8 fN9 fN10
mi impute chained ( truncreg ) fN1 fN2 fN3  fN4 fN5 fN6 fN7 fN8 fN9 fN10, add (5) rseed (9478)


mi register imputed  F_Att F_CWPlan F_GFSI F_PLM F_EEN F_HFSI F_UHAP
mi impute chained ( truncreg )  F_Att F_CWPlan F_GFSI F_PLM F_EEN F_HFSI F_UHAP, add (5) rseed (9478)

doubleb bid1 bid2 response1 response2 _10_pc1 _10_pc2 _10_pc3 _10_pc4 _10_pc5 _10_pc6 _10_pc7
doubleb bid1 bid2 response1 response2 _15_F_Att _15_F_CWPlan _15_F_GFSI _15_F_PLM _15_F_EEN _15_F_HFSI _15_F_UHAP
doubleb bid1 bid2 response1 response2 _20_fN1 _20_fN2 _20_fN3 _20_fN4 _20_fN5 _20_fN6 _20_fN7 _20_fN8 _20_fN9 _20_fN10

mi set wide
mi register imputed f1 f2 f3 f4 f5 f6 f7
mi impute chained ( truncreg ) f1 f2 f3 f4 f5 f6 f7, add (5) rseed (9478)


doubleb bid1 bid2 response1 response2 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7
doubleb bid3 bid4 response3 response4 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7



