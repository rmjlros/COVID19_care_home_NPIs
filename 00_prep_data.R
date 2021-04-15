# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to read in publicly available data and format

wdir<-"~/Documents/GitHub/COVID19_care_home_NPIs/"
setwd(wdir)

### paths
  
deaths_ONS_file<-"Data/julydeathsinvolvingcovid19inthecaresectordataset02072020155122_CLEAN.xlsx"
CQC_care_home_data<-"Data/01_December_2020_HSCA_Active_Locations.xlsx"


### CQC data

# read
CQC_care_homes<-deaths_ONS_all<-readxl::read_excel(CQC_care_home_data, sheet="HSCA Active Locations")
CQC_care_homes<-CQC_care_homes%>%mutate_all(as.character)
CQC_care_homes$`Care homes beds`<-as.numeric(CQC_care_homes$`Care homes beds`)
CQC_care_homes<-CQC_care_homes%>%filter(`Care home?`=="Y")%>%filter(`Care homes beds`!=0)
CQC_care_homes_older_people<-CQC_care_homes%>%filter(`Service user band - Older People`=="Y")
CQC_care_homes_older_people_nh<-CQC_care_homes_older_people%>%filter(`Service type - Care home service with nursing`=="Y")%>%filter(is.na(`Service type - Care home service without nursing`))
CQC_care_homes_older_people_res<-CQC_care_homes_older_people%>%filter(is.na(`Service type - Care home service with nursing`))%>%filter(`Service type - Care home service without nursing`=="Y")
CQC_care_homes_older_people_nh_res<-CQC_care_homes_older_people%>%filter(`Service type - Care home service with nursing`=="Y")%>%filter(`Service type - Care home service without nursing`=="Y")
CQC_care_homes_older_people_only<-CQC_care_homes_older_people%>%filter(is.na(`Service user band - Younger Adults`))
CQC_care_homes_older_people_only_nh<-CQC_care_homes_older_people_only%>%filter(`Service type - Care home service with nursing`=="Y")%>%filter(is.na(`Service type - Care home service without nursing`))
CQC_care_homes_older_people_only_res<-CQC_care_homes_older_people_only%>%filter(is.na(`Service type - Care home service with nursing`))%>%filter(`Service type - Care home service without nursing`=="Y")
CQC_care_homes_older_people_only_nh_res<-CQC_care_homes_older_people_only%>%filter(`Service type - Care home service with nursing`=="Y")%>%filter(`Service type - Care home service without nursing`=="Y")



### Death rates within the LTCF for residents without COVID 

# other variables assumed
occupancy<-0.8
CFR<-0.25 
# read in death data ONS for all residents dying within care home all causes
deaths_ONS_all<-readxl::read_excel(deaths_ONS_file, sheet="Table 5")
deaths_ONS_all<-deaths_ONS_all[,c(1,6)] #  only interested in CH England
colnames(deaths_ONS_all)<-deaths_ONS_all[4,] # column names
deaths_ONS_all<-data.frame(deaths_ONS_all[-c(1:4),]) # remove intro rows
deaths_ONS_all<-data.frame(deaths_ONS_all[-c(104:nrow(deaths_ONS_all)),]) # remove legend rows
deaths_ONS_all<-deaths_ONS_all%>%mutate_all(as.character)
deaths_ONS_all<-deaths_ONS_all%>%mutate_all(as.numeric)
deaths_ONS_all$Date<-as.Date(deaths_ONS_all$Date, origin="1899-12-30")
names(deaths_ONS_all)<-c("Date", "N_deaths_all_ch")
# read in death data ONS for residents dying within care home from COVID
readxl::excel_sheets(deaths_ONS_file)
deaths_ONS_COVID<-readxl::read_excel(deaths_ONS_file, sheet="Table 6")
deaths_ONS_COVID<-deaths_ONS_COVID[,c(1,6,7,8)] #  only interested in CH England
colnames(deaths_ONS_COVID)<-deaths_ONS_COVID[4,] # column names
deaths_ONS_COVID<-data.frame(deaths_ONS_COVID[-c(1:4),]) # remove intro rows
deaths_ONS_COVID<-data.frame(deaths_ONS_COVID[-c(104:nrow(deaths_ONS_COVID)),]) # remove legend
deaths_ONS_COVID<-deaths_ONS_COVID%>%mutate_all(as.character)
deaths_ONS_COVID<-deaths_ONS_COVID%>%mutate_all(as.numeric)
deaths_ONS_COVID$Date<-as.Date(deaths_ONS_COVID$Date, origin="1899-12-30")
names(deaths_ONS_COVID)<-c("Date", "N_deaths_COVID_ch","N_deaths_COVID_h", "N_deaths_COVID_other")
# calculate  non-COVID deaths occurring within LTCFs in last month of data
deaths_ONS_in_LTCFs<-merge(deaths_ONS_all, deaths_ONS_COVID, by="Date")
deaths_ONS_in_LTCFs$N_deaths_woCOVID_ch<-deaths_ONS_in_LTCFs$N_deaths_all_ch-deaths_ONS_in_LTCFs$N_deaths_COVID_ch
deaths_ONS_in_LTCFs_MayJune<-slice_tail(deaths_ONS_in_LTCFs, n=30)
# number of residents in June 2020
n_residents_June2020<-460000*occupancy #460000 beds registered in care homes June CQC report
# number of residents without COVID in June 2020
n_residents_woCOVID_June2020<-n_residents_June2020-(0.11*n_residents_June2020) # Vivaldi publication July 11% of residents tested positive from pandemic start [!not exactly the number that had covid during the time period considered]
# daily death rate in residents without COVID in May 2020
daily_deathrate_woCOVID_MayJune2020<-sum(deaths_ONS_in_LTCFs_MayJune$N_deaths_woCOVID)/(30*n_residents_woCOVID_June2020)
# adjust daily death rate in residents without COVID in May 2020 by nursing vs residential
daily_deathrate_woCOVID_prepandemic_nh<-(1/283)*0.55 # Median LoS in residential LTCFs 544.5 days, 283 days in nursing LTCFs. 50% residential LTCF residents died within 30 days of leaving LTCF, 55% for nursing LTCFs.
daily_deathrate_woCOVID_prepandemic_res<-((1/544.5)*0.5) # Median LoS in residential LTCFs 544.5 days, 283 days in nursing LTCFs. 50% residential LTCF residents died within 30 days of leaving LTCF, 55% for nursing LTCFs.
daily_deathrate_woCOVID_prepandemic_ratio_res_to_nh<-daily_deathrate_woCOVID_prepandemic_res/daily_deathrate_woCOVID_prepandemic_nh
daily_deathrate_woCOVID_MayJune2020_nh<-daily_deathrate_woCOVID_MayJune2020/((0.5*daily_deathrate_woCOVID_prepandemic_ratio_res_to_nh)+0.5) # 50% residential 50% nursing homes from CQC register 1st July 2020
daily_deathrate_woCOVID_MayJune2020_res<-daily_deathrate_woCOVID_prepandemic_ratio_res_to_nh*daily_deathrate_woCOVID_MayJune2020_nh


