 
use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\testdataset_thesis.dta" 


/*Final do file STATA  */

/*Risk Reduction, Baseline Risk and damages Public and Private Program */

*******/** Baseline Risk***************/*****

tab1 p1_pct
tabulate p1_pct, gen(dum)

rename  dum1 br10
rename  dum2 br2
rename  dum3  br3
rename  dum4 br6
rename  dum5  br8


sum br10 br2 br3 br6 br8

/* baseline risk */ 
gen baselinerisk = . 
replace baselinerisk = 2 if  br2  == 1 
replace baselinerisk = 3 if  br3  == 1 
replace baselinerisk = 6 if  br6  == 1 
replace baselinerisk = 8 if  br8  == 1
replace baselinerisk = 10 if br10 == 1 

/*dummy for probability of risk reduction*/

tab1 pr_loss  
tabulate pr_loss, gen (dum)

rename  dum1 prd106
rename  dum2 prd109
rename  dum3  prd21
rename  dum4 prd31
rename  dum5  prd62 
rename  dum6 prd86

sum prd106 prd109 prd21 prd31 prd62 prd86 
tab1 prd106 prd109 prd21 prd31 prd62 prd86


gen riskreduction = . 
replace riskreduction = 4 if prd106 == 1 
replace riskreduction = 1 if prd109 == 1 
replace riskreduction = 1 if prd21 == 1 
replace riskreduction = 2 if prd31 == 1
replace riskreduction = 4 if prd62 == 1 
replace riskreduction = 2 if prd86 == 1 



******To put this into perspective, this translates into reducing the
*** probability that a wildfire will damage your property sometime in the 5 year period 
****from 27% to 10%.tab1 pr_loss_year*****


tabulate pr_loss_year, gen (dum)

rename  dum1 ply105
rename  dum2 ply145
rename  dum3  ply2710
rename  dum4 ply3427
rename  dum5  ply4127 
rename  dum6 ply4138

sum ply105 ply145 ply2710 ply3427  ply4127 ply4138


/* dummy for year span */
tab1 yearspan
tabulate yearspan, gen(dum)

rename  dum1 yearspan5
rename  dum2 yearspan10

sum yearspan5 yearspan10


/* dummy for loss for private program*/
tab1 loss
tabulate loss, gen(dum)

rename  dum1 prloss50K
rename  dum2 prloss100k
rename  dum3  prloss200k

sum prloss50K prloss100k prloss200k
tab1 prloss50K prloss100k prloss200k


/* Summary Statistics*/
***********************


estpost sum  br10 br2 br3 br6 br8 prd106 prd109 prd21 prd31 prd62 prd86 yearspan5 yearspan10

sum yearspan5 yearspan10



** ************private and public bid ammount******************************
tab1 pribid1 pribid2 pribid3 pribid4 pribid5 pribid6
tab1 pubbid1 pubbid2 pubbid3 pubbid4 pubbid5 pubbid6
*****************/*private program*/****************************************
******************************************************************************
*****************************************************************************




/* generate variables for private program, affectr answer about WTP questions*/


/* I cannot afford the cost*/

gen noafford = fx_prv_1
recode noafford (0=0) (1=25) (2=50) (3=75) (4=100)
label define noafford 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen noafford1 = . 
replace noafford1 = 1 if noafford == 75 | noafford == 100 
replace noafford1 = 0 if  noafford == 0 | noafford == 25 | noafford == 50

tab1 noafford
tab1 fx_prv_1

sum noafford
sum fx_prv_1

**Reducing risk by this much is not valuableto me***


gen novalue = fx_prv_2
recode novalue (0=0) (1=25) (2=50) (3=75) (4=100)
label define novalue 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen novalue1 = . 
replace novalue1 = 1 if novalue == 75 | novalue == 100 
replace novalue1 = 0 if  novalue == 0 | novalue == 25 | novalue == 50


tab1 novalue
tab1 fx_prv_2

sum novalue
sum fx_prv_2


***I wouldn’t want to lose my house to wildfire if I can prevent it**

gen prevent = fx_prv_3
recode prevent (0=0) (1=25) (2=50) (3=75) (4=100)
label define prevent 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen prevent1 = . 
replace prevent1= 1 if prevent == 75 | prevent== 100 
replace prevent1= 0 if  prevent == 0 | prevent == 25 | prevent == 50

tab1 prevent
tab1 fx_prv_3

sum prevent
sum fx_prv_3


****I don’t believe that the risk reduction would be achieved****
gen notachieved = fx_prv_4
recode notachieved  (0=0) (1=25) (2=50) (3=75) (4=100)
label define notachieved  0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen notachieved1= . 
replace notachieved1= 1 if notachieved == 75 | notachieved== 100 
replace notachieved1= 0 if  notachieved == 0 | notachieved == 25 | notachieved == 50


tab1 notachieved 
tab1 fx_prv_4

sum notachieved 
sum fx_prv_4

 ***I would not create defensible space on my property in this situation even if it cost me nothing***
gen costnothing = fx_prv_5
recode costnothing  (0=0) (1=25) (2=50) (3=75) (4=100)
label define costnothing   0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen costnothing1= . 
replace costnothing1 = 1 if costnothing== 75 | costnothing== 100 
replace costnothing1 = 0 if  costnothing == 0 | costnothing == 25 | costnothing == 50


tab1 costnothing 
tab1 fx_prv_5

sum costnothing 
sum fx_prv_5

***Thesechanges in riskare too small to matter to me***

gen smallrisk=fx_prv_6
recode smallrisk  (0=0) (1=25) (2=50) (3=75) (4=100)
label define smallrisk   0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen smallrisk1= . 
replace smallrisk1 = 1 if smallrisk == 75 | smallrisk == 100 
replace smallrisk1 = 0 if  smallrisk == 0 | smallrisk == 25 | smallrisk == 50


tab1 smallrisk
tab1 fx_prv_6

sum smallrisk
sum fx_prv_6

*****My insurance would cover anything I might lose from wildfire******

gen allcovered=fx_prv_7
recode allcovered  (0=0) (1=25) (2=50) (3=75) (4=100)
label define allcovered   0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen allcovered1= . 
replace allcovered1 = 1 if allcovered == 75 | allcovered == 100 
replace allcovered1 = 0 if allcovered == 0 | allcovered == 25 | allcovered == 50


tab1 allcovered
tab1 fx_prv_7

sum allcovered
sum fx_prv_7

**I might move before having the full benefits****

gen movebenefit=fx_prv_8
recode movebenefit (0=0) (1=25) (2=50) (3=75) (4=100)
label define movebenefit  0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen movebenefit1= . 
replace movebenefit1 = 1 if movebenefit == 75 | movebenefit == 100 
replace movebenefit1 = 0 if movebenefit == 0 | movebenefit == 25 | movebenefit == 50


tab1 movebenefit
tab1 fx_prv_8

sum movebenefit
sum fx_prv_8

****I value the peace of mind from reducing risk of wildfire ******
gen peacemind=fx_prv_9
recode  peacemind(0=0) (1=25) (2=50) (3=75) (4=100)
label define  peacemind 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen peacemind1= . 
replace peacemind1 = 1 if peacemind == 75 | peacemind == 100 
replace peacemind1 = 0 if peacemind == 0 | peacemind == 25 |peacemind == 50


tab1  peacemind
tab1 fx_prv_9

sum  peacemind
sum fx_prv_9

**My actions would reduce the risk of fire spreading to other homes*****

gen altruism=fx_prv_10
recode  altruism(0=0) (1=25) (2=50) (3=75) (4=100)
label define  altruism 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen altruism1= . 
replace altruism1 = 1 if altruism == 75 | altruism == 100 
replace altruism1 = 0 if altruism == 0 | altruism == 25 |altruism  == 50

tab1  altruism
tab1 fx_prv_10

sum  altruism
sum fx_prv_10

***I could not afford losing this much from a fire************
gen notaffloss=fx_prv_11
recode  notaffloss(0=0) (1=25) (2=50) (3=75) (4=100)
label define  notaffloss 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen notaffloss1= . 
replace notaffloss1 = 1 if notaffloss == 75 | notaffloss == 100 
replace notaffloss1 = 0 if notaffloss == 0 | notaffloss == 25 |notaffloss  == 50

tab1  notaffloss
tab1 fx_prv_11

sum  notaffloss
sum fx_prv_11


sum noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1



*****************/*public or community program*/*****************************
******************************************************************************
*****************************************************************************

**I cannot afford the cost***
gen cannotafford = fx_pub_1
recode cannotafford (0=0) (1=25) (2=50) (3=75) (4=100)
label define cannotafford 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen cannotafford1= . 
replace cannotafford1 = 1 if cannotafford == 75 | cannotafford == 100 
replace cannotafford1 = 0 if cannotafford == 0 | cannotafford == 25 |cannotafford  == 50


tab1 cannotafford
tab1 fx_pub_1

sum cannotafford
sum fx_pub_1

***This program has no value to me*****
gen prognovalue = fx_pub_2
recode prognovalue (0=0) (1=25) (2=50) (3=75) (4=100)
label define prognovalue 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"


gen prognovalue1= . 
replace prognovalue1 = 1 if prognovalue == 75 | prognovalue == 100 
replace prognovalue1 = 0 if prognovalue == 0 | prognovalue == 25 |prognovalue  == 50

tab1 prognovalue
tab1 fx_pub_2

sum prognovalue
sum fx_pub_2

****I like that the program reduces risk to the entire community***

gen altrusimpub = fx_pub_3
recode altrusimpub (0=0) (1=25) (2=50) (3=75) (4=100)
label define altrusimpub 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"


gen altrusimpub1= . 
replace altrusimpub1 = 1 if altrusimpub == 75 | altrusimpub == 100 
replace altrusimpub1 = 0 if altrusimpub == 0 |altrusimpub == 25 |altrusimpub  == 50


tab1 altrusimpub
tab1 fx_pub_3

sum altrusimpub
sum fx_pub_3

**I don’t believe that the work would be done****

gen dontbelieve = fx_pub_4
recode dontbelieve   (0=0) (1=25) (2=50) (3=75) (4=100)
label define dontbelieve  0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen dontbelieve1= . 
replace dontbelieve1 = 1 if dontbelieve == 75 | dontbelieve == 100 
replace dontbelieve1 = 0 if dontbelieve == 0 |dontbelieve == 25 |dontbelieve == 50


tab1 dontbelieve 
tab1 fx_pub_4

sum dontbelieve 
sum fx_pub_4

 ***I prefer to spend the money on defensible space for my own property****
