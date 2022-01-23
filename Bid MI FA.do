
*Latest*

use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\17-MergeFinal.dta" 



use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\16-FinalMergePresentation.dta" 
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\15-MergeDATASET-NEW.dta" 

/*mergedata Set */
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\WTPModelingMerge.dta" 
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\11-DeletedMissingValues-471-2.dta" 
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\2-IMDS-2.dta" 
 
 
/* dataset with 737 variables */
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\2-IMDS-2.dta" 



/* Delete missing observations and same observations for the both  data set */


drop if missing(response1)
drop if missing(response2)
drop if missing(response3)
drop if missing(response4)
 
*********************************************************************
********************************************************************

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


*******************************************************************************************
****************************************************************************************
**********************/* Experiemnt for Factor Analysis */******************************

mi register imputed  noafford1 novalue1 notachieved1 smallrisk1 allcovered1  altruism1  own_yrs agehome age income income1000 own_more fire_risk efficacy rtol combineinvestment1

mi impute chained (logit) noafford1 novalue1 notachieved1 smallrisk1 allcovered1  altruism1 own_more (truncreg) own_yrs agehome age income fire_risk efficacy rtol combineinvestment1, add(20) rseed (9478)  


mi set mlong
mi register imputed   own_yrs agehome age income fire_risk efficacy rtol combineinvestment1
mi impute chained (logit) cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1  insurancecoveredall1 (truncreg) own_yrs agehome age income fire_risk efficacy rtol combineinvestment1, add(20) rseed (9478) 


/* experiment start*/ 
alpha altrusimpub1   important1 preventpub1   peacemindpub1

factor  novalue1  notachieved1 costnothing1 smallrisk1 allcovered1  altruism1 , pcf
rotate
sortl
alpha   novalue1  notachieved1 costnothing1 smallrisk1 allcovered1  altruism1

alpha   novalue1  notachieved1 costnothing1 smallrisk1 
predict F_Att

factor    notachieved1  smallrisk1 allcovered1   , pcf
rotate
sortl
alpha notachieved1  smallrisk1 allcovered1 
global xlist noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1


factor  $xlist , pcf
rotate
sortl
alpha  $xlist
alpha  altrusimpub1   important1 preventpub1   peacemindpub1 
altrusimpub1   important1 preventpub1 movebeforebenefit1  peacemindpub1 smallriskchange1 prognovalue1

global xlist noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1 
                                                   
********************************** /* Experiemnt end */ *******************************************************************************
***************************************************************************************************************************************
													 
													 

**********************************************************************************************************************************************
**********************************************************************************************************************************************
*************************************************** 10/04/2020********************************************************************************										
********************* Multiple Imputstion chanined Equation **********************************************************************************

mi set wide 

mi register imputed commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH noafford1 novalue1 notachieved1 smallrisk1 allcovered1  altruism1  cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1  insurancecoveredall1 own_more own_yrs agehome age income income1000 fire_risk efficacy rtol combineinvestment1


mi impute chained (logit) commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH noafford1 novalue1 notachieved1 smallrisk1 allcovered1  altruism1  cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1  insurancecoveredall1, add (20) rseed (9478) 

mi impute chained (truncreg) own_yrs agehome age income income1000 fire_risk efficacy rtol combineinvestment1, add (20) rseed (9478) 


**********************************************************************************************************************************************
**********************************************************************************************************************************************
*************************************************** 10/05/2020********************************************************************************

sum _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP _20_c8WLH _20_noafford1 _20_novalue1 _20_notachieved1 _20_smallrisk1 _20_allcovered1 _20_altruism1 _20_cannotafford1 _20_prognovalue1 _20_altrusimpub1 _20_dontbelieve1 _20_ownpropertydfs1 _20_smallriskchange1 _20_insurancecoveredall1 

sum  _40_own_yrs _40_agehome _40_age _40_income _40_income1000 _40_fire_risk _40_efficacy _40_rtol _40_combineinvestment1

/* used this list to create variabel f1-f8*/

global xlist _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP _20_c8WLH  _20_novalue1 _20_notachieved1 _20_smallrisk1 _20_noafford1 _20_allcovered1 _20_altruism1 

/* used this list to create variabel f1BP-f7BP*/

global xlist _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP 



***********************************/* factor analysis to create indices */***************************************************
*****************************************************************************************************************************
global ncomp 7
factor $xlist, pcf

*factor analysis analysis (FA)

factor $xlist, mineigen(1) pcf
factor $xlist, comp($ncomp)
factor $xlist, comp($ncomp) blanks (.3)

*factor rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 

rotate, promax
rotate, promax blanks(.3)
rotate, clear


*scatter plots of the loading and score variables 

loadingplot
scoreplot
*score of the componets 

predict f1BP f2BP f3BP  f4BP f5BP f6BP f7BP



/* private Program value */

global xlist _20_novalue1 _20_notachieved1 _20_smallrisk1 

factor  _20_novalue1 _20_notachieved1 _20_smallrisk1, pcf
rotate 
sortl
alpha  _20_novalue1 _20_notachieved1 _20_smallrisk1 
predict f8PriP

/* public program variable factor analysis */ 

global xlist  _20_prognovalue1  _20_dontbelieve1  _20_smallriskchange1  

factor _20_prognovalue1  _20_dontbelieve1  _20_smallriskchange1  , pcf
rotate 
sortl
alpha _20_prognovalue1  _20_dontbelieve1  _20_smallriskchange1
predict f9PubP


/*Rennae variables used for private and community program */

gen landmanagement_BP=f1BP
gen CommWFPlanning_BP=f2BP
gen NeighborsEffect_BP=f3BP
gen CommAttachment_BP=f4BP
gen govtpolicyFSI_BP=f5BP
gen utilityAP_BP=f6BP
gen HouseholdFSI_BP=f7BP
gen privateprogramvalue_PRP=f8PriP
gen publicprogramvalue_PUP=f9PubP

gen loss1000=loss/1000
gen IncomeThousand=_50_income/1000

gen incNT = _45_income/1000

/* Extra genearte varibles using Fctor analysis where I used more obseravtion and more variables*/

gen landmanagement=f1
gen CommWFPlanning=f2
gen NeighborsEffect=f3
gen CommAttachment=f4
gen govtpolicyFSI=f5
gen utilityAP=f6
gen privateprogramvalue =f7
gen HouseholdFSI=f8
gen publicprogramvalue=f9

/* Extra code end */




/* Summary Statistics before Imputation */

commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH noafford1 novalue1 notachieved1 smallrisk1 allcovered1 altruism1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 insurancecoveredall1 fire_risk efficacy 



alpha commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 
estpost sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 
esttab using CommunityattachmentFinal.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace

