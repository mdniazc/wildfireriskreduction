use "C:\Users\16056\OneDrive\Desktop\Resource Economics-Research\Stata  Resource Economics\testdataset_thesis.dta" 




* Maximam Likelihood to estimate WTP 
*cleaning the data set with missing value, *************************

mi impute mvn age bmi = attack smokes hsgrad female, replace nolog
mi impute chained (regress) age bmi = attack smokes hsgrad female, replace
mi impute regress bmi attack smokes age hsgrad if female==1, add(20)
mi impute regress bmi attack smokes age hsgrad if female==0, replace

*Data cleaning  for missing values ****


mi register imputed riskreduction 



summarize privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6
tab1 privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6, m

mi register imputed privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

mi register imputed bid1 bid2 response1 response2

mi register imputed bid3 bid4 response3 response4

doubleb bid3 bid4 response3 response4


mi impute regress riskreduction  bid1 bid2 response1 response2, add(20) rseed(2232)

mi set mlong 

mi misstable summarize privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6
mdesc privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

mi misstable pattern privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

mi register imputed  privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

mi impute mvn privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6, add (10) 



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


list privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

summarize privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

tab1  privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

tab1  privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6, m

corr  privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6

pwcorr privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6, obs

gen sum1= privatebid1 + privatebid2 + privatebid3 + privatebid4 + privatebid5 + privatebid6

list privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6 sum1 sum2 sum3 avg1 avg2 avg3

order privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6 sum1 sum2

egen sum2= rowtotal (privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6) 

egen sum3= rowtotal (privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6), missing


gen avg1= (privatebid1 + privatebid2 +privatebid3 +privatebid4 +privatebid5+ privatebid6)/6


egen avg2= rowmean (privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6)

egen avg3= rowmean (privatebid1 - privatebid6)

list privatebid1 privatebid2 privatebid3 privatebid4 privatebid5 privatebid6  avg1 avg2 avg3



egen miss= rowmiss (privatebid1 - privatebid6)
egen nomiss= rownomiss (privatebid1 - privatebid6)

doubleb bid1 bid2 response1 response2
doubleb bid3 bid4 response3 response4
gen newvar1= 


/* Data Imputations */

misstable sum, gen (miss_)

tab1 miss_bid1 miss_bid2

mi set wide


mi misstable summarize taxbreaks1 lowinsurance1 lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1, all



mi register regular taxbreaks1

mi register imputed lowinsurance1 lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1



mi estimate: logistic lowinsurance1 lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1


/* Imputed data set*/



mi misstable pattern, frequency 

mi set wide

mi register imputed lowinsurance1 lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1

mi impute chained (logit) lowinsurance1 lawmaintain1 govtsubsidy1 similarvalue1 similargoal1 similarthink1, add (5) rseed (9478)

mi describe





mi register imputed bid1 bid2 bid3 bid4 
mi impute chained (regress) bid1 bid2 bid3 bid4 , add (30) rseed (9478)

mi register imputed response1 response2 response3 response4
mi impute chained (logit) response1 response2 response3 response4, add (30) rseed (9478)

mi impute regress response1 response2 response3 response4, add(1) noisily 

mi estimate, dots: doubleb bid1 bid2 response1 response2


************************************ index variable creation**********************************************
**********************************************************************************************************
mi set wide
mi register imputed 

mi impute chained ( logit ) commatt_11 commatt_21 commatt_31 commatt_41 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks, add (5) rseed (9478)





/* Feel about the community */


sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_71
sum feel_1 feel_2 feel_3 feel_4 feel_7


mi set wide
mi register imputed commatt_11 commatt_21 commatt_31 commatt_41 commatt_71
mi impute chained ( logit ) commatt_11 commatt_21 commatt_31 commatt_41 commatt_71, add (5) rseed (9478)



gen communityatt = _5_commatt_11+_5_commatt_21 +_5_commatt_31 +_5_commatt_41 +_5_commatt_71
tab1 communityatt


cap drop communityatt1
#delimit;
gen byte communityatt1=round(((_5_commatt_11+_5_commatt_21 +_5_commatt_31 +_5_commatt_41 +_5_commatt_71)/5)*100);
#delimit cr
label variable communityatt1  "Feel about the community index(0-5)"
tab communityatt1
							  


/* In your community- community wildfire planning */

sum  commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1
sum network_5 network_6 network_7 network_8 network_9 agree_5 agree_7
 
mi register imputed commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1
mi impute chained (logit) commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1, add (5) rseed (9478)



gen wildfireplanning= _5_commnetwork51 + _5_commnetwork61 + _5_commnetwork71+ _5_commnetwork81  + _5_commnetwork91+  _5_coordinatedfs1+ _5_comminvestdfs1
tab1 wildfireplanning

cap drop wildfireplanning1
#delimit;
gen byte wildfireplanning1=round(((_5_commnetwork51 + _5_commnetwork61 + _5_commnetwork71+ _5_commnetwork81  + _5_commnetwork91+  _5_coordinatedfs1+ _5_comminvestdfs1)/7)*100);
#delimit cr
label variable wildfireplanning1  "community wildfireplanning index(0-7)"
tab wildfireplanning1



