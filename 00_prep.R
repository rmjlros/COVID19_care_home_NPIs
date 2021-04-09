# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to read in publicly available data


### prep

user <- system("whoami", intern = TRUE)

# alicia paths
if (user == "eoccaros"){
  
  death_CQC_file<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/Deaths/collated-timeseries-location-dataset.csv"
  deaths_ONS_file<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/Deaths/julydeathsinvolvingcovid19inthecaresectordataset02072020155122_CLEAN.xlsx"
  CQC_care_home_data<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/CQC registry/01_December_2020_HSCA_Active_Locations.xlsx"
}

nick_file<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/Nick/alicia_14oct.rds" #England 500 runs model 
steph_file3<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/Steph/updated_discharges_for_AR_14102020.csv" #data sent on 14th October
h_admissions_4_file<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/THF/Adm_rates_chrs_chnursing_forAlicia.csv"
COVID_outcomes_file<-"/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Data/THF/Chr_covid_outcomes.csv"


# load packages
# set.seed(56526232) #594709947L
# library(plyr)
# library(dplyr)
# library(magrittr)
# library(ggplot2)
# library(gridExtra)
# library(patchwork)
# library(qs)
# library(reshape2)
require(Bolstad)
require(readxl)



### read in data and prep

## read in data CQC
# read
CQC_care_homes<-deaths_ONS_all<-readxl::read_excel(CQC_care_home_data, sheet="HSCA Active Locations")
names(CQC_care_homes)
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

# mean(CQC_care_homes_older_people_only_nh$`Care homes beds`)
# mean(CQC_care_homes_older_people_only_res$`Care homes beds`)
# mean(CQC_care_homes_older_people_only_nh_res$`Care homes beds`)
# median(CQC_care_homes_older_people_only_nh$`Care homes beds`)
# median(CQC_care_homes_older_people_only_res$`Care homes beds`)
# median(CQC_care_homes_older_people_only_nh_res$`Care homes beds`)
# 
# 
# mean(CQC_care_homes_older_people_nh$`Care homes beds`)
# mean(CQC_care_homes_older_people_res$`Care homes beds`)
# mean(CQC_care_homes_older_people_nh_res$`Care homes beds`)

# p1<-ggplot(data=CQC_care_homes_older_people_only_nh, aes(x=`Care homes beds`))+
#   geom_histogram(bins=20)+theme_bw()+geom_vline(xintercept = 47)+xlab("Number of beds")+
#   scale_x_continuous(breaks = seq(0,max(CQC_care_homes_older_people_only_nh$`Care homes beds`), by=20))
# p2<-ggplot(data=CQC_care_homes_older_people_only_res, aes(x=`Care homes beds`))+
#   geom_histogram(bins=20)+theme_bw()+geom_vline(xintercept = 29)+xlab("Number of beds")+
# scale_x_continuous(breaks = seq(0,max(CQC_care_homes_older_people_only_res$`Care homes beds`), by=20))
# 
# plot_bed_size<-((p1+
#                 ggtitle("nursing care homes"))/
#                 (p2+
#                 ggtitle("residential care homes")))
# 
# ggsave(plot_bed_size, file="/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Plots/plot_bed_size.png", width = 10, height = 12, units = "cm")



## read in data Steph
# read
hospital_df<-read.csv(file=steph_file3)
# format date
hospital_df$Date<-as.Date(as.character(hospital_df$Date), format="%d/%m/%Y")
# remove those that got infected in  the  community
hospital_df<-hospital_df%>%filter(Community==FALSE)
# estimate mean proportion discharged in each category
# hospital_df<-hospital_df%>%mutate(all_discharges=select(.,GENERAL_EXPOSED:TEST_POS_NONE)%>%rowSums(),
#                                   noncovidH_discharges=select(.,GENERAL_EXPOSED:TEST_NEG_NONE)%>%rowSums(),
#                                   covidH_discharges=select(.,TEST_POS_EXPOSED:TEST_POS_NONE)%>%rowSums(),
#                                   noncovidH_Ic_discharges=select(.,c(GENERAL_INFECTED_S,SUSPECTED_INFECTED_S,TEST_NEG_INFECTED_S))%>%rowSums())
hospital_df$noncovidH_discharges_woIc<-hospital_df$mean.Exposed+hospital_df$mean.Infected_A+hospital_df$mean.Infected_P+hospital_df$mean.Recovered+hospital_df$mean.None
hospital_df$noncovidH_discharges_woIc_mean_p_E<-hospital_df$mean.Exposed/hospital_df$noncovidH_discharges_woIc
hospital_df$noncovidH_discharges_woIc_mean_p_Ic<-0
hospital_df$noncovidH_discharges_woIc_mean_p_Ipc<-hospital_df$mean.Infected_P/hospital_df$noncovidH_discharges_woIc
hospital_df$noncovidH_discharges_woIc_mean_p_Ia<-hospital_df$mean.Infected_A/hospital_df$noncovidH_discharges_woIc
hospital_df$noncovidH_discharges_woIc_mean_p_S<-hospital_df$mean.None/hospital_df$noncovidH_discharges_woIc
hospital_df$noncovidH_discharges_woIc_mean_p_R<-hospital_df$mean.Recovered/hospital_df$noncovidH_discharges_woIc