gen ownpropertydfs = fx_pub_5
recode ownpropertydfs (0=0) (1=25) (2=50) (3=75) (4=100)
label define ownpropertydfs   0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"


gen ownpropertydfs1= . 
replace ownpropertydfs1 = 1 if ownpropertydfs == 75 | ownpropertydfs == 100 
replace ownpropertydfs1 = 0 if ownpropertydfs == 0 |ownpropertydfs == 25 |ownpropertydfs == 50


tab1 ownpropertydfs
tab1 fx_pub_5

sum ownpropertydfs
sum fx_pub_5

***The changes in risk due to the program are too small to matter to me***

gen smallriskchange=fx_pub_6
recode smallriskchange  (0=0) (1=25) (2=50) (3=75) (4=100)
label define smallriskchange  0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen smallriskchange1= . 
replace smallriskchange1 = 1 if smallriskchange == 75 | smallriskchange == 100 
replace smallriskchange1 = 0 if smallriskchange == 0 |smallriskchange == 25 |smallriskchange == 50


tab1 smallriskchange
tab1 fx_pub_6

sum smallriskchange
sum fx_pub_6
**8This is important to me***

gen important=fx_pub_7
recode important (0=0) (1=25) (2=50) (3=75) (4=100)
label define important   0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen important1= . 
replace important1 = 1 if important == 75 | important == 100 
replace important1 = 0 if important == 0 |important == 25 |important == 50


tab1 important
tab1 fx_pub_7

sum important
sum fx_pub_7

***I wouldn’t want to lose my house to wildfire if I can prevent it****

gen preventpub=fx_pub_8
recode preventpub (0=0) (1=25) (2=50) (3=75) (4=100)
label define preventpub  0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen preventpub1= . 
replace preventpub1 = 1 if preventpub == 75 | preventpub == 100 
replace preventpub1 = 0 if preventpub == 0 |preventpub == 25 |preventpub == 50


tab1 preventpub
tab1 fx_pub_8

sum preventpub
sum fx_pub_8

***I might move before realizing the full benefits of the program***
gen movebeforebenefit=fx_pub_9
recode  movebeforebenefit(0=0) (1=25) (2=50) (3=75) (4=100)
label define  movebeforebenefit 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen movebeforebenefit1= . 
replace movebeforebenefit1 = 1 if movebeforebenefit == 75 | movebeforebenefit == 100 
replace movebeforebenefit1 = 0 if movebeforebenefit == 0 |movebeforebenefit == 25 |movebeforebenefit == 50

tab1  movebeforebenefit
tab1 fx_pub_9

sum  movebeforebenefit
sum fx_pub_9

****My insurance would cover anything I might lose from wildfire *****

gen insurancecoveredall=fx_pub_10
recode  insurancecoveredall(0=0) (1=25) (2=50) (3=75) (4=100)
label define  insurancecoveredall 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen insurancecoveredall1= . 
replace insurancecoveredall1 = 1 if insurancecoveredall == 75 | insurancecoveredall == 100 
replace insurancecoveredall1 = 0 if insurancecoveredall == 0 |insurancecoveredall == 25 |insurancecoveredall == 50


tab1  insurancecoveredall
tab1 fx_pub_10

sum  insurancecoveredall
sum fx_pub_10

***I value the peace of mind from reducing risk of wildfire ********

gen peacemindpub=fx_pub_11
recode  peacemindpub(0=0) (1=25) (2=50) (3=75) (4=100)
label define  peacemindpub 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen peacemindpub1= . 
replace peacemindpub1 = 1 if peacemindpub == 75 | peacemindpub == 100 
replace peacemindpub1 = 0 if peacemindpub == 0 |peacemindpub == 25 |peacemindpub == 50


tab1  peacemindpub
tab1 fx_pub_11

sum  peacemindpub
sum fx_pub_11

***This might cause conflict in the community**********
gen conflictcommunity=fx_pub_12
recode  conflictcommunity(0=0) (1=25) (2=50) (3=75) (4=100)
label define  conflictcommunity 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen conflictcommunity1= . 
replace conflictcommunity1 = 1 if conflictcommunity == 75 | conflictcommunity == 100 
replace conflictcommunity1 = 0 if conflictcommunity == 0 |conflictcommunity == 25 |conflictcommunity == 50


tab1  conflictcommunity
tab1 fx_pub_12

sum  conflictcommunity
sum fx_pub_12

sum cannotafford prognovalue altrusimpub dontbelieve ownpropertydfs smallriskchange important preventpub movebeforebenefit insurancecoveredall peacemindpub conflictcommunity

sum cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 important1 preventpub1 movebeforebenefit1 insurancecoveredall1 peacemindpub1 conflictcommunity1


*******************/******Community Engagement **********/***************
*************************************************************************
***************************************************************************

sum feel_1 feel_2 agree_1 agree_3 agree_5 agree_7
sum network_2 network_3 network_5 network_6 network_7
sum more_7 more_5 more_1 more_2 

***I am very attached to this community*****
gen commatt_1=feel_1
recode commatt_1 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_1 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commatt_11= . 
replace commatt_11 = 1 if commatt_1 == 75 | commatt_1 == 100 
replace commatt_11 = 0 if commatt_1 == 0 |commatt_1 == 25 |commatt_1 == 50


****I identify strongly with this community.*************
gen commatt_2=feel_2
recode commatt_2 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_2 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"


gen commatt_21= . 
replace commatt_21 = 1 if commatt_2 == 75 | commatt_2 == 100 
replace commatt_21 = 0 if commatt_2 == 0 |commatt_2 == 25 |commatt_2 == 50

*****No other place can compare to this community**********

gen commatt_3=feel_3
recode commatt_3 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_3 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"


gen commatt_31= . 
replace commatt_31 = 1 if commatt_3 == 75 | commatt_3 == 100 
replace commatt_31 = 0 if commatt_3 == 0 |commatt_3 == 25 |commatt_3 == 50

****This community is the best place for me to live************

gen commatt_4=feel_4
recode commatt_4 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_4 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commatt_41= . 
replace commatt_41 = 1 if commatt_4 == 75 | commatt_4 == 100 
replace commatt_41 = 0 if commatt_4 == 0 |commatt_4 == 25 |commatt_4 == 50

****This is a tight-knit community*****************
gen commatt_5=feel_5
recode commatt_5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_5 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commatt_51= . 
replace commatt_51 = 1 if commatt_5 == 75 | commatt_5 == 100 
replace commatt_51 = 0 if commatt_5 == 0 |commatt_5 == 25 |commatt_5 == 50

***I know the names of all my neighbors************
gen commatt_6=feel_6
recode commatt_6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_6 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commatt_61= . 
replace commatt_61 = 1 if commatt_6 == 75 | commatt_6 == 100 
replace commatt_61 = 0 if commatt_6 == 0 |commatt_6 == 25 |commatt_6 == 50

****I know my nearest neighbors well***************
gen commatt_7=feel_7
recode commatt_7 (0=0) (1=25) (2=50) (3=75) (4=100)
label define ccommatt_7 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commatt_71= . 
replace commatt_71 = 1 if commatt_7 == 75 | commatt_7 == 100 
replace commatt_71 = 0 if commatt_7 == 0 |commatt_7 == 25 |commatt_7 == 50


sum commatt_1 commatt_2 commatt_3 commatt_4 commatt_5 commatt_6 commatt_7
sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_61 commatt_71


*************/*In your community …...*/ ***************************************
********************************************************************************

/*Would people listen to you if you were to try to persuade them to reduce wildfire threat to their homes? */


gen commnetwork1=network_1
recode commnetwork1 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork1 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork11= . 
replace commnetwork11 = 1 if commnetwork1 == 75 | commnetwork1 == 100 
replace commnetwork11 = 0 if commnetwork1 == 0 |commnetwork1 == 25 |commnetwork1== 50

/*Have there been many community events/meetings about fire risk?*/ 

gen commnetwork2=network_2
recode commnetwork2 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork2 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork21= . 
replace commnetwork21 = 1 if commnetwork2 == 75 | commnetwork2 == 100 
replace commnetwork21 = 0 if commnetwork2 == 0 |commnetwork2 == 25 |commnetwork2== 50

/*Have you attended many of these events?*/

gen commnetwork3=network_3
recode commnetwork3 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork3 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork31= . 
replace commnetwork31 = 1 if commnetwork3 == 75 | commnetwork3 == 100 
replace commnetwork31 = 0 if commnetwork3 == 0 |commnetwork3 == 25 |commnetwork3== 50

/*Did many of your neighbors go? */

gen commnetwork4=network_4
recode commnetwork4 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork4 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork41= . 
replace commnetwork41 = 1 if commnetwork4 == 75 | commnetwork4 == 100 
replace commnetwork41 = 0 if commnetwork4 == 0 |commnetwork4 == 25 |commnetwork4== 50

/*Have you and your neighbors discussed coordinating to reduce fire risk?*/
gen commnetwork5=network_5
recode commnetwork5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork5 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork51= . 
replace commnetwork51 = 1 if commnetwork5 == 75 | commnetwork5 == 100 
replace commnetwork51 = 0 if commnetwork5 == 0 |commnetwork5 == 25 |commnetwork5== 50

/*Have you coordinated actions to reduce fire risk with neighbors? */
gen commnetwork6=network_6
recode commnetwork6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork6 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork61= . 
replace commnetwork61 = 1 if commnetwork6 == 75 | commnetwork6 == 100 
replace commnetwork61 = 0 if commnetwork6 == 0 |commnetwork6 == 25 |commnetwork6== 50


/*Do you plan to coordinate defensible space with neighbors in the future?*/
gen commnetwork7=network_7
recode commnetwork7 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork7 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork71= . 
replace commnetwork71 = 1 if commnetwork7 == 75 | commnetwork7 == 100 
replace commnetwork71 = 0 if commnetwork7 == 0 |commnetwork7 == 25 |commnetwork7== 50

/*Is there general agreement among neighbors about wildfire risk? */
gen commnetwork8=network_8
recode commnetwork8 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork8 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork81= . 
replace commnetwork81 = 1 if commnetwork8 == 75 | commnetwork8 == 100 
replace commnetwork81 = 0 if commnetwork8 == 0 |commnetwork8 == 25 |commnetwork8== 50

/*Is there agreement about the need for taking action to reduce fire risk?*/
gen commnetwork9=network_9
recode commnetwork9 (0=0) (1=25) (2=50) (3=75) (4=100)
label define commnetwork9 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commnetwork91= . 
replace commnetwork91 = 1 if commnetwork9 == 75 | commnetwork9 == 100 
replace commnetwork91 = 0 if commnetwork9 == 0 |commnetwork9 == 25 |commnetwork9== 50

