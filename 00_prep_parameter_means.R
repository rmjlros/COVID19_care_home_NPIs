# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to define parameter means and fixed parameter values



## PARAMETER MEANS

# death rate in the LTCF non-clinical residents pppd
delta_mean=if(scenario_LTCF=="nh" & scenario_deaths=="Y"){round(daily_deathrate_woCOVID_MayJune2020_nh,3)}else if(scenario_LTCF=="res" & scenario_deaths=="Y"){round(daily_deathrate_woCOVID_MayJune2020_res,4)}else if(scenario_deaths=="N"){0} 

# hospitalisation rate for non-clinical residents pppd
kappa_mean=if(scenario_LTCF=="nh"){
  rate_h_nh*m_kappa
}else if(scenario_LTCF=="res"){
  rate_h_res*m_kappa} 

# number of visitors per resident in LTCF on any one day 
n_V_mean=if(scenario_v=="N"){0}else if(scenario_v=="prep"){(0.1*1)+(0.4*(2/7))+(0.4*(1/14))}else if(scenario_v=="weekly"){1/7} 

# duration of latency
d_latency_mean=2.5 

# duration of preclinical infectiousness
d_pc_inf_mean=2.5 

# duration of clinical infectiousness
d_c_inf_mean=5 

# proportion of infected residents that never present with COVID-19  symptoms
p_a_mean=0.4 

# proportion of infected staff that never present with COVID-19  symptoms
p_as_mean=0.5

# proportion of transmission that occurs prior to symptom onset (whilst pre-clinical) vs during the symptomatic phase (clinical) in pathway a
proportion_transmission_pre_c_vs_c_mean=0.4

# proportion of transmission that occurs whilst symptomatic with low infectiousness (late stage of infection) vs whilst symptomatic wit high infectiousness (early stage of infection) for staff and residents in pathway a
proportion_transmission_cl_vs_ch_mean=1/3

# R0 from staff and  residents  within  the  LTCF in pathway a (eventually develop symptoms)
R0_LTCF_a_mean=if(scenario_beta=="baseline"){2}else if (scenario_beta=="change_R0"){changed_R0_a}

# modifyer of R0 from staff and  residents  within  the  LTCF in pathway b (never develop symptoms) vs. pathway a (if 0.5 pathway b half as infectious as a)
m_R0_LTCF_b_vs_a_mean=if(scenario_beta=="baseline"){0.5}else if (scenario_beta=="change_R0"){changed_mR0_b}

# R0 in the community
R0_community_mean=if(scenario_h_imp=="only"){0}else if(scenario_h_imp!="only"){changed_R0_community_mean}

# community prevalence
c_prev_mean=c_inf_t1$median_sum_p

# duration of infectiousness in the community
d_total_inf_community_mean=5

# probability a LTCF has an outbreak
p_LTCF2_outbreak_mean=changed_p_LTCF2_outbreak_mean

# probability that in a LTCF with an outbreak a resident or staff is infectious
p_LTCF2_outbreak_inf_mean=0.1

# number of days that staff are absent for
n_days_absent_mean=14

# probability staff work at another LTCF
p_working_another_LTCF_mean=if(scenario_h_imp=="only"){0}else if(scenario_h_imp!="only" & scenario_staff_other_LTCF=="baseline"){0.01}else if(scenario_h_imp!="only" & scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF} 

# probability replacement staff work at another LTCF
p_working_another_LTCF2_mean=if(scenario_h_imp=="only"){0}else if(scenario_h_imp!="only"){0.2}

# how much do transmission rates adjusted by after 1st case isolated/absent
m_beta2_mean=if(scenario_beta2=="baseline"){0.5}else if(scenario_beta2=="change_beta2"){changed_m_beta2} 

# probability clinical residents return to the LTCF from hospital having survived COVID-19. 
p_survival_mean=COVID_outcomes_MayJune

# delay from start of state to isolation
delay_to_isolation_nc_mean=if(scenario_delay_isolation=="baseline"){2}else if(scenario_delay_isolation=="change"){
  changed_delay_isolation
}

# delay from start of state to isolation
delay_to_isolation_c_mean=if(scenario_delay_isolation=="baseline"){1}else if(scenario_delay_isolation=="change"){
  changed_delay_isolation_c
} 

# relative infectiousness of clinical residents being isolated (Ici) vs Ic
m_i_mean=if(scenario_m_i=="baseline"){0.25}else if(scenario_m_i=="change_m_i"){changed_m_i} 

# relative infectiousness of visitors vs Ia
m_v_mean=1 #same as beta_a

# probability of visitors being infectious
p_v_infectious_mean=v_inf_t1$median_sum_p 