alpha commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 
estpost sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 
esttab using CommunityWFPlaning.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1
estpost sum coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 
esttab using GovtpolicyFSI.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha similarvalue1 similargoal1 similarthink1 samepriorities1
estpost sum similarvalue1 similargoal1 similarthink1 samepriorities1
esttab using landmanagement.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha nearneighbor1 otherneighbor1 respcommmunity1
estpost sum nearneighbor1 otherneighbor1 respcommmunity1
esttab using neighboreffect.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
estpost sum hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
esttab using householdFSI.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha c5HLA c6LLA c7LRP  c8WLH
estpost sum c5HLA c6LLA c7LRP  c8WLH
esttab using utilityhits.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha noafford1 novalue1 notachieved1
estpost sum noafford1 novalue1 notachieved1
esttab using privateprogramvalue.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha noafford1 novalue1 notachieved1 smallrisk1 allcovered1 altruism1 
alpha cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 insurancecoveredall1
estpost sum noafford1 novalue1 notachieved1 smallrisk1 allcovered1 altruism1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 insurancecoveredall1
esttab using pripubprogramvalue.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


alpha fire_risk efficacy 
estpost sum fire_risk efficacy 
esttab using benefitFSI.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace



/* Fator analysis results */

global xlist _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP _20_c8WLH  


corr $xlist

global ncomp 7
factor $xlist, pcf

*factor analysis analysis (FA)

factor $xlist, mineigen(1) pcf
factor $xlist, comp($ncomp)
factor $xlist, comp($ncomp) blanks (.3)

*factor rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 

rotate, promax
rotate, promax blanks(.3)
rotate, clear


global xlist _20_novalue1 _20_notachieved1 _20_smallrisk1 


global ncomp 1
factor $xlist, pcf

*factor analysis analysis (FA)

factor $xlist, mineigen(1) pcf
factor $xlist, comp($ncomp)
factor $xlist, comp($ncomp) blanks (.3)

*factor rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 

rotate, promax
rotate, promax blanks(.3)
rotate, clear

alpha _20_novalue1 _20_notachieved1 _20_smallrisk1 


/* public program value index varibles */

global xlist  _40_prognovalue1 _40_dontbelieve1 _40_smallriskchange1

global ncomp 1
factor $xlist, pcf

*factor analysis analysis (FA)

factor $xlist, mineigen(1) pcf
factor $xlist, comp($ncomp)
factor $xlist, comp($ncomp) blanks (.3)

*factor rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 

rotate, promax
rotate, promax blanks(.3)
rotate, clear

alpha _40_prognovalue1 _40_dontbelieve1 _40_smallriskchange1
predict riaz2


/* list of Independent variabels */

estpost sum landmanagement_BP NeighborsEffect_BP CommWFPlanning_BP  CommAttachment_BP utilityAP_BP govtpolicyFSI_BP  HouseholdFSI_BP privateprogramvalue_PRP publicprogramvalue_PUP riskreduction baselinerisk _40_income1000  lossThousand  _40_age _40_agehome _40_own_yrs _40_own_more _40_efficacy _40_rtol _40_efficacy yearspan yearspan5 yearspan10  _20_noafford1 _20_allcovered1 _20_altruism1  _20_cannotafford1 _20_insurancecoveredall1 _20_altrusimpub1 _20_ownpropertydfs1   

esttab using indepvarlist.rtf , cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace


/* LIST OF dependent varibeles */

estpost sum bid1 bid2 bid3 bid4 
esttab using bidamount.rtf , cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace

estpost sum response1 response2 response3 response4
esttab using answerbids.rtf , cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace

estpost sum bid1 bid2 bid3 bid4 response1 response2 response3 response4
esttab using dependentvar.rtf , cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace




************************************************************************************************************************************
************************************************************************************************************************************
*************************************************************************************************************************************
/* Delete missing observations and same observations for the both  data set */


drop if missing(response1)
drop if missing(response2)
drop if missing(response3)
drop if missing(response4)



/* private program WTP - adding few more variables in the Factor analysis*/
doubleb bid1 bid2 response1 response2 landmanagement CommWFPlanning NeighborsEffect CommAttachment govtpolicyFSI utilityAP HouseholdFSI privateprogramvalue baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand

/* public or community program WTP adding more variables in the factor analysis */

doubleb bid3 bid4 response3 response4 landmanagement CommWFPlanning NeighborsEffect CommAttachment govtpolicyFSI utilityAP HouseholdFSI publicprogramvalue baselinerisk incomeThousand riskreduction _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1

*****************************************************************************************************************
**************************************************************************************************************
*****************************************************************************************************************

/* private program WTP final model */

doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl 


mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)


/*  WTP Extra code Start */


nlcom (WTP:(_b[_cons]+_b[landmanagement_BP]+_b[CommWFPlanning_BP]+_b[NeighborsEffect_BP]+_b[CommAttachment_BP]+_b[govtpolicyFSI_BP]+_b[utilityAP_BP]+_b[privateprogramvalue_PRP]+_b[HouseholdFSI_BP]+_b[baselinerisk]+_b[incomeThousand]+_b[riskreduction]+_b[_20_noafford1]+_b[_20_allcovered1]+_b[_20_altruism1]+_b[lossThousand]+_b[_40_own_yrs]+_b[ _40_agehome]+_b[_40_age]+_b[_40_fire_risk]+_b[_40_efficacy]+_b[_40_rtol])), noheader