sum commnetwork11 commnetwork21 commnetwork31 commnetwork41 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91
sum commnetwork1 commnetwork2 commnetwork3 commnetwork4 commnetwork5 commnetwork6 commnetwork7 commnetwork8 commnetwork9
 
***********Do you agree… */**********************************************
***************************************************************************
/*Taking steps to protect one’s home from fire should be voluntary*/
gen protectvoluntary=agree_1
recode protectvoluntary (0=0) (1=25) (2=50) (3=75) (4=100)
label define protectvoluntary 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen protectvoluntary1= . 
replace protectvoluntary1 = 1 if protectvoluntary == 75 | protectvoluntary == 100 
replace protectvoluntary1 = 0 if protectvoluntary == 0 |protectvoluntary == 25 |protectvoluntary== 50

/*Homeowners should coordinate creating and maintaining defensible space*/
gen coordinatedfs=agree_5
recode  coordinatedfs (0=0) (1=25) (2=50) (3=75) (4=100)
label define  coordinatedfs 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  coordinatedfs1= . 
replace  coordinatedfs1 = 1 if  coordinatedfs == 75 | coordinatedfs == 100 
replace  coordinatedfs1 = 0 if  coordinatedfs == 0 | coordinatedfs == 25 | coordinatedfs== 50


/*Communities should invest more in education about defensible space*/
gen comminvestdfs=agree_7
recode  comminvestdfs (0=0) (1=25) (2=50) (3=75) (4=100)
label define comminvestdfs 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  comminvestdfs1= . 
replace comminvestdfs1 = 1 if comminvestdfs == 75 | comminvestdfs == 100 
replace  comminvestdfs1 = 0 if  comminvestdfs == 0 | comminvestdfs == 25 | comminvestdfs== 50

sum protectvoluntary protectvoluntary1 coordinatedfs coordinatedfs1 comminvestdfs comminvestdfs1

****/*Would you be more likely to work on defensible space if … */**********
*******************************************************************************

/*Your nearest neighbor does*/
gen nearneighbor=more_1
recode  nearneighbor (0=0) (1=25) (2=50) (3=75) (4=100)
label define  nearneighbor 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  nearneighbor1= . 
replace nearneighbor1 = 1 if nearneighbor == 75 | nearneighbor == 100 
replace nearneighbor1 = 0 if  nearneighbor == 0 |nearneighbor == 25 | nearneighbor== 50


/*Other neighbors do*/
gen otherneighbor=more_2
recode  otherneighbor (0=0) (1=25) (2=50) (3=75) (4=100)
label define  otherneighbor 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  otherneighbor1= . 
replace otherneighbor1 = 1 if otherneighbor == 75 |otherneighbor == 100 
replace otherneighbor1 = 0 if  otherneighbor == 0 |otherneighbor == 25 | otherneighbor== 50


/*Respected community members do*/

gen respcommmunity=more_3
recode  respcommmunity (0=0) (1=25) (2=50) (3=75) (4=100)
label define  respcommmunity 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  respcommmunity1= . 
replace respcommmunity1 = 1 if respcommmunity == 75 |respcommmunity == 100 
replace respcommmunity1 = 0 if  respcommmunity == 0 |respcommmunity == 25 | respcommmunity== 50

/*Family members living elsewhere do*/
gen familyelse=more_4
recode  familyelse(0=0) (1=25) (2=50) (3=75) (4=100)
label define  familyelse 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  familyelse1= . 
replace familyelse1 = 1 if familyelse == 75 |familyelse == 100 
replace familyelse1 = 0 if  familyelse == 0 |familyelse == 25 | familyelse== 50

/*You hear about people losing their homes to wildfire somewhere else*/

gen losehomeelse=more_5
recode  losehomeelse(0=0) (1=25) (2=50) (3=75) (4=100)
label define  losehomeelse 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  losehomeelse1= . 
replace losehomeelse1 = 1 if losehomeelse == 75 |losehomeelse == 100 
replace losehomeelse1 = 0 if  losehomeelse == 0 |losehomeelse == 25 | losehomeelse== 50

/*You knew where to start*/

gen knewstart=more_6
recode  knewstart(0=0) (1=25) (2=50) (3=75) (4=100)
label define knewstart 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  knewstart1= . 
replace knewstart1 = 1 if knewstart == 75 |knewstart == 100 
replace knewstart1 = 0 if  knewstart == 0 |knewstart == 25 | knewstart== 50

/*You knew which actions would be most effective for you*/
gen effactions=more_7
recode  effactions(0=0) (1=25) (2=50) (3=75) (4=100)
label define effactions 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen effactions1= . 
replace effactions1 = 1 if effactions == 75 |effactions == 100 
replace effactions1 = 0 if  effactions == 0 |effactions == 25 | effactions== 50

sum nearneighbor otherneighbor respcommmunity familyelse losehomeelse knewstart effactions
sum nearneighbor1 otherneighbor1 respcommmunity1 familyelse1 losehomeelse1 knewstart1 effactions1


****/*In your community, what do you think reduced wildfire risk in 2011?*/****
*******************************************************************************

/*Many residents take extensive defensible space actions*/
gen extensivedfs=reduce_1
recode  extensivedfs(0=0) (1=25) (2=50) (3=75) (4=100)
label define extensivedfs 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen extensivedfs1= . 
replace extensivedfs1 = 1 if extensivedfs == 75 |extensivedfs == 100 
replace extensivedfs1 = 0 if  extensivedfs == 0 |extensivedfs == 25 |extensivedfs== 50

/*Information provided by community groups about defensible space*/
gen informationdfs=reduce_2
recode  informationdfs(0=0) (1=25) (2=50) (3=75) (4=100)
label define informationdfs 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen informationdfs1= . 
replace informationdfs1 = 1 if informationdfs == 75 |informationdfs == 100 
replace informationdfs1 = 0 if  informationdfs == 0 |informationdfs == 25 |informationdfs== 50

/*Vegetation on nearby public lands is managed well*/
gen vegepubland=reduce_3
recode  vegepubland(0=0) (1=25) (2=50) (3=75) (4=100)
label define vegepubland 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen vegepubland1= . 
replace vegepubland1 = 1 if vegepubland == 75 |vegepubland == 100 
replace vegepubland1 = 0 if vegepubland == 0 |vegepubland == 25 |vegepubland== 50

/*Neighbors or community groups will help others with defensible space*/
gen commhelpdfs=reduce_4
recode  commhelpdfs (0=0) (1=25) (2=50) (3=75) (4=100)
label define commhelpdfs 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen commhelpdfs1= . 
replace commhelpdfs1 = 1 if commhelpdfs == 75 |commhelpdfs == 100 
replace commhelpdfs1 = 0 if commhelpdfs == 0 |commhelpdfs == 25 |commhelpdfs== 50

/*Neighbors would help evacuate people*/
gen neighevacuate=reduce_5
recode  neighevacuate (0=0) (1=25) (2=50) (3=75) (4=100)
label define neighevacuate 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen neighevacuate1= . 
replace neighevacuate1 = 1 if neighevacuate == 75 |neighevacuate == 100 
replace neighevacuate1 = 0 if neighevacuate == 0 |neighevacuate == 25 |neighevacuate== 50

/*Neighbors would help to evacuate other peoples’ animals*/

gen neievaanimal=reduce_6
recode  neievaanimal (0=0) (1=25) (2=50) (3=75) (4=100)
label define neievaanimal 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen neievaanimal1= . 
replace neievaanimal1 = 1 if neievaanimal == 75 |neievaanimal == 100 
replace neievaanimal1 = 0 if neievaanimal == 0 |neievaanimal == 25 |neievaanimal== 50


/*Neighbors would help each other protect homes by fighting fires*/

gen neiprotecthome=reduce_7
recode  neiprotecthome (0=0) (1=25) (2=50) (3=75) (4=100)
label define neiprotecthome 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen neiprotecthome1= . 
replace neiprotecthome1 = 1 if neiprotecthome == 75 |neiprotecthome == 100 
replace neiprotecthome1 = 0 if neiprotecthome == 0 |neiprotecthome == 25 |neiprotecthome== 50

sum extensivedfs informationdfs vegepubland commhelpdfs neighevacuate neievaanimal neiprotecthome
sum extensivedfs1 informationdfs1 vegepubland1 commhelpdfs1 neighevacuate1 neievaanimal1 neiprotecthome1


************************Summary Statistics/Community Engagement******************
***********************************************************************
***************************************************************************
****************************************************************************
*******************************************************************************

estpost sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_71  protectvoluntary1 coordinatedfs1 comminvestdfs1 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 nearneighbor1 otherneighbor1 respcommmunity1

esttab using sumcommunityni.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(2)) max(fmt(2))") replace