### Hospital admissions (SUS data)
admissions_df<-data.frame(weekstart=c("15/06/2020","30/03/2020"),
                          count_nh=c(0.001201679,0.001041618),
                          count_res=c(0.001234366,0.001096026))
rate_h_nh<-(as.numeric(as.character(admissions_df%>%filter(weekstart==date_origin_hosp_rate)%>%select(count_nh))))
rate_h_res<-(as.numeric(as.character(admissions_df%>%filter(weekstart==date_origin_hosp_rate)%>%select(count_res))))


### community data (Davies et al. 2020)
com_prev<-data.frame(date=c(rep("2020-07-15",6),
                           rep("2020-09-30",6),
                           rep("2020-04-01",6)),
                    variable=rep(c("S", "E", "Ip", "Is", "Ia", "R"),3),
                    median_sum_p=c(c(0.8855021569,0.0002357542,0.0000537222,0.000120,0.0002999070,0.1137834217),
                                   c(0.8673498942, 0.0019565327,0.0004245301,0.0008442449,0.0019834496,0.1274860220),
                                   c(0.942896449, 0.005982399,0.001547956, 0.003897325, 0.008245298, 0.037443861)))

inf_states_t1<-com_prev%>%filter(date==date_origin_com_prev)
c_inf_t1<-inf_states_t1%>%filter(variable=="Ip"|variable=="Is"|variable=="Ia")%>%dplyr::summarise(median_sum_p=sum(median_sum_p)) 
v_inf_t1<-inf_states_t1%>%filter(variable=="Ip"|variable=="Ia")%>%dplyr::summarise(median_sum_p=sum(median_sum_p)) 
staff_inf_t1<-inf_states_t1

### outcomes COVID-19 hospital (SUS data)
COVID_outcomes_MayJune<-0.30595

### hospital infection (Evans et al. 2021)
hospital_df<-data.frame(date=c("2020-07-15","2020-05-01","2020-04-01"),
                        noncovidH_discharges_woIc_mean_p_S=c(0.9924769, 0.9879088, 0.9961445),
                        noncovidH_discharges_woIc_mean_p_E=c(0.00412744,0.008081162,0.00286666),
                        noncovidH_discharges_woIc_mean_p_Ipc=c(0.0009540635,0.001528314,0.000432371),
                        noncovidH_discharges_woIc_mean_p_Ic=c(0,0,0),
                        noncovidH_discharges_woIc_mean_p_Ia=c(0.0018929,0.002038045,0.000556423),
                        noncovidH_discharges_woIc_mean_p_R=c(0.0005486863,0.0004436891,0))
hospital_df_t1<-hospital_df%>%filter(date==date_origin_hosp_prev)

### over 70s community S vs R (Davies et al. 2020)
p_S_vs_R_df<-data.frame(date=c("2020-07-15","2020-05-01","2020-04-01"),
                        median_value=c(0.9408466, 0.9539467, 0.980676))
p_S_vs_R<-p_S_vs_R_df%>%filter(date==date_origin_hosp_prev)%>%select(median_value)

### proportion leaving hospital in each state
S_hospital_df_t1<-
  (hospital_df_t1$noncovidH_discharges_woIc_mean_p_S+hospital_df_t1$noncovidH_discharges_woIc_mean_p_R)*p_S_vs_R
E_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_E
Ipc_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ipc
Ic_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ic
Ia_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ia
R_hospital_df_t1<-(hospital_df_t1$noncovidH_discharges_woIc_mean_p_S+hospital_df_t1$noncovidH_discharges_woIc_mean_p_R)*(1-p_S_vs_R)