nlcom (WTP:(_b[_cons])), noheader
nlcom (WTP:(_b[landmanagement_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[CommWFPlanning_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[NeighborsEffect_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[CommAttachment_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[govtpolicyFSI_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[utilityAP_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[privateprogramvalue_PRP])), noheader
nlcom (WTP:(_b[_cons]+_b[HouseholdFSI_BP])), noheader
nlcom (WTP:(_b[_cons]+_b[baselinerisk])), noheader
nlcom (WTP:(_b[_cons]+_b[incomeThousand])), noheader
nlcom (WTP:(_b[_cons]+_b[riskreduction])), noheader
nlcom (WTP:(_b[_cons]+_b[_20_noafford1])), noheader
nlcom (WTP:(_b[_cons]+_b[_20_allcovered1])), noheader
nlcom (WTP:(_b[_cons]+_b[_20_altruism1])), noheader
nlcom (WTP:(_b[_cons]+_b[lossThousand])), noheader
nlcom (WTP:(_b[_cons]+_b[_40_own_yrs])), noheader=
nlcom (WTP:(_b[_cons]+_b[_40_agehome])), noheader
nlcom (WTP:(_b[_cons]+_b[_40_fire_risk])), noheader
nlcom (WTP:(_b[_cons]+_b[_40_efficacy])), noheader
nlcom (WTP:(_b[_cons]+_b[_40_rto])), noheader


summarize  baselinerisk, meanonly
scalar baselinerisk_m=r(mean)
summarize  riskreduction  , meanonly
scalar riskreduction_m=r(mean)
summarize   yearspan, meanonly
scalar   yearspan_m=r(mean)
summarize  loss1000  , meanonly
scalar loss1000_m=r(mean)


summarize  landmanagement_BP, meanonly
scalar landmanagement_BP_m=r(mean)
summarize  CommWFPlanning_BP, meanonly
scalar CommWFPlanning_BP_m=r(mean)
summarize  CommAttachment_BP , meanonly
scalar CommAttachment_BP_m=r(mean)
summarize  govtpolicyFSI_BP, meanonly
scalar govtpolicyFSI_BP_m=r(mean)
summarize  utilityAP_BP, meanonly
scalar utilityAP_BP_m=r(mean)
summarize  privateprogramvalue_PRP, meanonly
scalar  privateprogramvalue_PRP_m=r(mean)
summarize  HouseholdFSI_BP  , meanonly
scalar HouseholdFSI_BP_m=r(mean)




summarize _20_noafford1, meanonly
scalar _20_noafford1_m=r(mean)
summarize  _20_allcovered1, meanonly
scalar _20_allcovered1_m=r(mean)
summarize  _20_altruism1, meanonly
scalar  _20_altruism1_m=r(mean)


summarize  incNT, meanonly
scalar incNT_m=r(mean)
summarize  _50_agehome , meanonly
scalar _50_agehome_m=r(mean)
summarize  _45_age, meanonly
scalar  _45_age_m=r(mean)
summarize  _65_fire_risk , meanonly
scalar _65_fire_risk_m=r(mean)
summarize _70_efficacy, meanonly
scalar  _70_efficacy_m=r(mean)
summarize  _60_rtol , meanonly
scalar _60_rtol_m=r(mean)
summarize  hhvl , meanonly
scalar hhvl_m=r(mean)


doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl 


margin 
nlcom (WTP:(_b[_cons])), noheader
nlcom (WTP:(baselinerisk_m*_b[baselinerisk])), noheader
nlcom (WTP:(riskreduction_m*_b[riskreduction])), noheader
nlcom (WTP:(loss1000_m*_b[loss1000])), noheader
nlcom (WTP:(yearspan_m*_b[yearspan])), noheader

nlcom (WTP:(landmanagement_BP_m*_b[landmanagement_BP])), noheader
nlcom (WTP:(CommWFPlanning_BP_m*_b[CommWFPlanning_BP])), noheader
nlcom (WTP:(CommAttachment_BP_m*_b[CommAttachment_BP])), noheader

nlcom (WTP:(govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP])), noheader
nlcom (WTP:(utilityAP_BP_m*_b[utilityAP_BP])), noheader
nlcom (WTP:(HouseholdFSI_BP_m*_b[HouseholdFSI_BP])), noheader
nlcom (WTP:(privateprogramvalue_PRP_m*_b[privateprogramvalue_PRP])), noheader


nlcom (WTP:(_20_noafford1_m*_b[_20_noafford1])), noheader
nlcom (WTP:(_20_allcovered1_m*_b[_20_allcovered1])), noheader
nlcom (WTP:(_20_altruism1_m*_b[_20_altruism1])), noheader
nlcom (WTP:(incNT_m*_b[incNT])), noheader

nlcom (WTP:(_50_agehome_m*_b[_50_agehome])), noheader
nlcom (WTP:(_45_age_m*_b[_45_age])), noheader
nlcom (WTP:(_60_rtol_m*_b[_60_rtol])), noheader
nlcom (WTP:(_65_fire_risk_m*_b[_65_fire_risk ])), noheader
nlcom (WTP:(_70_efficacy_m*_b[_70_efficacy])), noheader
nlcom (WTP:(hhvl_m*_b[hhvl])), noheader



nlcom (WTP:(_b[_cons]+landmanagement_BP_m*_b[landmanagement_BP]+CommWFPlanning_BP_m*_b[CommWFPlanning_BP]+NeighborsEffect_BP_m*_b[NeighborsEffect_BP]+CommAttachment_BP_m*_b[CommAttachment_BP]+govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP]+utilityAP_BP_m*_b[utilityAP_BP]+privateprogramvalue_PRP_m*_b[privateprogramvalue_PRP]+HouseholdFSI_BP_m*_b[HouseholdFSI_BP]+baselinerisk_m*_b[baselinerisk]+IncomeThousand_m*_b[IncomeThousand]+riskreduction_m*_b[riskreduction]+_20_noafford1_m*_b[_20_noafford1]+_20_allcovered1_m*_b[_20_allcovered1]+_20_altruism1_m*_b[_20_altruism1]+loss1000_m*_b[loss1000]+_55_agehome_m*_b[ _55_agehome]+_55_age_m*_b[_55_age]+_65_fire_risk_m*_b[_65_fire_risk]+_70_efficacy_m*_b[_70_efficacy]+_60_rtol_m*_b[_60_rtol]+yearspan5_m*_b[yearspan5])), noheader

/* WTP extra code End */


biprobit (response1=bid1 baselinerisk  riskreduction loss1000  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy ) (response2=bid2 baselinerisk  riskreduction loss1000  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy )

wtpcikr bid1 baselinerisk  riskreduction loss1000  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy , reps(20000) equation (response1)


wtpcikr bid2 baselinerisk  riskreduction loss1000  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy , reps(20000) equation (response2) dots


margins, dydx(*) atmeans



wtpcikr bid1 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, reps(50000) equation (response1)  dots


wtpcikr bid2 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, reps(50000) equation (response2)  dots



wtp bid1 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol

wtp bid1 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP privateprogramvalue_PRP HouseholdFSI_BP baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol, krinsky reps(2000)



/* public program WTP model, final model*/

doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 _60_rtol _65_fire_risk _70_efficacy incNT _50_agehome _45_age  hhvl 




mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)


summarize  baselinerisk, meanonly
scalar baselinerisk_m=r(mean)
summarize  riskreduction  , meanonly
scalar riskreduction_m=r(mean)
summarize   yearspan, meanonly
scalar   yearspan_m=r(mean)



summarize  landmanagement_BP, meanonly
scalar landmanagement_BP_m=r(mean)
summarize  CommWFPlanning_BP, meanonly
scalar CommWFPlanning_BP_m=r(mean)
summarize  CommAttachment_BP , meanonly
scalar CommAttachment_BP_m=r(mean)
summarize  govtpolicyFSI_BP, meanonly
scalar govtpolicyFSI_BP_m=r(mean)
summarize  utilityAP_BP, meanonly
scalar utilityAP_BP_m=r(mean)
summarize  HouseholdFSI_BP  , meanonly
scalar HouseholdFSI_BP_m=r(mean)
summarize  publicprogramvalue_PUP , meanonly
scalar  publicprogramvalue_PUP_m=r(mean)



summarize _20_cannotafford1, meanonly
scalar _20_cannotafford1_m=r(mean)
summarize  _20_insurancecoveredall1 , meanonly
scalar _20_insurancecoveredall1_m=r(mean)
summarize   _20_altrusimpub1, meanonly
scalar   _20_altrusimpub1_m=r(mean)
summarize  _20_ownpropertydfs1  , meanonly
scalar _20_ownpropertydfs1_m=r(mean)


summarize  incNT, meanonly
scalar incNT_m=r(mean)
summarize  _50_agehome , meanonly
scalar _50_agehome_m=r(mean)
summarize  _45_age, meanonly
scalar  _45_age_m=r(mean)
summarize  _65_fire_risk , meanonly
scalar _65_fire_risk_m=r(mean)
summarize _70_efficacy, meanonly
scalar  _70_efficacy_m=r(mean)
summarize  _60_rtol , meanonly
scalar _60_rtol_m=r(mean)
summarize  hhvl , meanonly
scalar hhvl_m=r(mean)




nlcom (WTP:(_b[_cons])), noheader
nlcom (WTP:(baselinerisk_m*_b[baselinerisk])), noheader
nlcom (WTP:(riskreduction_m*_b[riskreduction])), noheader
nlcom (WTP:(yearspan_m*_b[yearspan])), noheader

nlcom (WTP:(landmanagement_BP_m*_b[landmanagement_BP])), noheader
nlcom (WTP:(CommWFPlanning_BP_m*_b[CommWFPlanning_BP])), noheader
nlcom (WTP:(CommAttachment_BP_m*_b[CommAttachment_BP])), noheader

nlcom (WTP:(govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP])), noheader
nlcom (WTP:(utilityAP_BP_m*_b[utilityAP_BP])), noheader
nlcom (WTP:(HouseholdFSI_BP_m*_b[HouseholdFSI_BP])), noheader
nlcom (WTP:(publicprogramvalue_PUP_m*_b[publicprogramvalue_PUP])), noheader


nlcom (WTP:(_20_cannotafford1_m*_b[_20_cannotafford1])), noheader
nlcom (WTP:(_20_insurancecoveredall1_m*_b[_20_insurancecoveredall1])), noheader
nlcom (WTP:(_20_altrusimpub1_m*_b[_20_altrusimpub1])), noheader
nlcom (WTP:(_20_ownpropertydfs1_m*_b[_20_ownpropertydfs1])), noheader


nlcom (WTP:(incNT_m*_b[incNT])), noheader
nlcom (WTP:(_50_agehome_m*_b[_50_agehome])), noheader
nlcom (WTP:(_45_age_m*_b[_45_age])), noheader
nlcom (WTP:(_60_rtol_m*_b[_60_rtol])), noheader
nlcom (WTP:(_65_fire_risk_m*_b[_65_fire_risk ])), noheader
nlcom (WTP:(_70_efficacy_m*_b[_70_efficacy])), noheader
nlcom (WTP:(hhvl_m*_b[hhvl])), noheader



nlcom (WTP:(_b[_cons]+landmanagement_BP_m*_b[landmanagement_BP]+CommWFPlanning_BP_m*_b[CommWFPlanning_BP]+NeighborsEffect_BP_m*_b[NeighborsEffect_BP]+CommAttachment_BP_m*_b[CommAttachment_BP]+govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP]+utilityAP_BP_m*_b[utilityAP_BP]+publicprogramvalue_PUP_m*_b[publicprogramvalue_PUP]+HouseholdFSI_BP_m*_b[HouseholdFSI_BP]+baselinerisk_m*_b[baselinerisk]+IncomeThousand_m*_b[IncomeThousand]+riskreduction_m*_b[riskreduction]+_20_cannotafford1_m*_b[_20_cannotafford1]+_20_insurancecoveredall1_m*_b[_20_insurancecoveredall1]+_20_altrusimpub1_m*_b[_20_altrusimpub1]+_20_ownpropertydfs1_m*_b[_20_ownpropertydfs1]+yearspan5_m*_b[yearspan5]+_55_agehome_m*_b[ _55_agehome]+_55_age_m*_b[_55_age]+_65_fire_risk_m*_b[_65_fire_risk]+_70_efficacy_m*_b[_70_efficacy]+_60_rtol_m*_b[_60_rtol])), noheader






/* stata word file model combine */


doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP  CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 _55_age _60_rtol _65_fire_risk _70_efficacy IncomeThousand _55_agehome  hhvl

predict yhat, xb 

tabstat yhat, by (p1_pct)
tabstat yhat, by (pr_loss_year)
tabstat yhat, by (pr_loss)
tabstat yhat, by (loss)

tabstat yhat, by (IncomeThousand)
tabstat yhat, by (inc)

tabstat yhat, by (_55_age)
tabstat yhat, by (_55_agehome)
tabstat yhat, by (_60_rtol)
tabstat yhat, by (_65_fire_risk)
tabstat yhat, by (_70_efficacy)

tabstat yhat, by (_20_allcovered1)
tabstat yhat, by (_20_noafford1)
tabstat yhat, by (_20_altruism1)

tabstat yhat, by (_20_protectvoluntary)

tabstat yhat, by (riskreduction)

predict e, res


tabstat yhat, by (yearspan)
yearspan

mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)



doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy 

predict nhat, xb 
tabstat nhat, by (p1_pct)
tabstat nhat, by (pr_loss_year)
tabstat nhat, by (pr_loss)

tabstat nhat, by (IncomeThousand)
tabstat nhat, by (_55_age)
tabstat nhat, by (_55_agehome)
tabstat nhat, by (_60_rtol)
tabstat nhat, by (_65_fire_risk)
tabstat nhat, by (_70_efficacy)

tabstat nhat, by (_20_insurancecoveredall1)
tabstat nhat, by (_20_cannotafford1)
tabstat nhat, by (_20_altrusimpub1)
tabstat nhat, by ( _20_ownpropertydfs1)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)

estimate store model1
estimate store model2
 
esttab model1 model2 using modelcomb1.rtf, replace 



/* 10-29-2020 Analysis */

/* stata word file model combine */



doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl 

predict yhat, xb 

margins 
marginsplot
marginsplot, recast(bar)

margins, at(_45_age=(25(5)95))
marginsplot, name (margin1, replace)
marginsplot, recast(line) recastci(rarea) name (margin2, replace)

margins, at(_45_age=(25(5)95))
marginsplot, name (margin3, replace)

margins, at(_50_agehome =(1(5)30))
marginsplot, name (margin4, replace)

margins, at(incNT =(10(10)250))
marginsplot, name (margin5, replace)