/* Attitudes about the govt */


sum taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1
sum agree_1 agree_2 agree_3 agree_4 agree_6

mi register imputed taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1
mi impute chained (logit) taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1, add (5) rseed (9478)
tab1  _5_taxbreaks1 _5_lowinsurance1 _5_lawmaintain1 _5_govtsubsidy1 _5_protectvoluntary1


gen govtpolicyFSI=_5_taxbreaks1+ _5_lowinsurance1+ _5_lawmaintain1+ _5_govtsubsidy1+ _5_protectvoluntary1
tab1 govtpolicyFSI

cap drop govtpolicyFSI1
#delimit;
gen byte govtpolicyFSI1=round(((_5_taxbreaks1+ _5_lowinsurance1+ _5_lawmaintain1+ _5_govtsubsidy1+ _5_protectvoluntary1)/5)*100);
#delimit cr
label variable govtpolicyFSI1  "govt policy for fire safe investment index(0-5)"
tab govtpolicyFSI1


/* Attitudes about public land management agencies */


sum similarvalue1 similargoal1 similarthink1 samepriorities1
sum govt_1 govt_2 govt_3 govt_4


mi register imputed similarvalue1 similargoal1 similarthink1 samepriorities1
mi impute chained (logit) similarvalue1 similargoal1 similarthink1 samepriorities1, add (5) rseed (9478)
tab1 _5_similarvalue1 _5_similargoal1 _5_similarthink1 _5_samepriorities1


gen landmanage=_5_similarvalue1+ _5_similargoal1+ _5_similarthink1+ _5_samepriorities1
tab1 landmanage


cap drop landmanage1
#delimit;
gen byte landmanage1=round(((_5_similarvalue1+ _5_similargoal1+ _5_similarthink1+ _5_samepriorities1)/4)*100);
#delimit cr
label variable landmanage1  "attitudes of public land management agencies index(0-4)"
tab landmanage1


/*External effect * Externality or external effect from neighbors*/ 
sum nearneighbor1 otherneighbor1 respcommmunity1 
sum more_1 more_2 more_3

mi register imputed nearneighbor1 otherneighbor1 respcommmunity1 
mi impute chained (logit) nearneighbor1 otherneighbor1 respcommmunity1 , add (5) rseed (9478)
tab1 _5_nearneighbor1 _5_otherneighbor1 _5_respcommmunity1 

gen externaleffect= _5_nearneighbor1+ _5_otherneighbor1+ _5_respcommmunity1 
tab1 externaleffect

cap drop externaleffect1
#delimit;
gen byte externaleffect1=round(((_5_nearneighbor1+ _5_otherneighbor1+ _5_respcommmunity1 )/3)*100);
#delimit cr
label variable externaleffect1  "external effect from neighbors index (0-3)"
tab1 externaleffect1





************************Summary Statistics/Perceived wild fire risk******************
 
sum fire_risk efficacy 
tab1 fire_risk efficacy 



mi register imputed fire_risk efficacy 
mi impute chained (regress) fire_risk efficacy , add (5) rseed (9478)
tab1 _30_fire_risk _30_efficacy


cap drop fire_risk_IM
#delimit;
gen byte fire_risk_IM=round(((_30_fire_risk )/1.133416 )*100);
#delimit cr
label variable fire_risk_IM  "fire risk variable  index (0-1.133416)"
tab1 fire_risk_IM

cap drop efficay_IM
#delimit;
gen byte efficay_IM=round(((_30_efficacy )/ 1.222158  )*100);
#delimit cr
label variable efficay_IM  "fire risk variable  index (0- 1.222158 )"
tab1 efficay_IM


*************** will do impute them later**********************************
******************Does this house have*********************

sum hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
sum hh_1_1 hh_1_2 hh_1_3 hh_1_4 hh_1_5 hh_1_6
 

 
 
mi unregister hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
mi register imputed hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
mi impute chained (logit) hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks , add (5) rseed (9478)

gen householdfsp = _5_hhfirerroof+ _5_hhfirersiding+ _5_hheaves+ _5_hhsparkchimneys+ _5_hhventsmmesh+ _5_hhskirtingdecks
tab1 householdfsp

cap drop householdfsp1
#delimit;
gen byte householdfsp1=round(((_5_hhfirerroof+ _5_hhfirersiding+ _5_hheaves+ _5_hhsparkchimneys+ _5_hhventsmmesh+ _5_hhskirtingdecks )/6)*100);
#delimit cr
label variable householdfsp1  "household firesafe investment index (0-3)"
tab1 householdfsp1
 
 
************* inner zone around your house *****************************


sum greenlawn nonflammable cheatinvagrass mapleoaks evgreentrees junibushes nativeshrubs

*************** outer zone around your house**************************************

sum ozgreenlawn  oznonflammable ozmapleoaks ozevgreentrees ozjunishurbs oznativeplants ozovgrbrushy oztrimtrees ozdeadtrees


/* UTILITY HIT AND AESTHETIC PRIVACY */ 


suum c5HLA c6LLA  c7LRP c8WLH 

sum  choice_5  choice_6  choice_7  choice_8

/*BIOPHYSICAL VARIABLE */ 

sum aspect elevdiff slope fuel brush grs pj tmbr lghtn wind