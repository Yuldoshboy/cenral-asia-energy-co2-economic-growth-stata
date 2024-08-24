
****Description for Variables in the study
**********Countries: Kazakhstan; Kyrgyz Republic; Tajikistan; Turkmenistan; Uzbekistan

*******co2=CO2 emissions (kt)
***********gdp=GDP (constant 2015 US$)
********agriculture=Agriculture, forestry, and fishing, value added (% of GDP)
**********levofwater=Level of water stress: freshwater withdrawal as a proportion of available freshwater resources
**********energy=Energy use (kg of oil equivalent per capita)
********fenergy=Electricity production from oil, gas and coal sources (% of total) 
***********trade=trade openness





wbopendata, indicators(EN.ATM.CO2E.KT;NY.GDP.MKTP.KD;NV.AGR.TOTL.ZS;ER.H2O.FWST.ZS;EG.USE.PCAP.KG.OE;EG.ELC.FOSL.ZS;NE.TRD.GNFS.ZS) country(KAZ;KGZ;TJK;TKM;UZB) clear long
drop region regionname adminregion adminregionname incomelevel incomelevelname lendingtype lendingtypename 
drop countrycode 
egen id=group(countryname)
xtset id year

rename en_atm_co2e_kt CO2
rename ny_gdp_mktp_kd GDP
rename nv_agr_totl_zs AGR
rename er_h2o_fwst_zs WATER
rename eg_use_pcap_kg_oe ENG
rename eg_elc_fosl_zs ELC
rename ne_trd_gnfs_zs TO
keep if year>1991&year<2021


gen lnCO2=log(CO2)
gen lnGDP=log(GDP)
gen lnAGR=log(AGR)
gen lnWATER=log(WATER)
gen lnENG=log(ENG)
gen lnELC=log(ELC)
gen lnTO=log(TO)


************Summary Statistics****************
sum lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO


*******Pearson's Correlation*****************
pwcorr lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO


******Panel Unit Root Tests*******
**********Im-Pesaran-Shin***********
xtunitroot ips lnCO2, trend
xtunitroot ips d.lnCO2, trend
*****lnCO2 is stationary both at level and first difference


xtunitroot ips lnGDP , trend
xtunitroot ips d.lnGDP , trend
*****lnGDP is also stationary both at level and first difference


xtunitroot ips lnAGR , trend
xtunitroot ips d.lnAGR , trend
*****lnAGR is stationary at first difference only


xtunitroot ips lnWATER , trend
xtunitroot ips d.lnWATER , trend
***** lnWATER is stationary at first difference only


xtunitroot ips lnENG , trend
xtunitroot ips d.lnENG , trend
***** lnENG is stationary both at level and first difference


xtunitroot ips lnELC , trend
xtunitroot ips d.lnELC , trend
***** lnELC is also stationary both at level and first difference


xtunitroot ips lnTO , trend
xtunitroot ips d.lnTO , trend
***** lnTO is stationary at first difference only


**************Fisher-PP**********************
xtunitroot fisher lnCO2, pperron lags(4)
xtunitroot fisher d.lnCO2, pperron lags(4)
*****lnCO2 is stationary at first difference


xtunitroot fisher lnGDP , pperron lags(4)
xtunitroot fisher d.lnGDP , pperron lags(4)
***** lnGDP is stationary at first difference


xtunitroot fisher lnAGR , pperron lags(4)
xtunitroot fisher d.lnAGR , pperron lags(4)
***** lnAGR is stationary at first difference


xtunitroot fisher lnWATER , pperron lags(4)
xtunitroot fisher d.lnWATER , pperron lags(4)
***** lnWATER is stationary at first difference


xtunitroot fisher lnENG , pperron lags(4)
xtunitroot fisher d.lnENG , pperron lags(4)
***** lnENG is stationary both at level and first difference


xtunitroot fisher lnELC , pperron lags(4)
xtunitroot fisher d.lnELC , pperron lags(4)
***** lnELC is stationary at first difference


xtunitroot fisher lnTO , pperron lags(4)
xtunitroot fisher d.lnTO , pperron lags(4)
***** lnTO is stationary at first difference


**************Fisher-ADF**********************
xtunitroot fisher lnCO2, dfuller lags(2)
xtunitroot fisher d.lnCO2, dfuller lags(2)
*****lnCO2 is stationary at first difference


xtunitroot fisher lnGDP , dfuller lags(2)
xtunitroot fisher d.lnGDP , dfuller lags(2)
***** lnGDP is stationary at first difference


xtunitroot fisher lnAGR , dfuller lags(2)
xtunitroot fisher d.lnAGR , dfuller lags(2)
***** lnAGR is stationary at first difference


xtunitroot fisher lnWATER , dfuller lags(2)
xtunitroot fisher d.lnWATER , dfuller lags(2)
***** lnWATER is stationary at first difference


xtunitroot fisher lnENG , dfuller lags(2)
xtunitroot fisher d.lnENG , dfuller lags(2)
***** lnENG is stationary both at level and first difference


xtunitroot fisher lnELC , dfuller lags(2)
xtunitroot fisher d.lnELC , dfuller lags(2)
***** lnELC is stationary at first difference


xtunitroot fisher lnTO , dfuller lags(2)
xtunitroot fisher d.lnTO , dfuller lags(2)
***** lnTO is stationary at first difference


***********Pedroni Cointegration************************
xtcointtest pedroni lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO, ar(same)
xtcointtest pedroni lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO, ar(panelspecific)


*********Panel FMOLS and DOLS analysis************
cointreg lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO, est(dols) noconstant dlag(4)
cointreg lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO, est(fmols) noconstant dlag(4)


*********Panel ARDL analysis*****************
xtpmg d.( lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO), lr(l.lnCO2 lnGDP lnAGR lnWATER lnENG lnELC lnTO) replace pmg full


*********Granger non causality tests************
xtgranger lnCO2 lnGDP
xtgranger lnCO2 lnAGR
xtgranger lnCO2 lnWATER
xtgranger lnCO2 lnENG
xtgranger lnCO2 lnELC
xtgranger lnCO2 lnTO


***********Country specific granger causality tests***************
xtgranger lnCO2 lnGDP if id==1
xtgranger lnCO2 lnGDP if id==2
xtgranger lnCO2 lnGDP if id==3
xtgranger lnCO2 lnGDP if id==4
xtgranger lnCO2 lnGDP if id==5
xtgranger lnCO2 lnAGR if id==1
xtgranger lnCO2 lnAGR if id==2
xtgranger lnCO2 lnAGR if id==3
xtgranger lnCO2 lnAGR if id==4
xtgranger lnCO2 lnAGR if id==5
xtgranger lnCO2 lnWATER if id==1
xtgranger lnCO2 lnWATER if id==2
xtgranger lnCO2 lnWATER if id==3
xtgranger lnCO2 lnWATER if id==4
xtgranger lnCO2 lnWATER if id==5
xtgranger lnCO2 lnENG if id==1
xtgranger lnCO2 lnENG if id==2
xtgranger lnCO2 lnENG if id==3
xtgranger lnCO2 lnENG if id==4
xtgranger lnCO2 lnENG if id==5
xtgranger lnCO2 lnELC if id==1
xtgranger lnCO2 lnELC if id==2
xtgranger lnCO2 lnELC if id==3
xtgranger lnCO2 lnELC if id==4
xtgranger lnCO2 lnELC if id==5
xtgranger lnCO2 lnTO if id==1
xtgranger lnCO2 lnTO if id==2
xtgranger lnCO2 lnTO if id==4
xtgranger lnCO2 lnTO if id==5


*****/////////////////End of the task***********////////////