margins, at(hhvl =(5(1)17 ))
marginsplot, name (margin6, replace)

margins, at(_20_noafford1 =(0(1)1))
marginsplot, name (margin7, replace)

margins, at(_60_rtol =(.203 .228 .257 .301))
marginsplot, name (margin8, replace)

margins, at(_65_fire_risk  =(0(.10)1))
marginsplot, name (margin9, replace)

margins, at(_70_efficacy  =(0(.10)1))
marginsplot, name (margin10, replace)


margins, at(loss1000  =(50 100 200))
marginsplot, name (margin11, replace)

margins, at(yearspan  =(5 10))
marginsplot, name (margin12, replace)

margins, at(riskreduction =(1 2 4))
marginsplot, name (margin13, replace)

margins, at(riskreduction =(1 (.5) 4))
marginsplot, name (margin14, replace)




predict yhat, xb 

tabstat yhat, by (p1_pct)
tabstat yhat, by (pr_loss_year)
tabstat yhat, by (pr_loss)
tabstat yhat, by (loss)

tabstat yhat, by (IncomeThousand)
tabstat yhat, by (inc)

tabstat yhat, by (_45_age)
tabstat yhat, by (_50_agehome)
tabstat yhat, by (_60_rtol)
tabstat yhat, by (_65_fire_risk)
tabstat yhat, by (_70_efficacy)

tabstat yhat, by (_20_allcovered1)
tabstat yhat, by (_20_noafford1)
tabstat yhat, by (_20_altruism1)



/* Risk Reduction Private Vs Public*/

tabstat yhat, by (riskreduction)
tabstat pubhat, by (riskreduction)
margins, at(riskreduction =(1 2 4 ))

/* Income WTP across public and Private Program */
tabstat yhat, by (incNT)
tabstat pubhat, by (incNT)
margins, at(incNT =(10 19.999  29.999 42.499 62.499 87.499  124.999 174.999 250))

/* HHVl WTP across public and Private Program */
tabstat yhat, by (hhvl)
tabstat pubhat, by (hhvl)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)



doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 _60_rtol _65_fire_risk _70_efficacy incNT _50_agehome _45_age  hhvl 

predict nhat, xb 
gen pubhat=nhat*5

tabstat nhat, by (p1_pct)
tabstat pubhat, by (p1_pct)

tabstat nhat, by (pr_loss_year)
tabstat nhat, by (pr_loss)

tabstat pubhat, by (incNT)
tabstat nhat, by (incNT)

tabstat nhat, by (_55_age)
tabstat nhat, by (_55_agehome)
tabstat nhat, by (_60_rtol)
tabstat nhat, by (_65_fire_risk)
tabstat nhat, by (_70_efficacy)

tabstat nhat, by (_20_insurancecoveredall1)
tabstat nhat, by (_20_cannotafford1)
tabstat nhat, by (_20_altrusimpub1)
tabstat nhat, by ( _20_ownpropertydfs1)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)

estimate store model1
estimate store model2
 
esttab model1 model2 using modelcomb1.rtf, replace 




/* 10-29-2020 Density funtion */ 

twoway histogram bid1 || kdensity bid1
twoway histogram bid2 || kdensity bid2

twoway histogram yhat || kdensity yhat

twoway histogram pubhat || kdensity pubhat

cdfplot bid2, by (response2)
cdfplot bid2, by (response2) norm

cdfplot bid1, by (response1)
cdfplot bid1, by (response1) norm

cdfplot yhat, norm
cdfplot pubhat, norm

describe bid2 
hist bid2 
cumul bid2, gen(cbid2) equal 
line cbid2 bid2, sort

describe yhat 
hist yhat 
cumul yhat, gen(cyhat) equal 
line cyhat yhat, sort 

describe pubhat 
hist pubhat 
cumul pubhat, gen(cpubhat) equal 
line cpubhat pubhat, sort 



describe yhat 
hist yhat 
cumul yhat, gen(cyhat) equal 
line cyhat yhat, sort 


describe bid1 
hist bid1 
cumul bid1, gen(cbid1) equal 
line cbid1 bid1, sort

stack cbid1 bid1 cbid2 bid2, into (c bid) wide clear 
line cbid1 cbid2 bid, sort 


describe yhat
hist yhat 
cumul yhat, gen(cyhat) equal 
line cyhat yhat, sort

describe nhat 
hist nhat
cumul nhat, gen(cnhat) equal 
line cnhat nhat, sort

stack cyhat yhat cnhat nhat, into (c WTP) wide clear 
line cyhat cnhat WTP, sort 


histogram bid1, percent width (500) start(0) by(response1)

histogram bid1, freq width (500)start(0) by(response1) 
histogram bid2, freq width (500) start(0) by(response2)

histogram bid3, freq width (20) start(0) by(response3)
histogram bid4, freq width (20)  start(0) by(response4)

spikeplot bid4, by(response4)

gladder bid1, fraction
graph box bid1, over(response1)
histogram  bid1, frequency normal
sunflower bid1 response1
graph box bid1, over(response1) horizontal
histogram bid1, frequency  kdensity

tab2 bid1 response1, chi2
oneway bid1 response1, tabulate
ttest bid1, by(response1)

kdensity income if response1==1
kdensity income if response1 == 1, addplot(kdensity income if response1 == 0)
kdensity bid1 if response1==1
kdensity bid1 if response1 == 1, addplot(kdensity bid1 if response1 == 0)

kdensity yhat, addplot(kdensity pubhat)


histogram bid1, discrete width(300) start(0) frequency by(response1)


twoway histogram bid1, bin(16) freq by(response1) 
twoway histogram bid1, bin(16) by(response1) 


/* confirmatory Factor Analysis */


landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP HouseholdFSI_BP privateprogramvalue_PRP publicprogramvalue_PUP

gen F1=CommAttachment_BP
gen F2=CommWFPlanning_BP
gen F3=govtpolicyFSI_BP
gen F4=landmanagement_BP 
gen F5=HouseholdFSI_BP
gen F6=utilityAP_BP
gen F7=NeighborsEffect_BP
gen F8=privateprogramvalue_PRP
gen F9=publicprogramvalue_PUP




gen Q1=_20_commatt_11
gen Q2= _20_commatt_21 
gen Q3=_20_commatt_31
gen Q4= _20_commatt_41
gen Q5= _20_commatt_51
gen Q6= _20_commatt_71


