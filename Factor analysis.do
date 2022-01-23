
/* factor analysis*/

corr commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH



factortest commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH
 

factor commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH, pcf

rotate
sortl


alpha commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH





factor commatt_11 commatt_21 commatt_31 commatt_41 commatt_71, pcf
rotate
sortl
alpha commatt_21 commatt_11 commatt_41 commatt_31 commatt_71
predict F_Att

factor commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1, pcf
rotate
sortl
alpha commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 
predict F_CWPlan


factor taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1, pcf
rotate
sortl
alpha taxbreaks1 lowinsurance1   govtsubsidy1 
predict F_GFSI


sum similarvalue1 similargoal1 similarthink1 samepriorities1
factor similarvalue1 similargoal1 similarthink1 samepriorities1, pcf
rotate 
sortl
alpha similarvalue1 similargoal1 similarthink1 samepriorities1
predict F_PLM

sum nearneighbor1 otherneighbor1 respcommmunity1
factor nearneighbor1 otherneighbor1 respcommmunity1, pcf 
rotate
sortl
alpha nearneighbor1 otherneighbor1 respcommmunity1
predict F_EEN


sum hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
factor hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks, pcf
rotate 
sortl
alpha hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks
predict F_HFSI


sum c5HLA c6LLA c7LRP  c8WLH
factor c5HLA c6LLA c7LRP  c8WLH, pcf
rotate 
sortl
alpha c5HLA c6LLA c7LRP  c8WLH
predict F_UHAP


**************************************************October 16, 2020*****************************
/* Fator analysis results */

global xlist _20_commatt_11 _20_commatt_21 _20_commatt_31 _20_commatt_41 _20_commatt_51 _20_commatt_71 _20_commnetwork51 _20_commnetwork61 _20_commnetwork71 _20_commnetwork81 _20_commnetwork91 _20_coordinatedfs1 _20_comminvestdfs1 _20_taxbreaks1 _20_lowinsurance1 _20_lawmaintain1 _20_govtsubsidy1 _20_protectvoluntary1 _20_similarvalue1 _20_similargoal1 _20_similarthink1 _20_samepriorities1 _20_nearneighbor1 _20_otherneighbor1 _20_respcommmunity1 _20_hhfirerroof _20_hhfirersiding _20_hheaves _20_hhsparkchimneys _20_hhventsmmesh _20_hhskirtingdecks _20_c5HLA _20_c6LLA _20_c7LRP _20_c8WLH  


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




/* public program */ 
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