# plot
# ggplot(data=hospital_df, aes(x=Date, y=noncovidH_discharges_woIc_mean_p_E+noncovidH_discharges_woIc_mean_p_Ipc+noncovidH_discharges_woIc_mean_p_Ia))+
#   geom_point()

## read in data Nick
# read
data<-readRDS(nick_file)
data[, ] <- lapply(data[, ], as.character)
data[,c("S", "E", "Ip","Is", "Ia", "R")] <- lapply(data[,c("S", "E", "Ip","Is", "Ia", "R") ], as.numeric)
data$date<-as.Date(data$date)

## prep data Nick all ages
# group all ages
data_all_ages<-data%>%dplyr::group_by(run, date)%>%dplyr::summarise(S=sum(S),
                                                                    E=sum(E),
                                                                    Ip=sum(Ip),
                                                                    Is=sum(Is),
                                                                    Ia=sum(Ia),
                                                                    R=sum(R))
# data in long format
data_all_ages<-melt(data_all_ages, id.vars=c("run", "date"))
# check it all ads up
test<-data_all_ages%>%dplyr::group_by(run, date)%>%dplyr::summarise(total_pop=sum(value))
table(test$total_pop)
# change number into proportion
tpop<-test$total_pop[1]
data_all_ages$p<-data_all_ages$value/tpop
# add age group
data_all_ages$age_group<-"All"
# median
median_data_all_ages<-data_all_ages%>%dplyr::group_by(date, variable, age_group)%>%dplyr::summarise(median_p=median(p))
# plots
# ggplot(data=data_all_ages, aes(x=date, y=p, col=variable))+
#   geom_point()
# ggplot(data=median_data_all_ages, aes(x=date, y=median_p, col=variable))+
#   geom_point()

## prep data Nick o70
# select over 70s data Nick
data_o70<-data%>%filter(age_group=="over_70")
# data in long format
data_o70<-melt(data_o70, id.vars=c("run", "date", "age_group"))
# check it all ads up
test<-data_o70%>%dplyr::group_by(run,date)%>%dplyr::summarise(total_pop=sum(value))
table(test$total_pop)
# change number into proportion
tpop<-test$total_pop[1]
data_o70$p<-data_o70$value/tpop
# median
median_data_o70<-data_o70%>%dplyr::group_by(date, variable, age_group)%>%dplyr::summarise(median_p=median(p),
                                                                                          median_value=median(value))
# plots
# ggplot(data=data_o70, aes(x=date, y=p, col=variable))+
#   geom_point()
# ggplot(data=median_data_o70, aes(x=date, y=median_p, col=variable))+
#   geom_point()


### Analysis of proportion in entering each compartment from hospitalisations

## Nick data- how much higher is infection in over 70s than in overall pop?
df<-rbind(median_data_all_ages, median_data_o70)
df$age_group<-as.factor(as.character(df$age_group))
# plot
# ggplot(data=df, aes(x=date, y=median_p, col=variable, linetype=age_group))+
#   geom_line()
# ggplot(data=df%>%filter(variable=="E"|variable=="Ip"|variable=="Is"|variable=="Ia"), aes(x=date, y=median_p, col=variable, linetype=age_group))+
#   geom_line()  # appears to be lower than in the all ages pop.
# data for a few time points
median_data_o70%>%filter(date==date_origin_com_prev)
# plot forecast
df_mini<-df%>%filter(date<"2020-11-01" & date>"2020-05-01")
# ggplot(data=df_mini, aes(x=date, y=median_p, col=variable, linetype=age_group))+
#   geom_line()+theme_bw()
# ggplot(data=df_mini%>%filter(variable=="E"|variable=="Ip"|variable=="Is"|variable=="Ia"), aes(x=date, y=median_p, col=variable, linetype=age_group))+
#   geom_line()