gen Q7=_20_commnetwork51
gen Q8= _20_commnetwork61 
gen Q9=_20_commnetwork71
gen Q10= _20_commnetwork81
gen Q11= _20_commnetwork91


gen Q12=_20_coordinatedfs1
gen Q13= _20_comminvestdfs1
gen Q14=_20_taxbreaks1
gen Q15= _20_lowinsurance1
gen Q16= _20_lawmaintain1
gen Q17= _20_govtsubsidy1


gen Q18=_20_similarvalue1
gen Q19= _20_similargoal1
gen Q20=_20_similarthink1
gen Q21= _20_samepriorities1

gen Q22=_20_hhfirerroof
gen Q23= _20_hhfirersiding
gen Q24=_20_hheave
gen Q25= _20_hhsparkchimneys
gen Q26=_20_hhventsmmesh
gen Q27= _20_hhskirtingdecks


gen Q28=_20_c5HLA 
gen Q29= _20_c6LLA
gen Q30=_20_c7LRP 


gen Q31=_20_novalue1 
gen Q32= _20_notachieved1
gen Q33=_20_smallrisk1

gen Q34=_20_prognovalue1 
gen Q35= _20_dontbelieve1
gen Q36=_20_smallriskchange1 



/* model including Biophysical variables */


doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl wind aspect slope elevdiff lghtn

summarize  baselinerisk, meanonly
scalar baselinerisk_m=r(mean)
summarize  riskreduction  , meanonly
scalar riskreduction_m=r(mean)
summarize   yearspan, meanonly
scalar   yearspan_m=r(mean)
summarize  loss1000  , meanonly
scalar loss1000_m=r(mean)


summarize  landmanagement_BP, meanonly
scalar landmanagement_BP_m=r(mean)
summarize  CommWFPlanning_BP, meanonly
scalar CommWFPlanning_BP_m=r(mean)
summarize  CommAttachment_BP , meanonly
scalar CommAttachment_BP_m=r(mean)
summarize  govtpolicyFSI_BP, meanonly
scalar govtpolicyFSI_BP_m=r(mean)
summarize  utilityAP_BP, meanonly
scalar utilityAP_BP_m=r(mean)
summarize  privateprogramvalue_PRP, meanonly
scalar  privateprogramvalue_PRP_m=r(mean)
summarize  HouseholdFSI_BP  , meanonly
scalar HouseholdFSI_BP_m=r(mean)




summarize _20_noafford1, meanonly
scalar _20_noafford1_m=r(mean)
summarize  _20_allcovered1, meanonly
scalar _20_allcovered1_m=r(mean)
summarize  _20_altruism1, meanonly
scalar  _20_altruism1_m=r(mean)


summarize  incNT, meanonly
scalar incNT_m=r(mean)
summarize  _50_agehome , meanonly
scalar _50_agehome_m=r(mean)
summarize  _45_age, meanonly
scalar  _45_age_m=r(mean)
summarize  _65_fire_risk , meanonly
scalar _65_fire_risk_m=r(mean)
summarize _70_efficacy, meanonly
scalar  _70_efficacy_m=r(mean)
summarize  _60_rtol , meanonly
scalar _60_rtol_m=r(mean)
summarize  hhvl , meanonly
scalar hhvl_m=r(mean)



summarize  wind, meanonly
scalar wind_m=r(mean)
summarize  aspect , meanonly
scalar aspect_m=r(mean)
summarize  slope, meanonly
scalar slope_m=r(mean)
summarize  elevdiff , meanonly
scalar elevdiff_m=r(mean)
summarize  lghtn, meanonly
scalar lghtn_m=r(mean)


nlcom (WTP:(_b[_cons])), noheader
nlcom (WTP:(baselinerisk_m*_b[baselinerisk])), noheader
nlcom (WTP:(riskreduction_m*_b[riskreduction])), noheader
nlcom (WTP:(loss1000_m*_b[loss1000])), noheader
nlcom (WTP:(yearspan_m*_b[yearspan])), noheader

nlcom (WTP:(landmanagement_BP_m*_b[landmanagement_BP])), noheader
nlcom (WTP:(CommWFPlanning_BP_m*_b[CommWFPlanning_BP])), noheader
nlcom (WTP:(CommAttachment_BP_m*_b[CommAttachment_BP])), noheader

nlcom (WTP:(govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP])), noheader
nlcom (WTP:(utilityAP_BP_m*_b[utilityAP_BP])), noheader
nlcom (WTP:(HouseholdFSI_BP_m*_b[HouseholdFSI_BP])), noheader
nlcom (WTP:(privateprogramvalue_PRP_m*_b[privateprogramvalue_PRP])), noheader


nlcom (WTP:(_20_noafford1_m*_b[_20_noafford1])), noheader
nlcom (WTP:(_20_allcovered1_m*_b[_20_allcovered1])), noheader
nlcom (WTP:(_20_altruism1_m*_b[_20_altruism1])), noheader
nlcom (WTP:(incNT_m*_b[incNT])), noheader

nlcom (WTP:(_50_agehome_m*_b[_50_agehome])), noheader
nlcom (WTP:(_45_age_m*_b[_45_age])), noheader
nlcom (WTP:(_60_rtol_m*_b[_60_rtol])), noheader
nlcom (WTP:(_65_fire_risk_m*_b[_65_fire_risk ])), noheader
nlcom (WTP:(_70_efficacy_m*_b[_70_efficacy])), noheader
nlcom (WTP:(hhvl_m*_b[hhvl])), noheader


nlcom (WTP:(wind_m*_b[wind])), noheader
nlcom (WTP:(aspect_m*_b[aspect])), noheader
nlcom (WTP:(slope_m*_b[slope])), noheader
nlcom (WTP:(elevdiff_m*_b[elevdiff ])), noheader
nlcom (WTP:(lghtn_m*_b[lghtn])), noheader



doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 _60_rtol _65_fire_risk _70_efficacy incNT _50_agehome _45_age  hhvl wind aspect slope elevdiff lghtn


summarize  baselinerisk, meanonly
scalar baselinerisk_m=r(mean)
summarize  riskreduction  , meanonly
scalar riskreduction_m=r(mean)
summarize   yearspan, meanonly
scalar   yearspan_m=r(mean)



summarize  landmanagement_BP, meanonly
scalar landmanagement_BP_m=r(mean)
summarize  CommWFPlanning_BP, meanonly
scalar CommWFPlanning_BP_m=r(mean)
summarize  CommAttachment_BP , meanonly
scalar CommAttachment_BP_m=r(mean)
summarize  govtpolicyFSI_BP, meanonly
scalar govtpolicyFSI_BP_m=r(mean)
summarize  utilityAP_BP, meanonly
scalar utilityAP_BP_m=r(mean)
summarize  HouseholdFSI_BP  , meanonly
scalar HouseholdFSI_BP_m=r(mean)
summarize  publicprogramvalue_PUP , meanonly
scalar  publicprogramvalue_PUP_m=r(mean)



