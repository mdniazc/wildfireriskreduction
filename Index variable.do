use "C:\Users\16056\OneDrive\Desktop\STATA DATA ANALYSIS\12- IndexwithoutFactorAnalysis.dta"

************************************ index variable creation**********************************************
**********************************************************************************************************
sum _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP _20_c8WLH _20_noafford1 _20_novalue1 _20_notachieved1 _20_smallrisk1 _20_allcovered1 _20_altruism1 _20_cannotafford1 _20_prognovalue1 _20_altrusimpub1 _20_dontbelieve1 _20_ownpropertydfs1 _20_smallriskchange1 _20_insurancecoveredall1 




/* Feel about the community */


sum _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71

gen communityatt = _20_commatt_11 +_20_commatt_21+ _20_commatt_31 +_20_commatt_41+ _20_commatt_51+ _20_commatt_71
tab1 communityatt


cap drop communityatt1
#delimit;
gen byte communityatt1=round(((_20_commatt_11+ _20_commatt_21+ _20_commatt_31+ _20_commatt_41+ _20_commatt_51+ _20_commatt_7)/6)*100);
#delimit cr
label variable communityatt1  "Feel about the community index(0-6)"
tab communityatt1
							  


/* In your community- community wildfire planning */

sum  20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20



gen wildfireplanning= _20_commnetwork51+ _20_commnetwork61+ _20_commnetwork71+ _20_commnetwork81+ _20_commnetwork91 
tab1 wildfireplanning

cap drop wildfireplanning1
#delimit;
gen byte wildfireplanning1=round(((_20_commnetwork51+ _20_commnetwork61+ _20_commnetwork71+ _20_commnetwork81+ _20_commnetwork91)/5)*100);
#delimit cr
label variable wildfireplanning1  "community wildfireplanning index(0-5)"
tab wildfireplanning1



/* Attitudes about the govt */


sum _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1


gen govtpolicyFSIIndex=_20_coordinatedfs1+ _20_comminvestdfs1+ _20_taxbreaks1+ _20_lowinsurance1+ _20_lawmaintain1+ _20_govtsubsidy1+ _20_protectvoluntary1
tab1 govtpolicyFSII

cap drop govtpolicyFSI1
#delimit;
gen byte govtpolicyFSI1=round(((_20_coordinatedfs1+ _20_comminvestdfs1+ _20_taxbreaks1+ _20_lowinsurance1+ _20_lawmaintain1+ _20_govtsubsidy1+ _20_protectvoluntary1)/7)*100);
#delimit cr
label variable govtpolicyFSI1  "govt policy for fire safe investment index(0-5)"
tab govtpolicyFSI1


/* Attitudes about public land management agencies */


sum _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 
sum govt_1 govt_2 govt_3 govt_4


tab1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 


gen landmanage=_20_similarvalue1+ _20_similargoal1+ _20_similarthink1+ _20_samepriorities1 
tab1 landmanage


cap drop landmanage1
#delimit;
gen byte landmanage1=round(((_20_similarvalue1+ _20_similargoal1+ _20_similarthink1+ _20_samepriorities1 )/4)*100);
#delimit cr
label variable landmanage1  "attitudes of public land management agencies index(0-4)"
tab landmanage1


/*External effect * Externality or external effect from neighbors*/ 
sum _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1
sum more_1 more_2 more_3


tab1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1

gen externaleffect= _20_nearneighbor1+ _20_otherneighbor1+ _20_respcommmunity1
tab1 externaleffect

cap drop externaleffect1
#delimit;
gen byte externaleffect1=round(((_20_nearneighbor1+ _20_otherneighbor1+ _20_respcommmunity1 )/3)*100);
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

sum _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks
sum hh_1_1 hh_1_2 hh_1_3 hh_1_4 hh_1_5 hh_1_6
 
tab1  _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks

gen householdfsp = _20_hhfirerroof+ _20_hhfirersiding+ _20_hheaves+ _20_hhsparkchimneys+ _20_hhventsmmesh+ _20_hhskirtingdecks
tab1 householdfsp

cap drop householdfsp1
#delimit;
gen byte householdfsp1=round(((_20_hhfirerroof+ _20_hhfirersiding+ _20_hheaves+ _20_hhsparkchimneys+ _20_hhventsmmesh+ _20_hhskirtingdecks )/6)*100);
#delimit cr
label variable householdfsp1  "household firesafe investment index (0-6)"
tab1 householdfsp1
 
/* priavte Program value */
 
gen priprogvalue = _20_novalue1+ _20_notachieved1+ _20_smallrisk1
tab1 priprogvalue
 
cap drop priprogvalue1
#delimit;
gen byte priprogvalue1=round((( _20_novalue1+ _20_notachieved1+ _20_smallrisk1 )/3)*100);
#delimit cr
label variable priprogvalue1  "private program value index (0-3)"
tab1 priprogvalue1
 
 /* public Program value */
 
cap drop pubprogvalue1
#delimit;
gen byte pubprogvalue1=round((( _20_prognovalue1+ _20_dontbelieve1 + _20_smallriskchange1  )/3)*100);
#delimit cr
label variable pubprogvalue1  "private program value index (0-3)"
tab1 pubprogvalue1
 


/* UTILITY HIT AND AESTHETIC PRIVACY */ 


gen utilityhits1 = _20_c5HLA +_20_c6LLA+ _20_c7LRP+ _20_c8WLH
tab1 utilityhits1

cap drop utilityhits
#delimit;
gen byte utilityhits=round((( _20_c5HLA +_20_c6LLA+ _20_c7LRP+ _20_c8WLH  )/4)*100);
#delimit cr
label variable utilityhits  "utility hits ans aesthestic privacy index (0-4)"
tab1 utilityhits



/*BIOPHYSICAL VARIABLE */ 

sum aspect elevdiff slope fuel brush grs pj tmbr lghtn wind

/* modeling things */


/* Delete missing observations and same observations for the both  data set */

drop if missing(response1)
drop if missing(response2)
drop if missing(response3)
drop if missing(response4)

 
/* private program */

doubleb bid1 bid2 response1 response2 communityatt1 wildfireplanning1 govtpolicyFSI1 landmanage1 externaleffect1 householdfsp1 utilityhits priprogvalue1 baselinerisk incomeThousand riskreduction _20_noafford1 _20_allcovered1 _20_altruism1 lossThousand _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol 


/* public program value */

doubleb bid3 bid4 response3 response4 communityatt1 wildfireplanning1 govtpolicyFSI1 landmanage1 externaleffect1 householdfsp1 utilityhits pubprogvalue1 baselinerisk incomeThousand riskreduction _20_cannotafford1 _20_altrusimpub1  _20_ownpropertydfs1  _20_insurancecoveredall1  _40_own_yrs _40_agehome _40_age  _40_fire_risk _40_efficacy _40_rtol 