## Steph
hospital_df_t1<-hospital_df%>%filter(Date==date_origin_hosp_prev)
# proportion exiting hospital looks too low, take this from Nick's model 
median_data_o70_S<-median_data_o70%>%filter(date==date_origin_hosp_prev)%>%filter(variable=="S")
median_data_o70_R<-median_data_o70%>%filter(date==date_origin_hosp_prev)%>%filter(variable=="R")
# median_data_o70_S$median_value/median_data_o70_R$median_value
p_S_vs_R<-median_data_o70_S$median_value/(median_data_o70_S$median_value+median_data_o70_R$median_value)
# proportion in each state
S_hospital_df_t1<-(hospital_df_t1$noncovidH_discharges_woIc_mean_p_S+hospital_df_t1$noncovidH_discharges_woIc_mean_p_R)*p_S_vs_R
E_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_E
Ipc_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ipc
Ic_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ic
Ia_hospital_df_t1<-hospital_df_t1$noncovidH_discharges_woIc_mean_p_Ia
R_hospital_df_t1<-(hospital_df_t1$noncovidH_discharges_woIc_mean_p_S+hospital_df_t1$noncovidH_discharges_woIc_mean_p_R)*(1-p_S_vs_R)
# E_hospital_df_t1+Ipc_hospital_df_t1+Ia_hospital_df_t1


## Community staff and visitor prevalence
# median of sums 
library(data.table)
data_all_ages<-as.data.table(data_all_ages)
data_all_ages_inf<-data_all_ages
data_all_ages_inf<-data_all_ages_inf%>%dplyr::group_by(run, date, variable)%>%dplyr::summarise(sum_value=sum(value),
                                                                                               sum_p=sum(p))
data_all_ages_inf_medians<-data_all_ages_inf%>%dplyr::group_by(date, variable)%>%dplyr::summarise(median_sum_value=median(sum_value),
                                                                                                  median_sum_p=median(sum_p))
# plot
# ggplot(data=data_all_ages_inf_medians%>%filter(variable=="Ip"|variable=="Is"|variable=="Ia"), aes(x=date, y=median_sum_p, col=variable))+
#   geom_point()
# ggplot(data=data_all_ages_inf_medians%>%filter(variable=="R"), aes(x=date, y=median_sum_p, col=variable))+
#   geom_point()

## identify peak
# data_all_ages_inf_medians_Ip<-data_all_ages_inf_medians%>%filter(variable=="Ip")
# data_all_ages_inf_medians_Ia<-data_all_ages_inf_medians%>%filter(variable=="Ia")
# data_all_ages_inf_medians_Is<-data_all_ages_inf_medians%>%filter(variable=="Is")
# data_all_ages_inf_medians_Ip%>%filter(median_sum_p==max(data_all_ages_inf_medians_Ip$median_sum_p))
# data_all_ages_inf_medians_Ia%>%filter(median_sum_p==max(data_all_ages_inf_medians_Ia$median_sum_p))
# data_all_ages_inf_medians_Is%>%filter(median_sum_p==max(data_all_ages_inf_medians_Is$median_sum_p))
# data_all_ages_inf_medians%>%group_by(date)%>%summarise(p_Infectious=(variable=="Is"+variable=="Ia"))


## Filter ffor the date_origin_com_prev
inf_states_t1<-data_all_ages_inf_medians%>%filter(date==date_origin_com_prev)

## Visitors infectious, assuming visitors don't come in symptomatic
v_inf_t1<-inf_states_t1%>%filter(variable=="Ip"|variable=="Ia")%>%dplyr::summarise(median_sum_p=sum(median_sum_p)) 

## Force of infection from the community (through staff)
c_inf_t1<-inf_states_t1%>%filter(variable=="Ip"|variable=="Is"|variable=="Ia")%>%dplyr::summarise(median_sum_p=sum(median_sum_p)) 

## Staff infectious upon start of model, or new staff coming in
staff_inf_t1<-inf_states_t1

# staff assumed not to enter or start Ic
n_compartments_receiving_staff<-5
staff_inf<-data_all_ages_inf_medians
extra<-staff_inf[staff_inf$variable=="Is","median_sum_p"]/n_compartments_receiving_staff
staff_inf<-staff_inf%>%filter(variable!="Is")
staff_inf$median_sum_p<-staff_inf$median_sum_p+extra[[1]]
# ggplot(data=staff_inf%>%filter(variable=="R"), aes(x=date, y=median_sum_p, col=variable))+
#   geom_point()
staff_inf_t1<-staff_inf%>%filter(date==date_origin_com_prev)

### Analysis hospitalised returning to the LTCF

# From He et al. Nature medicine paper viral load seems to decline +/- linearly with days since symptom onset until 0 at 14 days
# Therefore we assume a linear model starting at 1 with all infectious and 14 zero infectious:
# y = ax+c
# solving this for x=0, y=1; x=21, y=0 -> c=1, a=(-1/21) 
# therefore the equation for our line is y=-0.0476x+1, where x is the day from symptom onset, put this in function
infectious_hosp<-function(x){
  (-0.0476*x)+1
}
# Calculate area under the curve for full 21 days, and for 14 days 
x=c(0,21)
AUC_inf_21<-sintegral(x,infectious_hosp)$value
x=c(0,14)
AUC_inf_14<-sintegral(x,infectious_hosp)$value
(AUC_inf_21-AUC_inf_14)/AUC_inf_21 # 10% still shedding at day 14