summarize _20_cannotafford1, meanonly
scalar _20_cannotafford1_m=r(mean)
summarize  _20_insurancecoveredall1 , meanonly
scalar _20_insurancecoveredall1_m=r(mean)
summarize   _20_altrusimpub1, meanonly
scalar   _20_altrusimpub1_m=r(mean)
summarize  _20_ownpropertydfs1  , meanonly
scalar _20_ownpropertydfs1_m=r(mean)


summarize  incNT, meanonly
scalar incNT_m=r(mean)
summarize  _50_agehome , meanonly
scalar _50_agehome_m=r(mean)
summarize  _45_age, meanonly
scalar  _45_age_m=r(mean)
summarize  _65_fire_risk , meanonly
scalar _65_fire_risk_m=r(mean)
summarize _70_efficacy, meanonly
scalar  _70_efficacy_m=r(mean)
summarize  _60_rtol , meanonly
scalar _60_rtol_m=r(mean)
summarize  hhvl , meanonly
scalar hhvl_m=r(mean)

summarize  wind, meanonly
scalar wind_m=r(mean)
summarize  aspect , meanonly
scalar aspect_m=r(mean)
summarize  slope, meanonly
scalar slope_m=r(mean)
summarize  elevdiff , meanonly
scalar elevdiff_m=r(mean)
summarize  lghtn, meanonly
scalar lghtn_m=r(mean)


nlcom (WTP:(_b[_cons])), noheader
nlcom (WTP:(baselinerisk_m*_b[baselinerisk])), noheader
nlcom (WTP:(riskreduction_m*_b[riskreduction])), noheader
nlcom (WTP:(yearspan_m*_b[yearspan])), noheader

nlcom (WTP:(landmanagement_BP_m*_b[landmanagement_BP])), noheader
nlcom (WTP:(CommWFPlanning_BP_m*_b[CommWFPlanning_BP])), noheader
nlcom (WTP:(CommAttachment_BP_m*_b[CommAttachment_BP])), noheader

nlcom (WTP:(govtpolicyFSI_BP_m*_b[govtpolicyFSI_BP])), noheader
nlcom (WTP:(utilityAP_BP_m*_b[utilityAP_BP])), noheader
nlcom (WTP:(HouseholdFSI_BP_m*_b[HouseholdFSI_BP])), noheader
nlcom (WTP:(publicprogramvalue_PUP_m*_b[publicprogramvalue_PUP])), noheader


nlcom (WTP:(_20_cannotafford1_m*_b[_20_cannotafford1])), noheader
nlcom (WTP:(_20_insurancecoveredall1_m*_b[_20_insurancecoveredall1])), noheader
nlcom (WTP:(_20_altrusimpub1_m*_b[_20_altrusimpub1])), noheader
nlcom (WTP:(_20_ownpropertydfs1_m*_b[_20_ownpropertydfs1])), noheader


nlcom (WTP:(incNT_m*_b[incNT])), noheader
nlcom (WTP:(_50_agehome_m*_b[_50_agehome])), noheader
nlcom (WTP:(_45_age_m*_b[_45_age])), noheader
nlcom (WTP:(_60_rtol_m*_b[_60_rtol])), noheader
nlcom (WTP:(_65_fire_risk_m*_b[_65_fire_risk ])), noheader
nlcom (WTP:(_70_efficacy_m*_b[_70_efficacy])), noheader
nlcom (WTP:(hhvl_m*_b[hhvl])), noheader


nlcom (WTP:(wind_m*_b[wind])), noheader
nlcom (WTP:(aspect_m*_b[aspect])), noheader
nlcom (WTP:(slope_m*_b[slope])), noheader
nlcom (WTP:(elevdiff_m*_b[elevdiff ])), noheader
nlcom (WTP:(lghtn_m*_b[lghtn])), noheader





/* Model estiamtion graph date 11/25/2020******************/

doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl wind aspect slope elevdiff lghtn

predict yhat, xb 


doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 _60_rtol _65_fire_risk _70_efficacy incNT _50_agehome _45_age  hhvl wind aspect slope elevdiff lghtn

predict nhat, xb 
gen pubhat=nhat*yearspan



twoway histogram yhat || kdensity yhat
twoway histogram pubhat || kdensity pubhat

cdfplot yhat, norm
cdfplot pubhat, norm


describe yhat 
hist yhat 
cumul yhat, gen(cyhat) equal 
line cyhat yhat, sort 

describe pubhat 
hist pubhat 
cumul pubhat, gen(cpubhat) equal 
line cpubhat pubhat, sort 



stack cyhat yhat cpubhat pubhat, into (c WTP) wide clear 
line cyhat cpubhat WTP, sort 


histogram bid1, percent width (500) start(0) by(response1)

histogram bid1, freq width (500)start(0) by(response1) 
histogram bid2, freq width (500) start(0) by(response2)

histogram bid3, freq width (20) start(0) by(response3)
histogram bid4, freq width (20)  start(0) by(response4)

spikeplot bid4, by(response4)

gladder bid1, fraction
graph box bid1, over(response1)
histogram  bid1, frequency normal
sunflower bid1 response1
graph box bid1, over(response1) horizontal
histogram bid1, frequency  kdensity

tab2 bid1 response1, chi2
oneway bid1 response1, tabulate
ttest bid1, by(response1)

kdensity income if response1==1
kdensity income if response1 == 1, addplot(kdensity income if response1 == 0)
kdensity bid1 if response1==1
kdensity bid1 if response1 == 1, addplot(kdensity bid1 if response1 == 0)

kdensity yhat, addplot(kdensity pubhat)


histogram bid1, discrete width(300) start(0) frequency by(response1)


twoway histogram bid1, bin(16) freq by(response1) 
twoway histogram bid1, bin(16) by(response1) 


/* date 20th July 2021 */
/* Margianl WTP analysis*/



doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl wind aspect slope elevdiff lghtn

predict yhat, xb 

/* Reduction private versus public */ 
tabstat yhat, by (p1_pct)
tabstat yhat, by (pr_loss_year)
tabstat yhat, by (riskreduction)

tabstat pubhat, by (p1_pct)
tabstat pubhat, by (pr_loss_year)
tabstat pubhat, by (riskreduction)

/* loss amont private program */
tabstat yhat, by (pr_loss)
tabstat yhat, by (loss)


/* INCOME FOR private versus public */ 
tabstat yhat, by (IncomeThousand)
tabstat yhat, by (inc)
tabstat yhat, by (incNT)