# probability of being tested if not symptomatic with COVID-19
p_tnc_mean=if(scenario_p_tnc=="change_p_tnc"){changed_p_tnc}else if(scenario_p_tnc=="baseline"){0.85}

# probability of being tested if symptomatic with COVID-19
p_tc_mean=if(scenario_p_tc=="change_p_tc"){changed_p_tc}else if(scenario_p_tc=="baseline"){0.9}

# probability of STAFF being tested if not symptomatic with COVID-19
p_tncs_mean=if(scenario_p_tncs=="change_p_tncs"){changed_p_tncs}else if(scenario_p_tncs=="baseline"){0.95}

# probability of having a false-negative test in care home
p_fn_mean=if(scenario_p_fn=="baseline"){0.2}else if (scenario_p_fn=="change_p_fn"){changed_p_fn} 

# probability of having a false-negative test in hospital
p_fn_h_mean=if(scenario_p_fn=="baseline"){0.1}else if (scenario_p_fn=="change_p_fn"){changed_p_fn_h}

# probability of clinical residents being isolated
p_i_mean=if(scenario_isolation=="Y" & scenario_p_i=="baseline"){0.8}else if(scenario_isolation=="Y" & scenario_p_i=="change_p_i"){changed_p_i}else if(scenario_isolation=="N"){0}

# case fatality ratio in residents
CFR_mean=if(scenario_deaths=="Y"){0.25}else if (scenario_deaths=="N"){0} 

# deaths in  hospital
p_deaths_in_LTCF_vs_H_mean=0.8 #80% died in LTCFs vs. 20% in hospital

# deaths in res vs nh
m_delta_c_res_mean=if(scenario_LTCF=="nh"){1}else if(scenario_LTCF=="res"){(((1/544.5)*0.5)/((1/283)*0.55))} 

# probability of staff absent being replaced
p_replaced_mean=0.8

# proportion all entries from hospital into R
p_R_hosp_mean=as.numeric(as.character(R_hospital_df_t1))

# proportion all entries from hospital into E, Ipc, Ia (infectious entries)
p_EIpcIa_hosp_mean=if(scenario_h_inf_imp=="Y"){as.numeric(as.character(E_hospital_df_t1+Ipc_hospital_df_t1+Ia_hospital_df_t1))}else if(scenario_h_inf_imp=="N"){
  0} 

# proportion still shedding after COVID-19 hospitalisation
p_shedding_after_H_mean=if(scenario_COVID_returns=="all_I"){0.06}else if(scenario_COVID_returns=="baseline"|scenario_COVID_returns=="all_R"){0} 

# proportion of replacement staff entering R
p_R_s2_mean=staff_inf_t1[staff_inf_t1$variable=="R","median_sum_p"][[1]]

# proportion all replacement staff entering E, Ipc, Ia (infectious)
p_EIpcIa_s2_mean=staff_inf_t1[staff_inf_t1$variable=="E","median_sum_p"][[1]]+
  staff_inf_t1[staff_inf_t1$variable=="Ip","median_sum_p"][[1]]+
  staff_inf_t1[staff_inf_t1$variable=="Ia","median_sum_p"][[1]] # from Nick's model



## FIXED PARAMETERS 
 
# reporting, not used if not fitting
rho=0.5

# switch on imports from hospitals (1) or off (0)
switch_h_imp=if(scenario_h_imp=="N"){0}else if(scenario_h_imp!="N"){1}

# switch on new staff coming in
switch_new_staff=if(scenario_replacement_staff=="Y"){1}else if(scenario_replacement_staff=="N"){0}

# relative infectiousness of pre-clinical staff to residents compared to pre-clinical residents to residents
msr_pc=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_msr
}

# relative infectiousness of Ich staff to residents compared to Ich residents to residents
msr_h=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_msr
}

# relative infectiousness of asymptomatic staff to residents compared to asymptomatic residents to residents
msr_a=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_msr
}

# relative infectiousness of pre-clinical staff to staff compared to pre-clinical residents to residents
mss_pc=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_mss
}

# relative infectiousness of Ich staff to staff compared to Ich residents to residents
mss_h=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_mss
}

# relative infectiousness of asymptomatic staff to staff compared to asymptomatic residents to residents
mss_a=if(scenario_beta3=="baseline"){
  1
}else if (scenario_beta3=="change_beta3"){
  changed_mss
}

# relative infectiousness of pre-clinical residents to staff compared to pre-clinical residents to residents
mrs_pc=if(scenario_h_imp=="only"){
  0
}else if(scenario_h_imp!="only" & scenario_beta3=="baseline"){
  1
}else if(scenario_h_imp!="only" & scenario_beta3=="change_beta3"){
  changed_mrs
}