### Analysis death rates within the LTCF for residents without COVID 

#variables to change
occupancy<-0.8
CFR<-0.25 # tried 0.17-0.34

## method 1
# read in death data ONS for all residents dying within care home all causes
readxl::excel_sheets(deaths_ONS_file)
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
sum(deaths_ONS_in_LTCFs_MayJune$N_deaths_woCOVID_ch)
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
# check
# (0.7*daily_deathrate_woCOVID_MayJune2020_res)+0.3*(daily_deathrate_woCOVID_MayJune2020_nh)


# ### Analysis kappa (hospitalisation rate for residents without COVID-19) method 1 [before we had new THF data]
# # pre-pandemic (2016/2017) data from THF report: 1.12 A&E attendances per year for residential CH and 0.85 for nusing CH; 0.77 emergency hospital admissions per year for residential CH and 0.63 for nursing CH. How has this changed? Using new THF data for admissions to hospital from care homes
# ## Read in data
# # weekly admissions to CH for week 17 2020 (latest week of THF new data) by res/nh and by covid/non-covid
# h_admissions_1<-read.csv(file = h_admissions_1_file)
# # average weekly admissions to CH for 2016/2017
# h_admissions_2<-read.csv(file = h_admissions_2_file)
# # weekly admissions to CH for week 9 to 17 2016 and 2020 by res/nh
# h_admissions_3<-read.csv(file = h_admissions_3_file)
# ## Nursing vs residential comparisons
# # residential vs nursing non-COVID week 17 2020
# h_admissions_1%>%filter((ch_nursing_adm==1|is.na(ch_nursing_adm))&covid_prim==0) #high proportion of unknowns so will have to use ratio
# h_admissions_1_noncovid<-h_admissions_1%>%filter(covid_prim==0)
# h_admissions_1_noncovid_nh<-h_admissions_1_noncovid%>%filter(ch_nursing_adm==1)
# h_admissions_1_noncovid_res<-h_admissions_1_noncovid%>%filter(ch_nursing_adm==0)
# h_admissions_1_noncovid_nh$ch_adm/h_admissions_1_noncovid_res$ch_adm # non-COVID hospitalisatinos nursing only 0.017% lower than residential 
# # residential vs nursing COVID week 17 2020
# h_admissions_1_covid<-h_admissions_1%>%filter(covid_prim==1)
# h_admissions_1_covid_nh<-h_admissions_1_covid%>%filter(ch_nursing_adm==1)
# h_admissions_1_covid_res<-h_admissions_1_covid%>%filter(ch_nursing_adm==0)
# h_admissions_1_covid_nh$ch_adm/h_admissions_1_covid_res$ch_adm # COVID hospitalisations 1.7 higher for nursing vs. residential.
# sum(h_admissions_1_covid$ch_adm)
# # residential vs nursing overall
# h_admissions_3$p_nh_res<-h_admissions_3$adm_nursing_home/h_admissions_3$adm_res_care_home 
# ggplot(data=h_admissions_3, aes(x=as.Date(date_start, format="%d/%m/%Y"), y=p_nh_res))+
#          geom_point()+theme_bw() # in 2016 residential were 13-19% higher than nh. In 2020 residential admissions were only higher until mid-march, week 12 nh 20% higher than residential, small decrease since.
# ## Comparison 2016/2017
# # average weekly admissions from res and nh LTCFs in 2016/2017
# average_2016_2017_weekly_adm_nh<-h_admissions_2$adm_all_care_homes/(1+(h_admissions_2$adm_res_care_home/h_admissions_2$adm_nursing_home))
# average_2016_2017_weekly_adm_res<-(h_admissions_2$adm_res_care_home/h_admissions_2$adm_nursing_home)*average_2016_2017_weekly_adm_nh
# #check
# average_2016_2017_weekly_adm_res+average_2016_2017_weekly_adm_nh
# # what would this imply about denominator of rate
# (average_2016_2017_weekly_adm_res/(0.77/365))/7
# (average_2016_2017_weekly_adm_nh/(0.63/365))/7
# (average_2016_2017_weekly_adm_res/(1.12/365))/7
# (average_2016_2017_weekly_adm_nh/(0.85/365))/7
# ## Weekly number non-COVID admissions week 17 2020 residential and nursing
# # total non-covid admissions
# n_noncovid_admissions_20042020_26042020<-sum(h_admissions_1_noncovid$ch_adm) 
# # non-covid admissions from res and nh
# weekly_noncovid_adm_20042020_26042020_res<-n_noncovid_admissions_20042020_26042020/(1+h_admissions_1_noncovid_nh$ch_adm/h_admissions_1_noncovid_res$ch_adm)
# weekly_noncovid_adm_20042020_26042020_nh<-weekly_noncovid_adm_20042020_26042020_res*(h_admissions_1_noncovid_nh$ch_adm/h_admissions_1_noncovid_res$ch_adm)
# # check
# weekly_noncovid_adm_20042020_26042020_res+weekly_noncovid_adm_20042020_26042020_nh
# 
# ## Rate adjustment emergency hospitalisations
# rate_adm_emergency_h_20042020_26042020_res<-(0.77/365)*(weekly_noncovid_adm_20042020_26042020_res/average_2016_2017_weekly_adm_res) #0.001
# rate_adm_emergency_h_20042020_26042020_nh<-(0.63/365)*(weekly_noncovid_adm_20042020_26042020_nh/average_2016_2017_weekly_adm_nh) #0.0007
# ## Rate adjustment A&E visits
# rate_AE_h_20042020_26042020_res<-(1.12/365)*(weekly_noncovid_adm_20042020_26042020_res/average_2016_2017_weekly_adm_res) # 0.001
# rate_AE_h_20042020_26042020_nh<-(0.85/365)*(weekly_noncovid_adm_20042020_26042020_nh/average_2016_2017_weekly_adm_nh) # 0.0009
# ## Check with rates using bed numbers
# rate_adm_20042020_26042020_res_2<-weekly_noncovid_adm_20042020_26042020_res/(n_residents_woCOVID_June2020*0.5*7)
# rate_adm_20042020_26042020_nh_2<-weekly_noncovid_adm_20042020_26042020_nh/(n_residents_woCOVID_June2020*0.5*7)
# 
# output_comparison_admissions<-data.frame(res=c(prepan_adm_emergency=0.77/365,
#                  prepan_AE=1.12/365,
#                  april_adm_emergency=rate_adm_emergency_h_20042020_26042020_res,
#                  april_AE=rate_AE_h_20042020_26042020_res,
#                  april_crude_0.5_0.5=rate_adm_20042020_26042020_res_2),
#            nh=c(prepan_adm_emergency=0.63/365,
#                 prepan_AE=0.85/365,
#                 april_adm_emergency=rate_adm_emergency_h_20042020_26042020_nh, 
#                 april_AE=rate_AE_h_20042020_26042020_nh, 
#                 april_crude_0.5_0.5=rate_adm_20042020_26042020_nh_2))
# 
# # write.csv(output_comparison_admissions, file="/Users/eoccaros/Documents/VEEPED/COVID-19/LTCF/Outputs/hospital_visits_comparison_calc.csv")