tabstat pubhat, by (IncomeThousand)
tabstat pubhat, by (inc)
tabstat pubhat, by (incNT)


/* Altruism */

tabstat yhat, by (_20_altruism1)
tabstat pubhat, by (_20_altruism1)

/*Land Managemnt */

tabstat yhat, by (landmanagement_BP)
tabstat pubhat, by (landmanagement_BP)


/* Who cannot afford the cost */

tabstat yhat, by (_20_noafford1)
tabstat pubhat, by (_20_noafford1)


/* covered by insurnce */

tabstat yhat, by (_20_allcovered1)
tabstat pubhat, by (_20_allcovered1)




tabstat yhat, by (_55_age)
tabstat yhat, by (_55_agehome)
tabstat yhat, by (_60_rtol)
tabstat yhat, by (_65_fire_risk)
tabstat yhat, by (_70_efficacy)

tabstat yhat, by (_20_allcovered1)
tabstat yhat, by (_20_noafford1)




tabstat yhat, by (_20_protectvoluntary)

tabstat yhat, by (riskreduction)

predict e, res


tabstat yhat, by (yearspan)
tabstat pubhat, by (yearspan)


mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)



doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan5 landmanagement_BP CommWFPlanning_BP NeighborsEffect_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 IncomeThousand _55_agehome _55_age _60_rtol _65_fire_risk _70_efficacy 

predict nhat, xb 
tabstat nhat, by (p1_pct)
tabstat nhat, by (pr_loss_year)
tabstat nhat, by (pr_loss)

tabstat nhat, by (IncomeThousand)
tabstat nhat, by (_55_age)
tabstat nhat, by (_55_agehome)
tabstat nhat, by (_60_rtol)
tabstat nhat, by (_65_fire_risk)
tabstat nhat, by (_70_efficacy)

tabstat nhat, by (_20_insurancecoveredall1)
tabstat nhat, by (_20_cannotafford1)
tabstat nhat, by (_20_altrusimpub1)
tabstat nhat, by ( _20_ownpropertydfs1)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)

estimate store model1
estimate store model2
 
esttab model1 model2 using modelcomb1.rtf, replace 



/* 10-29-2020 Analysis */

/* stata word file model combine */



doubleb bid1 bid2 response1 response2  baselinerisk  riskreduction loss1000  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  privateprogramvalue_PRP _20_noafford1 _20_allcovered1 _20_altruism1 incNT _50_agehome _45_age _60_rtol _65_fire_risk _70_efficacy hhvl wind aspect slope elevdiff lghtn

predict yhat, xb 

margins 
marginsplot
marginsplot, recast(bar)

margins, at(_45_age=(25(5)95))
marginsplot, name (margin1, replace)
marginsplot, recast(line) recastci(rarea) name (margin2, replace)

margins, at(_45_age=(25(5)95))
marginsplot, name (margin3, replace)

margins, at(_50_agehome =(1(5)30))
marginsplot, name (margin4, replace)

margins, at(incNT =(10(10)250))
marginsplot, name (margin5, replace)

margins, at(hhvl =(5(1)17 ))
marginsplot, name (margin6, replace)

margins, at(_20_noafford1 =(0(1)1))
marginsplot, name (margin7, replace)

margins, at(_60_rtol =(.203 .228 .257 .301))
marginsplot, name (margin8, replace)

margins, at(_65_fire_risk  =(0(.10)1))
marginsplot, name (margin9, replace)

margins, at(_70_efficacy  =(0(.10)1))
marginsplot, name (margin10, replace)


margins, at(loss1000  =(50 100 200))
marginsplot, name (margin11, replace)

margins, at(yearspan  =(5 10))
marginsplot, name (margin12, replace)

margins, at(riskreduction =(1 2 4))
marginsplot, name (margin13, replace)

margins, at(riskreduction =(1 (.5) 4))
marginsplot, name (margin14, replace)


margins, at(landmanagement_BP =(-1.971107 (.5)  2.760681))
marginsplot, name (margin15, replace)

margins, at(CommWFPlanning_BP   =( -2.045  (.5)   2.33771))
marginsplot, name (margin16, replace)




predict yhat, xb 

tabstat yhat, by (p1_pct)
tabstat yhat, by (pr_loss_year)
tabstat yhat, by (pr_loss)
tabstat yhat, by (loss)

tabstat yhat, by (IncomeThousand)
tabstat yhat, by (inc)

tabstat yhat, by (_45_age)
tabstat yhat, by (_50_agehome)
tabstat yhat, by (_60_rtol)
tabstat yhat, by (_65_fire_risk)
tabstat yhat, by (_70_efficacy)

tabstat yhat, by (_20_allcovered1)
tabstat yhat, by (_20_noafford1)
tabstat yhat, by (_20_altruism1)



/* Risk Reduction Private Vs Public*/

tabstat yhat, by (riskreduction)
tabstat pubhat, by (riskreduction)
margins, at(riskreduction =(1 2 4 ))

/* Income WTP across public and Private Program */
tabstat yhat, by (incNT)
tabstat pubhat, by (incNT)
margins, at(incNT =(10 19.999  29.999 42.499 62.499 87.499  124.999 174.999 250))

/* HHVl WTP across public and Private Program */
tabstat yhat, by (hhvl)
tabstat pubhat, by (hhvl)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)



doubleb bid3 bid4 response3 response4  baselinerisk  riskreduction  yearspan landmanagement_BP CommWFPlanning_BP CommAttachment_BP govtpolicyFSI_BP utilityAP_BP  HouseholdFSI_BP  publicprogramvalue_PUP _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1 _60_rtol _65_fire_risk _70_efficacy incNT _50_agehome _45_age  hhvl 

predict nhat, xb 
gen pubhat=nhat*5

tabstat nhat, by (p1_pct)
tabstat pubhat, by (p1_pct)

tabstat nhat, by (pr_loss_year)
tabstat nhat, by (pr_loss)

tabstat pubhat, by (incNT)
tabstat nhat, by (incNT)

tabstat nhat, by (_55_age)
tabstat nhat, by (_55_agehome)
tabstat nhat, by (_60_rtol)
tabstat nhat, by (_65_fire_risk)
tabstat nhat, by (_70_efficacy)

tabstat nhat, by (_20_insurancecoveredall1)
tabstat nhat, by (_20_cannotafford1)
tabstat nhat, by (_20_altrusimpub1)
tabstat nhat, by ( _20_ownpropertydfs1)



mat r2=r(table)
mat list r2
margins, dydx(*) atmeans
margins
mfx, predict(xb) tracelvl(2)

estimate store model1
estimate store model2
 
esttab model1 model2 using modelcomb1.rtf, replace 

