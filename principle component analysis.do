


/* priniciple component  analysis*/

correlate  commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH


global xlist commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH woodpile1 access1 shed1 tank1 roof1 water1

global comm_id community
global ncomp 2

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
scoreplot, mlabel($comm_id)



* Scater plot of the loadings and score vaiables 
estat loading 
predict pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8 pc9 pc10, score 


*KMO measure  of sampling adequacy 

estat kmo



*****************************************************
*********************************************************
***************************************************************
global ncomp 15

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

alpha  $xlist

estat common 

*scatter plots of the loading and score variables 

loadingplot
scoreplot
*score of the componets 

predict f1 f2 f3  f4 f5 f6 f7 f8 f9

*KMO measure of sampling adequacy

estat kmo

* average interitem covarianece 

alpha $xlist 



/* 10 factor based on */



mi set wide
mi register imputed f1 f2 f3 f4 f5 f6 f7
mi impute chained ( truncreg ) f1 f2 f3 f4 f5 f6 f7, add (5) rseed (9478)


doubleb bid1 bid2 response1 response2 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7
doubleb bid3 bid4 response3 response4 _5_f1 _5_f2 _5_f3 _5_f4 _5_f5 _5_f6 _5_f7



/* new way to analyze the data */

mi set wide

mi  unregister commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH woodpile1 access1 shed1 tank1 roof1 water1  noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 important1 preventpub1 movebeforebenefit1 insurancecoveredall1 peacemindpub1 conflictcommunity1

mi register imputed  commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH woodpile1 access1 shed1 tank1 roof1 water1  noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 important1 preventpub1 movebeforebenefit1 insurancecoveredall1 peacemindpub1 conflictcommunity1


mi impute chained (logit) commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH woodpile1 access1 shed1 tank1 roof1 water1, add(5) rseed (9478)


 noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 important1 preventpub1 movebeforebenefit1 insurancecoveredall1 peacemindpub1 conflictcommunity1, add(5) rseed (9478)

sum commatt_11 commatt_21 commatt_31 commatt_41 commatt_51 commatt_71 commnetwork51 commnetwork61 commnetwork71 commnetwork81 commnetwork91 coordinatedfs1 comminvestdfs1 taxbreaks1 lowinsurance1  lawmaintain1 govtsubsidy1 protectvoluntary1 similarvalue1 similargoal1 similarthink1 samepriorities1 nearneighbor1 otherneighbor1 respcommmunity1  hhfirerroof hhfirersiding hheaves hhsparkchimneys hhventsmmesh hhskirtingdecks c5HLA c6LLA c7LRP  c8WLH woodpile1 access1 shed1 tank1 roof1 water1  noafford1 novalue1 prevent1 notachieved1 costnothing1 smallrisk1 allcovered1 movebenefit1 peacemind1 altruism1 notaffloss1 cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1 important1 preventpub1 movebeforebenefit1 insurancecoveredall1 peacemindpub1 conflictcommunity1

global xlist _5_commatt_11 _5_commatt_21 _5_commatt_31 _5_commatt_41 _5_commatt_51 _5_commatt_71 _5_commnetwork51 _5_commnetwork61 _5_commnetwork81 _5_commnetwork91 _5_coordinatedfs1 _5_comminvestdfs1 _5_taxbreaks1 _5_lowinsurance1 _5_lawmaintain1 _5_govtsubsidy1 _5_protectvoluntary1 _5_similarvalue1 _5_similargoal1 _5_similarthink1 _5_samepriorities1 _5_nearneighbor1 _5_otherneighbor1 _5_respcommmunity1 _5_hhfirerroof _5_hhfirersiding _5_hheaves _5_hhsparkchimneys _5_hhventsmmesh _5_hhskirtingdecks _5_c5HLA _5_c6LLA _5_c7LRP _5_access1 _5_shed1 _5_tank1 _5_roof1 _5_water1 _5_noafford1 _5_novalue1 _5_prevent1 _5_notachieved1 _5_costnothing1 _5_smallrisk1 _5_allcovered1 _5_movebenefit1 _5_peacemind1 _5_altruism1 _5_notaffloss1 _5_cannotafford1 _5_prognovalue1 _5_altrusimpub1 _5_dontbelieve1 _5_ownpropertydfs1 _5_smallriskchange1 _5_preventpub1 _5_movebeforebenefit1 _5_insurancecoveredall1 _5_peacemindpub1 _5_c8WLH _5_woodpile1



global xlist cannotafford1 prognovalue1 altrusimpub1 dontbelieve1 ownpropertydfs1 smallriskchange1  insurancecoveredall1

alpha  prognovalue1  dontbelieve1 ownpropertydfs1 smallriskchange1  