### Analysis kappa (hospitalisation rate for residents without COVID-19) with new THF data
# read in data
admissions_h<-read.csv(h_admissions_4_file)
# admissions total and COVID
admissions_h_nh<-admissions_h%>%mutate_all(as.character)%>%filter(type=="admissions" & cohort_year=="2020" & ch_nursing=="1")
admissions_h_res<-admissions_h%>%mutate_all(as.character)%>%filter(type=="admissions" & cohort_year=="2020" & ch_nursing=="0")
admissions_h_nh_COVID<-admissions_h%>%mutate_all(as.character)%>%filter(type=="covid" & cohort_year=="2020" & ch_nursing=="1")
admissions_h_res_COVID<-admissions_h%>%mutate_all(as.character)%>%filter(type=="covid" & cohort_year=="2020" & ch_nursing=="0")
# rate of hospitalisation for week starting date_origin_hosp_rate
rate_h_nh<-(as.numeric(as.character(admissions_h_nh%>%filter(weekstart==date_origin_hosp_rate)%>%select(count)))-as.numeric(as.character(admissions_h_nh_COVID%>%filter(weekstart==date_origin_hosp_rate)%>%select(count))))/as.numeric(as.character(admissions_h_nh%>%filter(weekstart==date_origin_hosp_rate)%>%select(days_ch)))
rate_h_res<-(as.numeric(as.character(admissions_h_res%>%filter(weekstart==date_origin_hosp_rate)%>%select(count)))-as.numeric(as.character(admissions_h_res_COVID%>%filter(weekstart==date_origin_hosp_rate)%>%select(count))))/as.numeric(as.character(admissions_h_res%>%filter(weekstart==date_origin_hosp_rate)%>%select(days_ch)))
# most recent data for week starting 15/06/2020 (pers comm Fiona Grimm 23 October 2020  E-mail) rate in NH is 0.49/365 and rate in  RES is 0.5/365
# rate_h_nh<-signif(rate_h_nh,1)
# rate_h_res<-signif(rate_h_res,1)