esttab using sumcommunitynew.rtf, cells (" Description count(fmt(0)) mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace


sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_61 commatt_71

********/* Atttitudes about Goverment */ *****************************
**********************************************************************
**********************************************************************
************************************************************************


/*People who create and maintain defensible space should get tax breaks*/

gen taxbreaks=agree_2
recode taxbreaks (0=0) (1=25) (2=50) (3=75) (4=100)
label define taxbreaks 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen taxbreaks1= . 
replace taxbreaks1 = 1 if taxbreaks == 75 | taxbreaks == 100 
replace taxbreaks1 = 0 if taxbreaks == 0 |taxbreaks == 25 |taxbreaks== 50

/*People who maintain defensible space should have lower insurance rates*/
gen lowinsurance=agree_3
recode lowinsurance (0=0) (1=25) (2=50) (3=75) (4=100)
label define lowinsurance 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen lowinsurance1= . 
replace lowinsurance1 = 1 if lowinsurance == 75 |lowinsurance == 100 
replace lowinsurance1 = 0 if lowinsurance == 0 |lowinsurance == 25 |lowinsurance== 50

/*People should be required by law to maintain defensible space*/
gen lawmaintain=agree_4
recode lawmaintain (0=0) (1=25) (2=50) (3=75) (4=100)
label define lawmaintain 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen lawmaintain1= . 
replace lawmaintain1 = 1 if lawmaintain == 75 |lawmaintain == 100 
replace lawmaintain1 = 0 if lawmaintain == 0 |lawmaintain == 25 |lawmaintain== 50

/*Government should subsidize creation of defensible space through grants*/
gen govtsubsidy=agree_6
recode  govtsubsidy (0=0) (1=25) (2=50) (3=75) (4=100)
label define  govtsubsidy 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  govtsubsidy1= . 
replace govtsubsidy1 = 1 if  govtsubsidy == 75 | govtsubsidy == 100 
replace  govtsubsidy1 = 0 if  govtsubsidy == 0 | govtsubsidy == 25 | govtsubsidy== 50

sum taxbreaks taxbreaks1 lowinsurance lowinsurance1 lawmaintain lawmaintain1 govtsubsidy govtsubsidy1



/*Thinking about the agencies that manage public lands near to your house; do you feel that they…*/
**************************************************************************

/*Share similar values as you*/

gen similarvalue=govt_1
recode  similarvalue (0=0) (1=25) (2=50) (3=75) (4=100)
label define  similarvalue 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  similarvalue1= . 
replace similarvalue1 = 1 if  similarvalue == 75 | similarvalue == 100 
replace  similarvalue1 = 0 if  similarvalue == 0 | similarvalue == 25 | similarvalue== 50

/*Share similar goals as you*/
gen similargoal=govt_2
recode  similargoal (0=0) (1=25) (2=50) (3=75) (4=100)
label define  similargoal 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  similargoal1= . 
replace similargoal1 = 1 if  similargoal == 75 | similargoal == 100 
replace  similargoal1 = 0 if  similargoal == 0 | similargoal == 25 | similargoal== 50

/*Think in a similar way as you*/
gen similarthink=govt_3
recode  similarthink (0=0) (1=25) (2=50) (3=75) (4=100)
label define  similarthink 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  similarthink1= . 
replace similarthink1 = 1 if  similarthink == 75 | similarthink == 100 
replace  similarthink1 = 0 if  similarthink == 0 |similarthink == 25 | similarthink== 50

/*Have the same priorities as you*/

gen samepriorities=govt_4
recode  samepriorities (0=0) (1=25) (2=50) (3=75) (4=100)
label define  samepriorities 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen  samepriorities1= . 
replace samepriorities1 = 1 if  samepriorities == 75 | samepriorities == 100 
replace  samepriorities1 = 0 if  samepriorities == 0 |samepriorities == 25 | samepriorities== 50

sum similarvalue similargoal similarthink samepriorities
sum similarvalue1 similargoal1 similarthink1 samepriorities1



************************Summary Statistics/Attitudes about government******************
***********************************************************************
***************************************************************************
****************************************************************************
*******************************************************************************
estpost sum  taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1 samepriorities1

esttab using sumGOVT9.rtf, cells (" Description count(fmt(0)) mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace


*********/*Perceived Wildfire Risk */***************************
*FIRE_RISK Chance a fire reaches a community 

gen fchcn_1 = . 
replace fchcn_1 = 0.00 if chcn_1 == 0
replace fchcn_1 = 0.125 if chcn_1 == 1 
replace fchcn_1 = 0.25 if chcn_1 == 2 
replace fchcn_1 = 0.375 if chcn_1 == 3
replace fchcn_1 = 0.5 if chcn_1 == 4
replace fchcn_1 = 0.625 if chcn_1 == 5
replace fchcn_1 = 0.75 if chcn_1 == 6
replace fchcn_1 = 0.875 if chcn_1 == 7
replace fchcn_1 = 1.000 if chcn_1 == 8 

gen fchcn_2 = . 
replace fchcn_2 = 0.00 if chcn_2 == 0
replace fchcn_2 = 0.125 if chcn_2 == 1 
replace fchcn_2 = 0.25 if chcn_2 == 2 
replace fchcn_2 = 0.375 if chcn_2 == 3
replace fchcn_2 = 0.5 if chcn_2 == 4
replace fchcn_2 = 0.625 if chcn_2 == 5
replace fchcn_2 = 0.75 if chcn_2 == 6
replace fchcn_2 = 0.875 if chcn_2 == 7
replace fchcn_2 = 1.000 if chcn_2 == 8 

gen fire_risk = (fchcn_1*fchcn_2)
label var fire_risk "Index of subjective chance of fire reaching community"
label value fire_risk fire_risk 


*EFFICACY Trust in Defensible Space
gen eff_1 = . 
replace eff_1 = 0.00 if all_1 == 8
replace eff_1 = 0.125 if all_1 == 7
replace eff_1 = 0.25 if all_1 == 6
replace eff_1 = 0.375 if all_1 == 5
replace eff_1 = 0.5 if all_1 == 4
replace eff_1 = 0.625 if all_1 == 3
replace eff_1 = 0.75 if all_1 == 2
replace eff_1 = 0.875 if all_1 == 1 
replace eff_1 = 1.00 if all_1 == 0

gen eff_2 = . 
replace eff_2 = 0.00 if all_2 == 8
replace eff_2 = 0.125 if all_2 == 7
replace eff_2 = 0.25 if all_2 == 6
replace eff_2 = 0.375 if all_2 == 5
replace eff_2 = 0.5 if all_2 == 4
replace eff_2 = 0.625 if all_2 == 3
replace eff_2 = 0.75 if all_2 == 2 
replace eff_2 = 0.875 if all_2 == 1 
replace eff_2 = 1.00 if all_2 == 0 

gen eff_3 = . 
replace eff_3 = 0.00 if all_3 == 8
replace eff_3 = 0.125 if all_3 == 7
replace eff_3 = 0.25 if all_3 == 6
replace eff_3 = 0.375 if all_3 == 5
replace eff_3 = 0.5 if all_3 == 4
replace eff_3 = 0.625 if all_3 == 3
replace eff_3 = 0.75 if all_3 == 2 
replace eff_3 = 0.875 if all_3 == 1 
replace eff_3 = 1.00 if all_3 == 0 

gen efficacy = (eff_1 + eff_2 + eff_3)/3
label var efficacy "Index of Efficacy all_1 - all_3: Trust in Defensible Space" 
label value efficacy efficacy 

************************Summary Statistics/Perceived wild fire risk******************
***********************************************************************
***************************************************************************
****************************************************************************
*******************************************************************************

estpost sum fire_risk efficacy 

esttab using sumperceived1.rtf, cells (" count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

***********/*Previous Fire Safe Investment */************************************
*********************************************************************************
*********************************************************************************
*****************************************************************************

sum hh_work
sum hh_spend
sum iz_work
sum iz_spend
sum oz_work
sum oz_spend

gen fsi = . 
replace fsi = 1 if hh_work == 1 | hh_spend == 1 | iz_work == 1| iz_spend == 1 | oz_work == 1 | oz_spend == 1
replace fsi = 0 if fsi != 1 

gen money = 1 if hh_spend == 1 | iz_spend == 1 | oz_spend == 1
replace money = 0 if money != 1

gen time2 = 1 if hh_work == 1 | iz_work == 1 | oz_work == 1
replace time2 = 0 if time2 != 1 

sum defsp if fsi == 0 
sum defsp if fsi == 1
sum fsi 


sum fsi if defsp == 1 
sum money 

sum money if defsp == 1
sum time2 
sum time2 if defsp == 1 

sum hh_spend if defsp == 1
sum hh_work if defsp == 1

sum iz_spend if defsp == 1
sum iz_work if defsp == 1

sum oz_spend if defsp == 1
sum oz_work if defsp == 1


sum oz_spend if fsi == 1
sum oz_work if fsi == 1


sum hh_work hh_spend iz_work  iz_spend oz_work oz_spend if defsp == 1 


/*Do you store woodpiles or scrap wood within 30 feet of this house during fire seasons?*/

gen woodpile1=woodpile
recode woodpile1 (0=0) (1=1) 
label define  woodpile1  0 "no" 1 "yes" 


/*Is there good road access to this house so that fire engines could easily pass other vehicles?*/
gen access1 =access 
recode access1  (0=0) (1=1) 
label define  access1   0 "no" 1 "yes" 


/*Are there one or more wooden sheds within 30 feet of this house?*/ 
gen shed1 =shed
recode shed1  (0=0) (1=1) 
label define shed1   0 "no" 1 "yes" 

/*Are there any outdoor tanks for heating oil or propane within 500 feet of this house?*/
gen tank1 =tank
recode tank1  (0=0) (1=1) 
label define tank1   0 "no" 1 "yes" 

/*Do you have a cedar shake roof?*/
gen roof1 =roof
recode roof1 (0=0) (1=1) 
label define roof1  0 "no" 1 "yes" 

/*Do you have a water supply for fire (hydrant, tank, pond, ditch) within 30 feet of this house?*/
gen water1 =water
recode water1 (0=0) (1=1) 
label define water1 0 "no" 1 "yes" 

sum woodpile1 access1 shed1 tank1 roof1 water1
sum woodpile access shed tank roof water

/*Why not do more to this house (the structure itself) to reduce fire risk?*/
********************************************************************************

/*Already done enough to the house*/
gen denhouse=more_hh_1
recode  denhouse (0=0) (1=25) (2=50) (3=75) (4=100)
label define  denhouse 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen denhouse1= . 
replace denhouse1 = 1 if denhouse == 75 | denhouse == 100 
replace denhouse1 = 0 if  denhouse == 0 |denhouse == 25 | denhouse== 50

/*My inner zone already protects the house well enough*/
gen izaprotect=more_hh_2
recode  izaprotect (0=0) (1=25) (2=50) (3=75) (4=100)
label define izaprotect 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen izaprotect1= . 
replace izaprotect1 = 1 if izaprotect == 75 | izaprotect == 100 
replace izaprotect1 = 0 if  izaprotect == 0 | izaprotect== 25 | izaprotect== 50

/*My outer zone already protects the house well enough*/
gen ozaprotect=more_hh_3
recode  ozaprotect (0=0) (1=25) (2=50) (3=75) (4=100)
label define ozaprotect 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen ozaprotect1= . 
replace ozaprotect1 = 1 if ozaprotect == 75 | ozaprotect == 100 
replace ozaprotect1 = 0 if  ozaprotect == 0 | ozaprotect== 25 | ozaprotect== 50

/*It would cost more than I could gain*/

gen costmore=more_hh_6
recode  costmore (0=0) (1=25) (2=50) (3=75) (4=100)
label define costmore 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen costmore1= . 
replace costmore1 = 1 if costmore == 75 | costmore == 100 
replace costmore1 = 0 if costmore == 0 | costmore== 25 | costmore== 50

sum denhouse izaprotect ozaprotect costmore
sum denhouse1 izaprotect1 ozaprotect1 costmore1


******/*Why not do more to the inner zone around this house?*/******
*******************************************************************

/*Already done enough to the inner zone*/
gen izdoneenough=more_iz_1
recode izdoneenough (0=0) (1=25) (2=50) (3=75) (4=100)
label define izdoneenough 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen izdoneenough1= . 
replace izdoneenough1 = 1 if izdoneenough == 75 | izdoneenough == 100 
replace izdoneenough1 = 0 if  izdoneenough == 0 | izdoneenough== 25 | izdoneenough== 50


/*Why not do more to the outer zone around this house?*/
***********************************************************

/*Already done enough to the outer zone*/

gen ozdoneenough=more_iz_1
recode ozdoneenough (0=0) (1=25) (2=50) (3=75) (4=100)
label define ozdoneenough 0 "No!!" 1 "no" 2 "Maybe" 3 "yes" 4 "Yes!!"

gen ozdoneenough1= . 
replace ozdoneenough1 = 1 if ozdoneenough == 75 | ozdoneenough == 100 
replace ozdoneenough1 = 0 if  ozdoneenough == 0 | ozdoneenough == 25 | ozdoneenough== 50

sum izdoneenough izdoneenough1 ozdoneenough ozdoneenough1  


************************Summary Statistics/Previous fire safe investment******************
***********************************************************************
***************************************************************************
****************************************************************************
*******************************************************************************

estpost sum woodpile1 access1 shed1 tank1 roof1 water1 denhouse1 hh_work hh_spend  izdoneenough1 iz_work iz_work ozdoneenough1  oz_work oz_spend

esttab using sumprevfsi2.rtf, cells (" count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace


*********/* Date February 14th 2020*//* Previous fire safe investment */****
**************************************************************************
**************************************************************************
**************************************************************************

/*what is in the inner zone around your house*/
***********************************************
/*Green Lawn*/

gen greenlawn = . 
replace greenlawn = 0.00 if iz_1 == 0
replace greenlawn = 0.20 if iz_1 == 1 
replace greenlawn= 0.40 if iz_1 == 2 
replace greenlawn = 0.60 if iz_1 == 3
replace greenlawn = 0.80 if iz_1 == 4
replace greenlawn = 1.00 if iz_1 == 5


gen greenlawn1 = . 
replace greenlawn1 = 0 if iz_1 == 0
replace greenlawn1 = 20 if iz_1 == 1 
replace greenlawn1= 40 if iz_1 == 2 
replace greenlawn1 = 60 if iz_1 == 3
replace greenlawn1 = 80 if iz_1 == 4
replace greenlawn1 = 100 if iz_1 == 5


/*Rock/sand/other non flammable ladscapping materils*/

gen nonflammable = . 
replace nonflammable = 0.00 if iz_2 == 0
replace nonflammable = 0.20 if iz_2 == 1 
replace nonflammable= 0.40 if iz_2 == 2 
replace nonflammable = 0.60 if iz_2 == 3
replace nonflammable = 0.80 if iz_2 == 4
replace nonflammable = 1.00 if iz_2 == 5


gen nonflammable1 = . 
replace nonflammable1 = 0 if iz_2 == 0
replace nonflammable1 = 20 if iz_2 == 1 
replace nonflammable1= 40 if iz_2 == 2 
replace nonflammable1 = 60 if iz_2 == 3
replace nonflammable1 = 80 if iz_2 == 4
replace nonflammable1 = 100 if iz_2 == 5

/*Cheartgrass and other invassive grasses and weeds*/

gen cheatinvagrass = . 
replace cheatinvagrass = 0.00 if iz_3 == 0
replace cheatinvagrass = 0.20 if iz_3 == 1 
replace cheatinvagrass= 0.40 if iz_3 == 2 
replace cheatinvagrass = 0.60 if iz_3 == 3
replace cheatinvagrass = 0.80 if iz_3 == 4
replace cheatinvagrass = 1.00 if iz_3 == 5


gen cheatinvagrass1 = . 
replace cheatinvagrass1 = 0 if iz_3 == 0
replace cheatinvagrass1 = 20 if iz_3 == 1 
replace cheatinvagrass1= 40 if iz_3 == 2 
replace cheatinvagrass1 = 60 if iz_3 == 3
replace cheatinvagrass1 = 80 if iz_3 == 4
replace cheatinvagrass1 = 100 if iz_3 == 5

/*leafty tress like maples or oaks*/

gen mapleoaks = . 
replace mapleoaks= 0.00 if iz_4 == 0
replace mapleoaks = 0.20 if iz_4 == 1 
replace mapleoaks= 0.40 if iz_4 == 2 
replace mapleoaks = 0.60 if iz_4 == 3
replace mapleoaks = 0.80 if iz_4 == 4
replace mapleoaks = 1.00 if iz_4 == 5


gen mapleoaks1 = . 
replace mapleoaks1 = 0 if iz_4 == 0
replace mapleoaks1 = 20 if iz_4 == 1 
replace mapleoaks1= 40 if iz_4 == 2 
replace mapleoaks1 = 60 if iz_4 == 3
replace mapleoaks1 = 80 if iz_4 == 4
replace mapleoaks1 = 100 if iz_4 == 5

/* Evergreen tress (pines, spruce and fir tress*/

gen evgreentrees = . 
replace evgreentrees= 0.00 if iz_5 == 0
replace evgreentrees = 0.20 if iz_5 == 1 
replace evgreentrees= 0.40 if iz_5 == 2 
replace evgreentrees = 0.60 if iz_5 == 3
replace evgreentrees = 0.80 if iz_5 == 4
replace evgreentrees = 1.00 if iz_5 == 5


gen evgreentrees1 = . 
replace evgreentrees1 = 0 if iz_5 == 0
replace evgreentrees1 = 20 if iz_5 == 1 
replace evgreentrees1= 40 if iz_5 == 2 
replace evgreentrees1 = 60 if iz_5 == 3
replace evgreentrees1 = 80 if iz_5 == 4
replace evgreentrees1 = 100 if iz_5 == 5

/* Junipar bsushes */

gen junibushes = . 
replace junibushes= 0.00 if iz_6 == 0
replace junibushes = 0.20 if iz_6 == 1 
replace junibushes= 0.40 if iz_6 == 2 
replace junibushes = 0.60 if iz_6 == 3
replace junibushes = 0.80 if iz_6 == 4
replace junibushes = 1.00 if iz_6 == 5


gen junibushes1 = . 
replace junibushes1 = 0 if iz_6 == 0
replace junibushes1 = 20 if iz_6 == 1 
replace junibushes1= 40 if iz_6 == 2 
replace junibushes1 = 60 if iz_6 == 3
replace junibushes1 = 80 if iz_6 == 4
replace junibushes1 = 100 if iz_6 == 5

/* Sagebrush and other native shurbs*/

gen nativeshrubs = . 
replace nativeshrubs= 0.00 if iz_7 == 0
replace nativeshrubs = 0.20 if iz_7 == 1 
replace nativeshrubs= 0.40 if iz_7 == 2 
replace nativeshrubs = 0.60 if iz_7 == 3
replace nativeshrubs = 0.80 if iz_7 == 4
replace nativeshrubs = 1.00 if iz_7 == 5


gen nativeshrubs1 = . 
replace nativeshrubs1 = 0 if iz_7 == 0
replace nativeshrubs1 = 20 if iz_7 == 1 
replace nativeshrubs1= 40 if iz_7 == 2 
replace nativeshrubs1 = 60 if iz_7 == 3
replace nativeshrubs1 = 80 if iz_7 == 4
replace nativeshrubs1 = 100 if iz_7 == 5

/*Summary Statistics*/
sum greenlawn1 nonflammable1 cheatinvagrass1 mapleoaks1 evgreentrees1 junibushes1 nativeshrubs1
sum greenlawn nonflammable cheatinvagrass mapleoaks evgreentrees junibushes nativeshrubs

/*what is in th outer zone around your house*/
***********************************************

gen ozgreenlawn = . 
replace ozgreenlawn = 0.00 if oz_1 == 0
replace ozgreenlawn = 0.20 if oz_1 == 1 
replace ozgreenlawn= 0.40 if oz_1 == 2 
replace ozgreenlawn = 0.60 if oz_1 == 3
replace ozgreenlawn = 0.80 if oz_1 == 4
replace ozgreenlawn = 1.00 if oz_1 == 5


gen ozgreenlawn1 = . 
replace ozgreenlawn1 = 0 if oz_1 == 0
replace ozgreenlawn1 = 20 if oz_1 == 1 
replace ozgreenlawn1= 40 if oz_1 == 2 
replace ozgreenlawn1 = 60 if oz_1 == 3
replace ozgreenlawn1 = 80 if oz_1 == 4
replace ozgreenlawn1 = 100 if oz_1 == 5


/*Rock/sand/other non flammable ladscapping materils*/

gen oznonflammable = . 
replace oznonflammable = 0.00 if oz_2 == 0
replace oznonflammable = 0.20 if oz_2 == 1 
replace oznonflammable= 0.40 if oz_2 == 2 
replace oznonflammable = 0.60 if oz_2 == 3
replace oznonflammable = 0.80 if oz_2 == 4
replace oznonflammable = 1.00 if oz_2 == 5


gen oznonflammable1 = . 
replace oznonflammable1 = 0 if oz_2 == 0
replace oznonflammable1 = 20 if oz_2 == 1 
replace oznonflammable1= 40 if oz_2 == 2 
replace oznonflammable1 = 60 if oz_2 == 3
replace oznonflammable1 = 80 if oz_2 == 4
replace oznonflammable1 = 100 if oz_2 == 5

/*leafty tress like maples or oaks*/

gen ozmapleoaks = . 
replace ozmapleoaks= 0.00 if oz_3 == 0
replace ozmapleoaks = 0.20 if oz_3 == 1 
replace ozmapleoaks= 0.40 if oz_3 == 2 
replace ozmapleoaks = 0.60 if oz_3 == 3
replace ozmapleoaks = 0.80 if oz_3 == 4
replace ozmapleoaks = 1.00 if oz_3 == 5


gen ozmapleoaks1 = . 
replace ozmapleoaks1 = 0 if oz_3 == 0
replace ozmapleoaks1 = 20 if oz_3 == 1 
replace ozmapleoaks1= 40 if oz_3 == 2 
replace ozmapleoaks1 = 60 if oz_3 == 3
replace ozmapleoaks1 = 80 if oz_3 == 4
replace ozmapleoaks1 = 100 if oz_3 == 5

/* Evergreen tress (pines, spruce and fir tress*/

gen ozevgreentrees = . 
replace ozevgreentrees= 0.00 if oz_4 == 0
replace ozevgreentrees = 0.20 if oz_4 == 1 
replace ozevgreentrees= 0.40 if oz_4 == 2 
replace ozevgreentrees = 0.60 if oz_4 == 3
replace ozevgreentrees = 0.80 if oz_4 == 4
replace ozevgreentrees = 1.00 if oz_4 == 5


gen ozevgreentrees1 = . 
replace ozevgreentrees1 = 0 if oz_4 == 0
replace ozevgreentrees1 = 20 if oz_4 == 1 
replace ozevgreentrees1= 40 if oz_4 == 2 
replace ozevgreentrees1 = 60 if oz_4 == 3
replace ozevgreentrees1 = 80 if oz_4 == 4
replace ozevgreentrees1 = 100 if oz_4 == 5


/* Junipar shrubs */

gen ozjunishurbs = . 
replace ozjunishurbs= 0.00 if oz_5 == 0
replace ozjunishurbs= 0.20 if oz_5 == 1 
replace ozjunishurbs= 0.40 if oz_5 == 2 
replace ozjunishurbs = 0.60 if oz_5 == 3
replace ozjunishurbs = 0.80 if oz_5 == 4
replace ozjunishurbs = 1.00 if oz_5 == 5


gen ozjunishurbs1 = . 
replace ozjunishurbs1 = 0 if oz_5 == 0
replace ozjunishurbs1 = 20 if oz_5 == 1 
replace ozjunishurbs1= 40 if oz_5 == 2 
replace ozjunishurbs1 = 60 if oz_5 == 3
replace ozjunishurbs1 = 80 if oz_5 == 4
replace ozjunishurbs1 = 100 if oz_5== 5


/* Sagebrush and other native plants*/ 

gen oznativeplants = . 
replace oznativeplants= 0.00 if oz_6 == 0
replace oznativeplants = 0.20 if oz_6 == 1 
replace oznativeplants= 0.40 if oz_6 == 2 
replace oznativeplants = 0.60 if oz_6 == 3
replace oznativeplants = 0.80 if oz_6 == 4
replace oznativeplants = 1.00 if oz_6 == 5


gen oznativeplants1 = . 
replace oznativeplants1 = 0 if oz_6 == 0
replace oznativeplants1 = 20 if oz_6 == 1 
replace oznativeplants1= 40 if oz_6 == 2 
replace oznativeplants1 = 60 if oz_6 == 3
replace oznativeplants1 = 80 if oz_6 == 4
replace oznativeplants1 = 100 if oz_6 == 5

/* Heavily overgreen brushy areas */

gen ozovgrbrushy = . 
replace ozovgrbrushy= 0.00 if oz_7 == 0
replace ozovgrbrushy = 0.20 if oz_7 == 1 
replace ozovgrbrushy= 0.40 if oz_7 == 2 
replace ozovgrbrushy = 0.60 if oz_7 == 3
replace ozovgrbrushy = 0.80 if oz_7 == 4
replace ozovgrbrushy = 1.00 if oz_7 == 5


gen ozovgrbrushy1 = . 
replace ozovgrbrushy1 = 0 if oz_7 == 0
replace ozovgrbrushy1 = 20 if oz_7 == 1 
replace ozovgrbrushy1= 40 if oz_7 == 2 
replace ozovgrbrushy1 = 60 if oz_7 == 3
replace ozovgrbrushy1 = 80 if oz_7 == 4
replace ozovgrbrushy1 = 100 if oz_7 == 5


/* Well purned and trimmed trees, shrubs and plants*/

gen oztrimtrees = . 
replace oztrimtrees = 0.00 if oz_8 == 0
replace oztrimtrees  = 0.20 if oz_8 == 1 
replace oztrimtrees = 0.40 if oz_8 == 2 
replace oztrimtrees = 0.60 if oz_8 == 3
replace oztrimtrees  = 0.80 if oz_8 == 4
replace oztrimtrees  = 1.00 if oz_8 == 5


gen oztrimtrees1 = . 
replace oztrimtrees1 = 0 if oz_8 == 0
replace oztrimtrees1 = 20 if oz_8 == 1 
replace oztrimtrees1= 40 if oz_8 == 2 
replace oztrimtrees1 = 60 if oz_8 == 3
replace oztrimtrees1 = 80 if oz_8 == 4
replace oztrimtrees1 = 100 if oz_8 == 5


/* Dead trees and shrubs */


gen ozdeadtrees = . 
replace ozdeadtrees = 0.00 if oz_9 == 0
replace ozdeadtrees  = 0.20 if oz_9 == 1 
replace ozdeadtrees = 0.40 if oz_9 == 2 
replace ozdeadtrees = 0.60 if oz_9 == 3
replace ozdeadtrees  = 0.80 if oz_9 == 4
replace ozdeadtrees  = 1.00 if oz_9 == 5


gen ozdeadtrees1 = . 
replace ozdeadtrees1 = 0 if oz_9 == 0
replace ozdeadtrees1 = 20 if oz_9 == 1 
replace ozdeadtrees1= 40 if oz_9 == 2 
replace ozdeadtrees1 = 60 if oz_9 == 3
replace ozdeadtrees1 = 80 if oz_9 == 4                                                                                                                                               == 4
replace ozdeadtrees1 = 100 if oz_9 == 5


/*Summary Statistics*/ 


estpost sum woodpile1 access1 shed1 tank1 roof1 water1 denhouse1 hh_work hh_spend  izdoneenough1 iz_work iz_work ozdoneenough1  oz_work oz_spend

esttab using sumprevfsi9.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace


sum greenlawn1 nonflammable1 cheatinvagrass1 mapleoaks1 evgreentrees1 junibushes1 nativeshrubs1
sum ozgreenlawn1  oznonflammable1 ozmapleoaks1 ozevgreentrees1 ozjunishurbs1 oznativeplants1 ozovgrbrushy1 oztrimtrees1 ozdeadtrees1

sum greenlawn nonflammable cheatinvagrass1 mapleoaks evgreentrees junibushes nativeshrubs
sum ozgreenlawn  oznonflammable ozmapleoaks ozevgreentrees ozjunishurbs oznativeplants ozovgrbrushy oztrimtrees ozdeadtrees

estpost sum  hh_work hh_spend   iz_work iz_work  oz_work oz_spend greenlawn nonflammable mapleoaks evgreentrees oznonflammable ozmapleoaks ozevgreentrees oznativeplants
esttab using firesafeinvestni.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

estpost sum greenlawn nonflammable mapleoaks evgreentrees oznonflammable ozmapleoaks ozevgreentrees oznativeplants
esttab using firesafeinvest6.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

***********/* Utility Hits, aesthetic and privacy */ **************************
********************************************************************************
********************************************************************************

/*Don’t want to make my house less attractive*/

gen c5 = choice_5 
recode c5 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c5 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen c5HLA= . 
replace c5HLA = 1 if c5 == 75 | c5 == 100 
replace c5HLA = 0 if  c5 == 0 | c5== 25 | c5== 50

/*Don’t want to make my landscaping less attractive*/

gen c6 = choice_6 
recode c6 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c6 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen c6LLA= . 
replace c6LLA = 1 if c6 == 75 | c6 == 100 
replace c6LLA = 0 if  c6 == 0 | c6== 25 | c6== 50

/*Changes to landscaping may reduce my privacy*/

gen c7 = choice_7 
recode c7 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c7 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen c7LRP= . 
replace c7LRP = 1 if c7 == 75 | c7 == 100 
replace c7LRP = 0 if  c7 == 0 | c7== 25 | c7== 50

/*Changes to CONVERN WILDLIFE*/

gen c8 = choice_8
recode c8 (0=0) (1=25) (2=50) (3=75) (4=100)
label define c8 0 "No!!" 25 "no" 50 "Maybe" 75 "yes" 100 "Yes!!"

gen c8WLH= . 
replace c8WLH = 1 if c8 == 75 | c8 == 100 
replace c8WLH = 0 if  c8 == 0 | c8== 25 | c8== 50

/*rename variables*/
gen house_attr = c5
gen land_attr = c6

gen private = c7
label var private "Index of Privacy as a barrier to Defensible Space"
label values private private

sum c5 c5HLA c6 c6LLA c7 c7LRP house_attr land_attr private


************************Summary Statistics***************************
***********************************************************************
***************************************************************************
estpost sum c5 c6 c7 c8

esttab using utlity.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace


estpost sum  c5HLA c6LLA  c7LRP c8WLH 
esttab using utlityniaz1.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

estpost sum  choice_5  choice_6  choice_7  choice_8

esttab using utlityniaz3.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

/* Date February 17th 2020*/
****************************



/*experiment*/

tabulate done_oz_1_1, gen(dum)

gen niaz1 = . 
replace niaz1 = 5 if dum1 == 1

tabulate hh_1_1, gen(dum)

gen niaz2 = . 
replace niaz2 = 4 if dum3 == 1
replace niaz2 = 3 if dum1 == 1
replace niaz2 = 2 if dum2 == 1
replace niaz2 = 1 if dum4 == 1


/*Summary Statistics*/

*Biophysical Variables

estpost sum aspect elevdiff slope fuel brush grs pj tmbr lghtn wind
esttab using biophusical.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace



******************Does this house have?*********************
**********************************************************
***************************************************************
/*Fire-resistant roof (tile, cement, asphalt)*/

tabulate hh_1_1, gen(dum)


gen hhfirerroof = . 
replace hhfirerroof = 1 if dum3 == 1
replace hhfirerroof = 1 if dum4 == 1
replace hhfirerroof = 0 if dum1 == 1
replace hhfirerroof = 0 if dum2 == 1

tabulate hh_2_1, gen(dum)

gen hhfirenoplan = . 
replace hhfirenoplan = 1 if dum2 == 1
replace hhfirenoplan = 0 if dum1 == 1


tabulate hh_3_1, gen(dum)

gen hhfireyesbought = . 
replace hhfireyesbought = 1 if dum2 == 1
replace hhfireyesbought = 0 if dum1 == 1


tabulate hh_4_1, gen(dum)

gen hhfireyesadd = . 
replace hhfireyesadd = 1 if dum2 == 1
replace hhfireyesadd = 0 if dum1 == 1


/*Fire-resistant siding (stucco, cement fibreboard, brick)*/

tabulate hh_1_2, gen(dum)


gen hhfirersiding = . 
replace hhfirersiding = 1 if dum3 == 1
replace hhfirersiding = 1 if dum4 == 1
replace hhfirersiding = 0 if dum1 == 1
replace hhfirersiding = 0 if dum2 == 1


tabulate hh_2_2, gen(dum)

gen hhsidingnoplan = . 
replace hhsidingnoplan  = 1 if dum2 == 1
replace hhsidingnoplan  = 0 if dum1 == 1


tabulate hh_3_2, gen(dum)

gen hhsidingyesbought = . 
replace hhsidingyesbought = 1 if dum2 == 1
replace hhsidingyesbought = 0 if dum1 == 1


tabulate hh_4_2, gen(dum)

gen hhsidingyesadd = . 
replace hhsidingyesadd = 1 if dum2 == 1
replace hhsidingyesadd = 0 if dum1 == 1

/*Eaves enclosed or eliminated*/


tabulate hh_1_3, gen(dum)


gen hheaves = . 
replace hheaves = 1 if dum3 == 1
replace hheaves = 1 if dum4 == 1
replace hheaves = 0 if dum1 == 1
replace hheaves = 0 if dum2 == 1

tabulate hh_2_3, gen(dum)

gen hhevaesnoplan = . 
replace hhevaesnoplan = 1 if dum2 == 1
replace hhevaesnoplan = 0 if dum1 == 1

tabulate hh_3_3, gen(dum)

gen hhevaesyesbought = . 
replace hhevaesyesbought = 1 if dum2 == 1
replace hhevaesyesbought = 0 if dum1 == 1

tabulate hh_4_3, gen(dum)

gen hhevaesyesadd = . 
replace hhevaesyesadd = 1 if dum2 == 1
replace hhevaesyesadd = 0 if dum1 == 1


/*Spark arresters on chimneys*/

tabulate hh_1_4, gen(dum)


gen hhsparkchimneys = . 
replace hhsparkchimneys = 1 if dum3 == 1
replace hhsparkchimneys = 1 if dum4 == 1
replace hhsparkchimneys = 0 if dum1 == 1
replace hhsparkchimneys = 0 if dum2 == 1

tabulate hh_2_4, gen(dum)

gen hhschimneynoplan = . 
replace hhschimneynoplan = 1 if dum2 == 1
replace hhschimneynoplan = 0 if dum1 == 1

tabulate hh_3_4, gen(dum)

gen hhschimneysyesbought = . 
replace hhschimneysyesbought = 1 if dum2 == 1
replace hhschimneysyesbought = 0 if dum1 == 1

tabulate hh_4_4, gen(dum)

gen hhschimneysyesadd = . 
replace hhschimneysyesadd = 1 if dum2 == 1
replace hhschimneysyesadd = 0 if dum1 == 1

/*Vents covered with mesh*/

tabulate hh_1_5, gen(dum)


gen hhventsmmesh = . 
replace hhventsmmesh = 1 if dum3 == 1
replace hhventsmmesh = 1 if dum4 == 1
replace hhventsmmesh = 0 if dum1 == 1
replace hhventsmmesh = 0 if dum2 == 1

tabulate hh_2_5, gen(dum)

gen hhventsnoplan = . 
replace hhventsnoplan = 1 if dum2 == 1
replace hhventsnoplan = 0 if dum1 == 1

tabulate hh_3_5, gen(dum)

gen hhventsyesbought = . 
replace hhventsyesbought = 1 if dum2 == 1
replace hhventsyesbought = 0 if dum1 == 1

tabulate hh_4_5, gen(dum)

gen hhventsyesadd = . 
replace hhventsyesadd = 1 if dum2 == 1
replace hhventsyesadd = 0 if dum1 == 1

/*Skirting under decks*/

tabulate hh_1_6, gen(dum)


gen hhskirtingdecks = . 
replace hhskirtingdecks = 1 if dum3 == 1
replace hhskirtingdecks = 1 if dum4 == 1
replace hhskirtingdecks = 0 if dum1 == 1
replace hhskirtingdecks = 0 if dum2 == 1

tabulate hh_2_6, gen(dum)

gen hhskirtingnoplan = . 
replace hhskirtingnoplan = 1 if dum2 == 1
replace hhskirtingnoplan = 0 if dum1 == 1


tabulate hh_3_6, gen(dum)

gen hhskirtingyesbought = . 
replace hhskirtingyesbought = 1 if dum2 == 1
replace hhskirtingyesbought = 0 if dum1 == 1


tabulate hh_4_6, gen(dum)

gen hhskirtingyesadd = . 
replace hhskirtingyesadd = 1 if dum2 == 1
replace hhskirtingyesadd = 0 if dum1 == 1



sum hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
sum hhfirenoplan hhsidingnoplan hhevaesnoplan hhschimneynoplan hhventsnoplan hhskirtingnoplan
sum hhfireyesbought hhsidingyesbought hhevaesyesbought hhschimneysyesbought hhventsyesbought hhskirtingyesbought
sum hhfireyesadd hhsidingyesadd hhevaesyesadd hhschimneysyesadd hhventsyesadd hhskirtingyesadd


estpost sum hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
esttab using dfsfiresafeinve.rtf, cells (" Description count(fmt(0))  mean(fmt(2)) sd(fmt(2)) min(fmt(0)) max(fmt(0))") replace

******************************************************************
*********************************************************************
/* Factor Analysis*/

global xlist hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
global ncomp 3
global id community

describe $xlist 
summarize $xlist
corr $xlist 

/*pricipal component analysis*/

pca $xlist 

*scree plot of the eigenvalues 

screeplot 
screeplot, yline(1)

*principal component analysis (PCA)

pca $xlist, mineigen(1)
pca $xlist, comp($ncomp)
pca $xlist, comp($ncomp) blanks (.3)


*component rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 



rotate, promax
rotate, promax blanks(.3)
rotate, clear 



*scatter plots of the loading and score variables 

loadingplot
scoreplot
scoreplot, mlabel($community)


loadingplot
scoreplot
scoreplot, mlabel($survey_id)

loadingplot
scoreplot
scoreplot, mlabel($id)

* Scater plot of the loadings and score vaiables 
estat loading 
predict pc1 pc2 pc3, score 


*KMO measure  of sampling adequacy 

estat kmo

* Factor Analysis 

factor $xlist 

* score plot of the eigenvalues 

screeplot
screeplot, yline(1)


*factor analysis analysis (FA)

factor $xlist, mineigen(1)
factor $xlist, comp($ncomp)
factor $xlist, comp($ncomp) blanks (.3)


*factor rotations 
rotate, varimax
rotate, varimax blanks(.3)
rotate, clear 



rotate, promax
rotate, promax blanks(.3)
rotate, clear 

estat common 

*scatter plots of the loading and score variables 

loadingplot
scoreplot


*score of the componets 

predict f1 f2 f3

*KMO measure of sampling adequacy

estat kmo
* average interitem covarianece 

alpha $xlist 


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


tabulate privatebid1  pribid1, column nofreq
probit privatebid1  pribid1
nlcom (WTP:-_b[_cons]/_b[pribid1]), noheader
probit privatebid3  pribid3
nlcom (WTP:-_b[_cons]/_b[pribid3]), noheader

* Maximam Likelihood to estimate WTP 
*cleaning the data set with missing value, *************************



*Data cleaning  for missing values ****


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

/* generate varibles using YES NO response*/

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


/*Experiemnt Response variables start*/

generate answer0=0
replace answer0=1 if depvar1==1


generate answer1=0
replace answer1=1 if depvar1==2

generate answer2=0
replace answer2=1 if depvar1==2| depvar1==3


generate answer3=0
replace answer3=1 if depvar1==2| depvar1==3 | depvar1==4


generate answer4=0
replace answer4=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5

generate answer5=0
replace answer5=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6


generate answer6=.
replace answer6=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 | depvar1==7
replace answer6=0 if depvar1==1

generate answer7=0
replace answer7=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 | depvar1==7

/* Experiment Response variables End */

/* Final code for reponse varibles*/

generate response1=.
replace response1=1 if depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 | depvar1==7
replace response1=0 if depvar1==1

generate response2=.
replace response2=1 if depvar1==7
replace response2=0 if depvar1==1 | depvar1==2| depvar1==3 | depvar1==4 | depvar1==5 | depvar1==6 



order privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6 combinepvid depvar


/* Experimental code for bid variables start*/
gen bid2=.
replace privatebid1 if answer==1
replace privatebid1 if answer==1



gen bid1=.
replace bid1=pribid1 if response1==1 & depvar1==1
replace bid1=pribid1 if response1==0 

gen bid2=.
replace bid2=pribid2 if response1==1 & depvar1==2
replace bid2=pribid2 if response1==0 
replace bid1=pribid2 if response1==1| depvar1==2
replace bid1=pribid2 if response1==0 
replace bid1=pribid3 if response1==1| depvar1==3
replace bid1=pribid3 if response1==0 
replace bid1=pribid4 if response1==1| depvar1==4
replace bid1=pribid4 if response1==0 
replace bid1=pribid5 if response1==1| depvar1==5
replace bid1=pribid5 if response1==0 
replace bid1=pribid6 if response1==1| depvar1==6
replace bid1=pribid6 if response1==0 

gen bid2=.
replace bid2=pribid1 if response1==1| depvar1==1
replace bid2=pribid1 if response1==0 

gen bid3=.
replace bid3=pribid2 if response1==1| depvar1==2
replace bid3=pribid2 if response1==0 

gen bid4=.
replace bid4=pribid1| depvar1==1  if response1==1
replace bid4=pribid1 if response1==0 

gen bid5=0
replace bid5=pribid1 if response1==1| depvar1==1
replace bid5=pribid2 if response1==1| depvar1==2
replace bid5=pribid3 if response1==1| depvar1==3
replace bid5=pribid4 if response1==1| depvar1==4
replace bid5=pribid5 if response1==1| depvar1==5 
replace bid5=pribid6 if response1==1| depvar1==6


gen bid6=0
replace bid6=pribid1 & depvar1==1  if response1==1
replace bid6=pribid2 | depvar1==2 if response1==1
replace bid6=pribid3 | depvar1==3 if response1==1
replace bid6=pribid4 | depvar1==4 if response1==1
replace bid6=pribid5 | depvar1==5 if response1==1
replace bid6=pribid6 | depvar1==6 if response1==1

gen bid7=0
replace bid7=pribid1 if response1==1| depvar1==2
replace bid7=pribid2 if response1==1| depvar1==3
replace bid7=pribid3 if response1==1| depvar1==4
replace bid7=pribid4 if response1==1| depvar1==5
replace bid7=pribid5 if response1==1| depvar1==6 
replace bid7=pribid6 if response1==1| depvar1==7


gen bid7=0
replace bid7=pribid1 if response1==1 & depvar1==1
replace bid7=pribid2 if response1==1 & depvar1==2
replace bid7=pribid3 if response1==1 & depvar1==3
replace bid7=pribid4 if response1==1 & depvar1==4
replace bid7=pribid5 if response1==1 & depvar1==5 
replace bid7=pribid6 if response1==1 & depvar1==6

gen bid8=0
replace bid8=pribid1 if response1==1 & depvar1==2
replace bid8=pribid2 if response1==1 & depvar1==3
replace bid8=pribid3 if response1==1 & depvar1==4
replace bid8=pribid4 if response1==1 & depvar1==5
replace bid8=pribid5 if response1==1 & depvar1==6 
replace bid8=pribid6 if response1==1 & depvar1==7



gen bid8=0
replace bid8=pribid1 if response1==1
replace bid8=pribid2 if response1==1 
replace bid8=pribid3 if response1==1 
replace bid8=pribid4 if response1==1 
replace bid8=pribid5 if response1==1
replace bid8=pribid6 if response1==1 

gen niazbid1=.
replace niazbid1=pribid1 if response1==1 & depvar1==1
replace niazbid1=pribid1 if response1==0 & depvar1==1

gen niazbid2=.
replace niazbid2=pribid1 if response1==1 & depvar1==1
replace niazbid2=pribid1 if response1==0 & depvar1==1
replace niazbid2=pribid2 if response1==1 & depvar1==2
replace niazbid2=pribid2 if response1==0 & depvar1==2


gen niazbid3=.
replace niazbid3=pribid1 if response1==1 & depvar1==1
replace niazbid3=pribid1 if response1==0 & depvar1==1
replace niazbid3=pribid1 if response1==1 & depvar1==2
replace niazbid3=pribid1 if response1==0 & depvar1==2
replace niazbid3=pribid2 if response1==1 & depvar1==3
replace niazbid3=pribid2 if response1==0 & depvar1==3
replace niazbid3=pribid3 if response1==1 & depvar1==4
replace niazbid3=pribid3 if response1==0 & depvar1==4
replace niazbid3=pribid4 if response1==1 & depvar1==5
replace niazbid3=pribid4 if response1==0 & depvar1==5
replace niazbid3=pribid5 if response1==1 & depvar1==6
replace niazbid3=pribid5 if response1==0 & depvar1==6
replace niazbid3=pribid6 if response1==1 & depvar1==7


gen niazbid4=.
replace niazbid4=pribid1 if response1==1 & depvar1==1
replace niazbid4=pribid1 if response1==1 & depvar1==2
replace niazbid4=pribid2 if response1==1 & depvar1==3
replace niazbid4=pribid3 if response1==1 & depvar1==4
replace niazbid4=pribid4 if response1==1 & depvar1==5
replace niazbid4=pribid5 if response1==1 & depvar1==6
replace niazbid4=pribid6 if response1==1 & depvar1==7


gen niazbid5=.
replace niazbid5=pribid1 if response1==0 & depvar1==1
replace niazbid5=pribid1 if response1==0 & depvar1==2
replace niazbid5=pribid2 if response1==0 & depvar1==3
replace niazbid5=pribid3 if response1==0 & depvar1==4
replace niazbid5=pribid4 if response1==0 & depvar1==5
replace niazbid5=pribid5 if response1==0 & depvar1==6
replace niazbid5=pribid6 if response1==1 & depvar1==7


gen niazbid5=.
replace niazbid5=pribid1 if response1==1 & depvar1==1
replace niazbid5=pribid1 if response1==0 & depvar1==1
replace niazbid5=pribid2 if response1==1 & depvar1==2
replace niazbid5=pribid2 if response1==0 & depvar1==2
replace niazbid5=pribid3 if response1==1 & depvar1==3
replace niazbid5=pribid3 if response1==0 & depvar1==3
replace niazbid5=pribid4 if response1==1 & depvar1==4
replace niazbid5=pribid4 if response1==0 & depvar1==4
replace niazbid5=pribid5 if response1==1 & depvar1==5
replace niazbid5=pribid5 if response1==0 & depvar1==5
replace niazbid5=pribid6 if response1==1 & depvar1==6
replace niazbid5=pribid6 if response1==0 & depvar1==6
replace niazbid5=pribid6 if response1==1 & depvar1==7

/*experiment code for bid variables*/



gen niazbid4=.
replace niazbid4=pribid1 if response1==1 & depvar1==1
replace niazbid4=pribid1 if response1==0 & depvar1==1
replace niazbid4=pribid1 if response1==1 & depvar1==2
replace niazbid4=pribid1 if response1==0 & depvar1==2
replace niazbid4=pribid2 if response1==1 & depvar1==3
replace niazbid4=pribid2 if response1==0 & depvar1==3
replace niazbid4=pribid3 if response1==1 & depvar1==4
replace niazbid4=pribid3 if response1==0 & depvar1==4
replace niazbid4=pribid4 if response1==1 & depvar1==5
replace niazbid4=pribid4 if response1==0 & depvar1==5
replace niazbid4=pribid5 if response1==1 & depvar1==6
replace niazbid4=pribid5 if response1==0 & depvar1==6
replace niazbid4=pribid5 if response1==1 & depvar1==7



gen niazbid6=.
replace niazbid6=pribid1 if response1==1 & depvar1==1
replace niazbid6=pribid1 if response1==0 & depvar1==1
replace niazbid6=pribid2 if response1==1 & depvar1==2
replace niazbid6=pribid2 if response1==0 & depvar1==2
replace niazbid6=pribid3 if response1==1 & depvar1==3
replace niazbid6=pribid3 if response1==0 & depvar1==3
replace niazbid6=pribid4 if response1==1 & depvar1==4
replace niazbid6=pribid4 if response1==0 & depvar1==4
replace niazbid6=pribid5 if response1==1 & depvar1==5
replace niazbid6=pribid5 if response1==0 & depvar1==5
replace niazbid6=pribid6 if response1==1 & depvar1==6
replace niazbid6=pribid6 if response1==0 & depvar1==6
replace niazbid6=pribid6 if response1==1 & depvar1==7


gen bid9=niazbid6
replace bid9=0 if response1==0 & response2==0


/* Final Code for bid1 and bid2 variables*/

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


***********************************************************************************************************


tab1 hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
tab1 hhfirenoplan hhsidingnoplan hhevaesnoplan hhschimneynoplan hhventsnoplan hhskirtingnoplan
tab1 hhfireyesbought hhsidingyesbought hhevaesyesbought hhschimneysyesbought hhventsyesbought hhskirtingyesbought
tab1 hhfireyesadd hhsidingyesadd hhevaesyesadd hhschimneysyesadd hhventsyesadd hhskirtingyesadd


gen allinvestment1 = . 
replace allinvestment1 = 1 if hhfirerroof == 1 & hhfirersiding == 1 & hheaves==1 & hhsparkchimneys==1 & hhventsmmesh==1 & hhskirtingdecks==1
replace allinvestment1 = 0 if hhfirerroof == 0 & hhfirersiding == 0 & hheaves==0 & hhsparkchimneys==0  & hhventsmmesh==0 & hhskirtingdecks==0

gen allinvestment2= . 
replace allinvestment2 = 1 if hhfirerroof == 1 & hhfirersiding == 1 & hheaves==1 & hhsparkchimneys==1 & hhventsmmesh==1 & hhskirtingdecks==1
replace allinvestment2 = 0 if hhfirerroof == 0 | hhfirersiding == 0 | hheaves==0| hhsparkchimneys==0 |hhventsmmesh==0| hhskirtingdecks==0

gen allinvestment3= . 
replace allinvestment3 = 1 if hhfirerroof == 1 | hhfirersiding == 1 | hheaves==1  |  hhsparkchimneys==1 | hhventsmmesh==1 | hhskirtingdecks==1
replace allinvestment3 = 0 if hhfirerroof == 0 | hhfirersiding == 0 | hheaves==0 | hhsparkchimneys==0 | hhventsmmesh==0| hhskirtingdecks==0


egen combine= rowmax(hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks)

tab1 allinvestment1 allinvestment2 allinvestment3 combine

sum allinvestment1 allinvestment2 allinvestment3  combine


gen hhfirerroof1=hhfirerroof*100000
gen hhfirersiding1=hhfirersiding*10000
gen hheaves1=hheaves*1000
gen hhsparkchimneys1=hhsparkchimneys*100
gen hhventsmmesh1=hhventsmmesh*10
gen hhskirtingdecks1=hhskirtingdecks*1


gen combineinvestment= (hhfirerroof1+hhfirersiding1+hheaves1+hhsparkchimneys1+hhventsmmesh1+hhskirtingdecks1)

tab1 combineinvestment


gen combineinvestment1 = . 
replace combineinvestment1 = 6 if combineinvestment== 111111 
replace combineinvestment1 = 5 if combineinvestment == 11111 | combineinvestment == 111110 | combineinvestment==111101 | combineinvestment==111011 | combineinvestment==110111 | combineinvestment==101111
replace combineinvestment1 = 4 if combineinvestment == 1111 | combineinvestment == 10111 | combineinvestment==11110 | combineinvestment==100111 | combineinvestment==101011 | combineinvestment==101101 | combineinvestment==101110 | combineinvestment==110011| combineinvestment==110101| combineinvestment==110110| combineinvestment==111001| combineinvestment==111010 | combineinvestment==111100
replace combineinvestment1 = 3 if combineinvestment == 111 | combineinvestment == 1011 | combineinvestment==1101 | combineinvestment==1110 | combineinvestment==10011 | combineinvestment==100011 | combineinvestment==100101 | combineinvestment==100110| combineinvestment==101001| combineinvestment==101010| combineinvestment==101100| combineinvestment==110001 | combineinvestment==110010 | combineinvestment==110100| combineinvestment == 111000
replace combineinvestment1 = 2 if combineinvestment == 11 | combineinvestment == 101 | combineinvestment==110 | combineinvestment==1100 | combineinvestment==10010 | combineinvestment==11000 | combineinvestment==100001 | combineinvestment==100010| combineinvestment==100100| combineinvestment==101000| combineinvestment==110000
replace combineinvestment1 = 1 if combineinvestment == 1 | combineinvestment == 10 | combineinvestment==100 | combineinvestment == 1000 | combineinvestment==100000
replace combineinvestment1 = 0 if combineinvestment == 0


tab1 combineinvestment1


*******************************************************************************

*************************************************************************************
*****************************************************************************************