# relative infectiousness of Ich residents to staff compared to Ich residents to residents
mrs_h=if(scenario_h_imp=="only"){
  0
}else if(scenario_h_imp!="only" & scenario_beta3=="baseline"){
  1
}else if(scenario_h_imp!="only" & scenario_beta3=="change_beta3"){
  changed_mrs
}

# relative infectiousness of Icl residents to staff compared to Icl residents to residents
mrs_l=if(scenario_h_imp=="only"){
  0
}else if(scenario_h_imp!="only" & scenario_beta3=="baseline"){
  1
}else if(scenario_h_imp!="only" & scenario_beta3=="change_beta3"){
  changed_mrs
}

# relative infectiousness of asymptomatic residents to staff compared to asymptomatic residents to residents
mrs_a=if(scenario_h_imp=="only"){
  0
}else if(scenario_h_imp!="only" & scenario_beta3=="baseline"){
  1
}else if(scenario_h_imp!="only" & scenario_beta3=="change_beta3"){
  changed_mrs
}

# periodic testing non-clinical residents
tnc_period=if(scenario_f_tnc=="change_f_tnc"){changed_f_tnc}else if(scenario_f_tnc=="baseline"){28}

# periodic testing clinical residents
tc_period=if(scenario_f_tc=="change_f_tc"){changed_f_tc}else if(scenario_f_tc=="baseline"){0}

# periodic testing non-clinical staff
tncs_period=if(scenario_f_tncs=="change_f_tncs"){changed_f_tncs}else if(scenario_f_tncs=="baseline"){7}


# proportion infectious entries from hospital into E,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_E_if_inf_hosp=if(p_EIpcIa_hosp_mean!=0){
  E_hospital_df_t1/p_EIpcIa_hosp_mean
}else if(p_EIpcIa_hosp_mean==0){0} # from Steph's model

# proportion infectious entries from hospital into Ipc,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_Ipc_if_inf_hosp=if(p_EIpcIa_hosp_mean!=0){
  Ipc_hospital_df_t1/p_EIpcIa_hosp_mean
}else if(p_EIpcIa_hosp_mean==0){0} # from Steph's model

# proportion infectious entries from hospital into Ia,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_Ia_if_inf_hosp=if(p_EIpcIa_hosp_mean!=0){
  Ia_hospital_df_t1/p_EIpcIa_hosp_mean
}else if(p_EIpcIa_hosp_mean==0){0} # from Steph's model

# proportion infectious entries from replacement staff into E,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_E_if_inf_s2=if(p_EIpcIa_s2_mean!=0){
  staff_inf_t1[staff_inf_t1$variable=="E","median_sum_p"][[1]]/p_EIpcIa_s2_mean
}else if(p_EIpcIa_s2_mean==0){0}

# proportion infectious entries from replacement staff into Ipc,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_Ipc_if_inf_s2=if(p_EIpcIa_s2_mean!=0){
  staff_inf_t1[staff_inf_t1$variable=="Ip","median_sum_p"][[1]]/p_EIpcIa_s2_mean
}else if(p_EIpcIa_s2_mean==0){0}

# proportion infectious entries from replacement staff into Ia,THIS SHOULD STAY FIXED SO PROBABILITIES ADD UP TO 1
p_Ia_if_inf_s2=if(p_EIpcIa_s2_mean!=0){
  staff_inf_t1[staff_inf_t1$variable=="Ia","median_sum_p"][[1]]/p_EIpcIa_s2_mean
}else if(p_EIpcIa_s2_mean==0){0}

# switches for testing after hospitalisation vs not
switch_h_testing=if(scenario_tested_after_H=="N"){0}else if(scenario_tested_after_H=="Y"){1}

# switches for all isolated after COVID-19 hospitalisation if still shedding vs not
switch_all_COVID_returns=if(scenario_COVID_returns=="all_R"){2}else if(scenario_COVID_returns=="all_I"){1}else if(scenario_COVID_returns=="baseline"){0}