### Analysis kappa c
# ## method 1
# # total covid admissions
# admissions_h_covid_25052020_31052020<-admissions_h%>%mutate_all(as.character)%>%filter(type=="covid" & cohort_year=="2020" & weekstart=="25/05/2020")
# n_admissions_h_covid_25052020_31052020<-sum(as.numeric(admissions_h_covid_25052020_31052020$count)) 
# # covid admissions from res and nh
# n_admissions_h_covid_25052020_31052020_res<-as.numeric(admissions_h_covid_25052020_31052020%>%filter(ch_nursing==0)%>%select(count))
# n_admissions_h_covid_25052020_31052020_nh<-as.numeric(admissions_h_covid_25052020_31052020%>%filter(ch_nursing==1)%>%select(count))
# # check
# n_admissions_h_covid_25052020_31052020_res+n_admissions_h_covid_25052020_31052020_nh
# # number of residents with COVID 04062020_28062020 (delay to death ~10 days)
# deaths_ONS_COVID_04062020_10062020<-deaths_ONS_COVID%>%filter(Date<"2020-06-11" & Date> "2020-06-03")
# n_deaths_ONS_COVID_04062020_10062020<-sum(deaths_ONS_COVID_04062020_10062020$N_deaths_COVID_ch)+sum(deaths_ONS_COVID_04062020_10062020$N_deaths_COVID_h)+sum(deaths_ONS_COVID_04062020_10062020$N_deaths_COVID_other)
# n_residents_wCOVID_25052020_31052020<-n_deaths_ONS_COVID_04062020_10062020/CFR 
# # proportion of residents with COVID hospitalised
# p_COVID_hosp<-n_admissions_h_covid_25052020_31052020/n_residents_wCOVID_25052020_31052020
## method 2
# proportion of primary diagnosis on admission COVID who die in hospital 
COVID_outcomes<-read.csv(COVID_outcomes_file) #Has decreased,now down to ~30%
COVID_outcomes_MayJune<-slice_tail(COVID_outcomes, n=4)
mean(COVID_outcomes_MayJune$pct_died)

# proportion of deaths from COVID in ch residents occur in LTCFs vs hospital?
deaths_ONS_COVID_MayJune<-slice_tail(deaths_ONS_COVID, n=30)
sum(deaths_ONS_COVID_MayJune$N_deaths_COVID_ch)/(sum(deaths_ONS_COVID_MayJune$N_deaths_COVID_ch)+sum(deaths_ONS_COVID_MayJune$N_deaths_COVID_h))
#if probability of COVID resident surviving hospitalisation is 70%



#  Analysis of uncertainties

# function for calculating beta parameters from mean and standard error
BetaParams <- function(mu,se) {
  alpha <- ((1 - mu) / se^2 - 1 / mu) * mu ^ 2
  beta <- alpha*(1/mu - 1)
  return(params = list(alpha = alpha, beta = beta))
}

# d_pc_inf
# a<-rgamma(1000,shape=4,scale=(2.5)/4)

# d_pc_inf_i
# a<-rgamma(1000,shape=4,scale=(2.5-2)/4)

# delta
# a<-rnorm(1000,0.001,0.0002)
# a<-rnorm(1000,0.0005,0.0002)
# a<-rgamma(1000,shape=12,scale=0.001/12) #Shah et al. 0.308/365 NH, 0.223/365 RES without COVID
# a<-rgamma(1000,shape=12,scale=0.0005/12) #Shah et al. 0.308/365 NH, 0.223/365 RES without COVID

#kappa
# a<-rnorm(1000,0.001342466, 0.0003)
# a<-rgamma(1000,shape=10, scale=0.001342466/10)

# n_V
# a<-rnorm(1000, 0.24, 0.1)
# a<-rgamma(1000, shape=12, scale=0.24/12)
# BetaParams(mu = 0.24,se = 0.1)
# a<-rbeta(1000,shape1 = 4.1376, shape2 = 13.1024)
# a<-rbeta(1000,(((1 - 0.24) / 0.1^2 - 1 / 0.24) * 0.24 ^ 2), ((((1 - 0.24) / 0.1^2 - 1 / 0.24) * 0.24 ^ 2)*(1/0.24 - 1)))

# latency
# a<-rgamma(n = 10000,shape = 4,scale = 2.5/4)

# delay isolation
# a<-rgamma(1000,shape=4,scale=2/4)

# delay isolation if symptomatic
# a<-rgamma(1000,shape=4,scale=1/4)

# p_a
# a<-rnorm(1000,0.4,0.05)
# a<-rgamma(1000,shape=7, scale=0.4/7)
# a<-rbeta(1000,(((1 - 0.4) / 0.07^2 - 1 / 0.4) * 0.4 ^ 2), ((((1 - 0.4) / 0.07^2 - 1 / 0.4) * 0.4 ^ 2)*(1/0.4 - 1)))
# a<-rbeta(1000,(((1 - 0.4) / 0.07^2 - 1 / 0.4) * 0.4 ^ 2), 45)
# a<-rbeta(1000,(((1 - 0.4) / 0.05^2 - 1 / 0.4) * 0.4 ^ 2), ((((1 - 0.4) / 0.05^2 - 1 / 0.4) * 0.4 ^ 2)*(1/0.4 - 1)))
# a<-rbeta(1000,(((1 - 0.4) / 0.1^2 - 1 / 0.4) * 0.4 ^ 2), ((((1 - 0.4) / 0.1^2 - 1 / 0.4) * 0.4 ^ 2)*(1/0.4 - 1)))

# p_as
# a<-rnorm(1000,0.5,0.05)
# a<-rbeta(1000,(((1 - 0.5) / 0.07^2 - 1 / 0.5) * 0.5 ^ 2), ((((1 - 0.5) / 0.07^2 - 1 / 0.5) * 0.5 ^ 2)*(1/0.5 - 1)))
# a<-rbeta(1000,(((1 - 0.5) / 0.05^2 - 1 / 0.5) * 0.5 ^ 2), ((((1 - 0.5) / 0.05^2 - 1 / 0.5) * 0.5 ^ 2)*(1/0.5 - 1)))

# proportion_transmission_pre_c_vs_c_value
# proportion_transmission_pre_c_vs_c
# a<-rnorm(1000,0.4,0.05)
# a<-rbeta(1000,(((1 - 0.4) / 0.05^2 - 1 / 0.4) * 0.4 ^ 2), ((((1 - 0.4) / 0.05^2 - 1 / 0.4) * 0.4 ^ 2)*(1/0.4 - 1)))

#  proportion_transmission_cl_vs_ch_value
# proportion_transmission_cl_vs_ch
# a<-rnorm(1000,1/3,0.05)
# a<-rbeta(1000,(((1 - (1/3)) / 0.05^2 - 1 / (1/3)) * (1/3) ^ 2), ((((1 - (1/3)) / 0.05^2 - 1 / (1/3)) * (1/3) ^ 2)*(1/(1/3) - 1)))

# R0_LTCF_a_value
# R0_LTCF_a
# a<-rnorm(1000,2,0.1)
# a<-rgamma(1000,shape=8,scale=2/8)

# m_R0_LTCF_b_vs_a_value
# m_R0_LTCF_b_vs_a
# a<-rgamma(1000,shape=4,scale=0.5/4)
# a<-rbeta(1000,(((1 - 0.5) / 0.1^2 - 1 / 0.5) * 0.5 ^ 2), ((((1 - 0.5) / 0.1^2 - 1 / 0.5) * 0.5 ^ 2)*(1/0.5 - 1)))

# R0_community_value
# R0_community
# a<-rgamma(1000,shape=16,scale=1.4/16)

#c_prev_value
# c_prev
# b<-data_all_ages_inf%>%filter(date==date_origin_com_prev)%>%filter(variable!="S")%>%filter(variable!="E")%>%filter(variable!="R")%>%
#   group_by(run)%>%summarise(p_inf=sum(sum_p))
# median(b$p_inf)
# quantile(b$p_inf, c(0,0.05,0.1,0.25, 0.5, 0.75, 0.9,0.95,1))
# hist(b$p_inf)
# a<-rgamma(1000,shape=20,scale=0.003250851/20)

#p_LTCF2_outbreak_value
# p_LTCF2_outbreak
# a<-rbeta(1000,(((1 - 0.05) / 0.02^2 - 1 / 0.05) * 0.05 ^ 2), ((((1 - 0.05) / 0.02^2 - 1 / 0.05) * 0.05 ^ 2)*(1/0.05 - 1)))

#p_LTCF2_outbreak_inf
# p_LTCF2_outbreak_inf
# a<-rbeta(1000,(((1 - 0.1) / 0.05^2 - 1 / 0.1) * 0.1 ^ 2), ((((1 - 0.1) / 0.05^2 - 1 / 0.1) * 0.1 ^ 2)*(1/0.1 - 1)))

# n_days_absent_value;
# n_days_absent
# a<-rgamma(1000,shape=40,scale=14/40)

# p_working_another_LTCF_value
# p_working_another_LTCF
# a<-rbeta(1000,(((1 - 0.01) / 0.005^2 - 1 / 0.01) * 0.01 ^ 2), ((((1 - 0.01) / 0.005^2 - 1 / 0.01) * 0.01 ^ 2)*(1/0.01 - 1)))

# m_beta2_value
# m_beta2
# a<-rgamma(1000,shape=15,scale=0.5/15)

# p_survival_value
# p_survival
# a<-rbeta(1000,(((1 - 0.7) / 0.1^2 - 1 / 0.7) * 0.7 ^ 2), ((((1 - 0.7) / 0.1^2 - 1 / 0.7) * 0.7 ^ 2)*(1/0.7 - 1)))