## N RESIDENTS IN EACH COMPARTMENT AT SIIMULATION START
# scenario of nursing vs residential
if(scenario_LTCF=="nh" & scenario_LTCF_size=="baseline"){
  N_residents<-median(CQC_care_homes_older_people_only_nh$`Care homes beds`)
}else if(scenario_LTCF=="nh" & scenario_LTCF_size=="small"){
  N_residents<-round(quantile(CQC_care_homes_older_people_only_nh$`Care homes beds`, p=0.05)[[1]])
}else if(scenario_LTCF=="nh" & scenario_LTCF_size=="large"){
  N_residents<-round(quantile(CQC_care_homes_older_people_only_nh$`Care homes beds`, p=0.95)[[1]])
}else if(scenario_LTCF=="res" & scenario_LTCF_size=="baseline"){
  N_residents<-median(CQC_care_homes_older_people_only_res$`Care homes beds`)
}else if(scenario_LTCF=="res" & scenario_LTCF_size=="small"){
  N_residents<-round(quantile(CQC_care_homes_older_people_only_res$`Care homes beds`, p=0.05)[[1]])
}else if(scenario_LTCF=="res" & scenario_LTCF_size=="large"){
  N_residents<-round(quantile(CQC_care_homes_older_people_only_res$`Care homes beds`, p=0.95)[[1]])
}
# number of residents susceptible exposed and recovered
N_S<-N_residents
N_E<-0
N_R<-0
# scenario of previous outbreak
if (scenario_previous_outbreak=="Y"){
  N_S<-round(N_residents*0.5)
  N_R<-round(N_residents*0.5)
}
if(N_S+N_R!=N_residents){
  N_S<-N_S+(N_residents-(N_S+N_R)) # in case numbers don't add up
}
# scenario where 1 person exposed vs 0 exposed in the LTCF at start sim
if(scenario_exp=="1"){
  N_S<-N_residents-1
  N_E<-1
}


## N STAFF IN EACH COMPARTMENT AT SIIMULATION START
# N nursing vs residential staff
if(scenario_LTCF=="nh"){
  N_staff<-N_residents*2
}else if(scenario_LTCF=="res"){
  N_staff<-N_residents
}
# p of being susceptible or recovered
if(scenario_previous_outbreak=="N"){
  p_N_Ss<-staff_inf_t1[staff_inf_t1$variable=="S","median_sum_p"][[1]]
}else if (scenario_previous_outbreak=="Y"){
  p_N_Ss<-0.5
}
if(scenario_previous_outbreak=="N"){
  p_N_Rs<-staff_inf_t1[staff_inf_t1$variable=="R","median_sum_p"][[1]]
}else if (scenario_previous_outbreak=="Y"){
  p_N_Rs<-0.5
}
# N susceptible or recovered
N_Ss<-round(N_staff*p_N_Ss)
N_Rs<-round(N_staff*p_N_Rs)
if(N_Ss+N_Rs!=N_staff){
  if(p_N_Ss>p_N_Rs){
    N_Ss<-N_Ss+(N_staff-(N_Ss+N_Rs))
  }
  else if(p_N_Ss<=p_N_Rs){
    N_Rs<-N_Rs+(N_staff-N_Ss-N_Rs)
  }
}



## FIXED PARAMETERS SENSITIVITY ANALYSIS 

# LL
rho_ll=NA
switch_h_imp_ll=NA
switch_new_staff_ll=NA
msr_pc_ll=0.5
msr_h_ll=0.5
msr_a_ll=0.5
mss_pc_ll=0.5
mss_h_ll=0.5
mss_a_ll=0.5
mrs_pc_ll=0.5
mrs_h_ll=0.5
mrs_l_ll=0.5
mrs_a_ll=0.5
tnc_period_ll=1
tc_period_ll=1
tncs_period_ll=1
p_E_if_inf_hosp_ll=NA
p_Ipc_if_inf_hosp_ll=NA
p_Ia_if_inf_hosp_ll=NA
p_E_if_inf_s2_ll=NA
p_Ipc_if_inf_s2_ll=NA
p_Ia_if_inf_s2_ll=NA
switch_h_testing_ll=NA
switch_all_COVID_returns_ll=NA
N_S_ll=NA
N_E_ll=NA
N_R_ll=NA
N_Ss_ll=NA
N_Rs_ll=NA

# UL
rho_ul=NA
switch_h_imp_ul=NA
switch_new_staff_ul=NA
msr_pc_ul=2
msr_h_ul=2
msr_a_ul=2
mss_pc_ul=2
mss_h_ul=2
mss_a_ul=2
mrs_pc_ul=2
mrs_h_ul=2
mrs_l_ul=2
mrs_a_ul=2
tnc_period_ul=28
tc_period_ul=28
tncs_period_ul=28
p_E_if_inf_hosp_ul=NA
p_Ipc_if_inf_hosp_ul=NA
p_Ia_if_inf_hosp_ul=NA
p_E_if_inf_s2_ul=NA
p_Ipc_if_inf_s2_ul=NA
p_Ia_if_inf_s2_ul=NA
switch_h_testing_ul=NA
switch_all_COVID_returns_ul=NA
N_S_ul=NA
N_E_ul=NA
N_R_ul=NA
N_Ss_ul=NA
N_Rs_ul=NA