#m_i_value
# m_i
# a<-rbeta(1000,(((1 - 0.25) / 0.15^2 - 1 / 0.25) * 0.25 ^ 2), ((((1 - 0.25) / 0.15^2 - 1 / 0.25) * 0.25 ^ 2)*(1/0.25 - 1)))

# m_v_value
# m_v
# a<-rnorm(1000,1,0.2)

# p_v_infectious_value
# theta["p_v_infectious"]
# a<-rgamma(1000,shape=20,scale=0.00240798/20)

# p_tnc_value
# theta["p_tnc"]
# a<-rbeta(1000,(((1 - 0.9) / 0.05^2 - 1 / 0.9) * 0.9 ^ 2), ((((1 - 0.9) / 0.05^2 - 1 / 0.9) * 0.9 ^ 2)*(1/0.9 - 1)))

# p_fn_value
# theta["p_fn"]
# a<-rbeta(1000,(((1 - 0.2) / 0.05^2 - 1 / 0.2) * 0.2 ^ 2), ((((1 - 0.2) / 0.05^2 - 1 / 0.2) * 0.2 ^ 2)*(1/0.2 - 1)))

# p_fn_h_value
# theta["p_fn_h"]
# a<-rbeta(1000,(((1 - 0.1) / 0.01^2 - 1 / 0.1) * 0.1 ^ 2), ((((1 - 0.1) / 0.01^2 - 1 / 0.1) * 0.1 ^ 2)*(1/0.1 - 1)))

# p_i_value
# theta["p_i"]
# a<-rbeta(1000,(((1 - 0.8) / 0.08^2 - 1 / 0.8) * 0.8 ^ 2), ((((1 - 0.8) / 0.08^2 - 1 / 0.8) * 0.8 ^ 2)*(1/0.8 - 1)))

# CFR_value
# CFR
# a<-rbeta(1000,(((1 - 0.25) / 0.08^2 - 1 / 0.25) * 0.25 ^ 2), ((((1 - 0.25) / 0.08^2 - 1 / 0.25) * 0.25 ^ 2)*(1/0.25 - 1)))

# p_deaths_in_LTCF_vs_H_value;
# p_deaths_in_LTCF_vs_H
# a<-rbeta(1000,(((1 - 0.8) / 0.05^2 - 1 / 0.8) * 0.8 ^ 2), ((((1 - 0.8) / 0.05^2 - 1 / 0.8) * 0.8 ^ 2)*(1/0.8 - 1)))

# m_delta_c_res_value
# m_delta_c_res
# a<-rbeta(1000,(((1 - 0.47) / 0.15^2 - 1 / 0.47) * 0.47 ^ 2), ((((1 - 0.47) / 0.15^2 - 1 / 0.47) * 0.47 ^ 2)*(1/0.47 - 1)))

# p_replaced_value
# theta["p_replaced"]
# a<-rbeta(1000,(((1 - 0.8) / 0.05^2 - 1 / 0.8) * 0.8 ^ 2), ((((1 - 0.8) / 0.05^2 - 1 / 0.8) * 0.8 ^ 2)*(1/0.8 - 1)))

# p_R_hosp_value
# theta["p_R_hosp"]
# R_hospital_df_t1
# hospital_df_t1$noncovidH_discharges_woIc_mean_p_R
# a<-rbeta(1000,(((1 - 0.05811564) / 0.03^2 - 1 / 0.05811564) * 0.05811564 ^ 2), ((((1 - 0.05811564) / 0.03^2 - 1 / 0.05811564) * 0.05811564 ^ 2)*(1/0.05811564 - 1)))

# p_EIpcIa_hosp_value
# theta["p_EIpcIa_hosp"]
# a<-rbeta(1000,(((1 - 0.007) / 0.001^2 - 1 / 0.007) * 0.007 ^ 2), ((((1 - 0.007) / 0.001^2 - 1 / 0.007) * 0.007 ^ 2)*(1/0.007 - 1)))

# p_shedding_after_H_value
# theta["p_shedding_after_H"]
# a<-rbeta(1000,(((1 - 0.06) / 0.02^2 - 1 / 0.06) * 0.06 ^ 2), ((((1 - 0.06) / 0.02^2 - 1 / 0.06) * 0.06 ^ 2)*(1/0.06 - 1)))

# p_R_s2_value
# theta["p_R_s2"]
# a<-rbeta(1000,(((1 - 0.1276) / 0.03^2 - 1 / 0.1276) * 0.1276 ^ 2), ((((1 - 0.1276) / 0.03^2 - 1 / 0.1276) * 0.1276 ^ 2)*(1/0.1276 - 1)))
# 
#checks
# hist(a)
# quantile(a, c(0,0.05,0.1,0.25, 0.5, 0.75, 0.9,0.95,1))

