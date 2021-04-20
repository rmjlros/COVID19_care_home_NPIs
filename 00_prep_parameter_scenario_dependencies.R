# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to set out parameters of the selected scenario according to their dependencies


if(scenario_community_prev=="prevl"){
  date_origin_com_prev<-"2020-07-15" # prev of 0.0005 infectious
  date_origin_hosp_rate<-"15/06/2020" # data kappa for week starting 15/06
  m_kappa<-1.08 # source NHSE data for July vs June emergency admissions England overall population
  changed_R0_community_mean<-0.8 
  changed_p_LTCF2_outbreak_mean<-0.1
  date_origin_hosp_prev<-"2020-07-15" # prev of 0.0028 infectious, 0.004 exposed
} 
if(scenario_community_prev=="prevm"){
  date_origin_com_prev<-"2020-09-30" # prev of 0.00325 infectious
  date_origin_hosp_rate<-"15/06/2020" # data kappa for week starting 15/06
  m_kappa<-1.1 # source NHSE data for October vs June emergency admissions England overall population (also equivalent to the hospitalisation rate in early May for care home residents from SUS data)
  changed_R0_community_mean<-1 
  changed_p_LTCF2_outbreak_mean<-0.25
  date_origin_hosp_prev<-"2020-05-01" # prev of 0.0036 infectious, 0.008 exposed
} 
if(scenario_community_prev=="prevh"){
  date_origin_com_prev<-"2020-04-01" # prev of 0.00325 infectious
  date_origin_hosp_rate<-"30/03/2020" # data kappa for week starting 30/03
  m_kappa<-1 
  changed_R0_community_mean<-1.5
  changed_p_LTCF2_outbreak_mean<-0.4
  date_origin_hosp_prev<-"2020-04-01" # prev of 0.001 infectious, 0.003 exposed
} 


if(scenario_staff_imp=="N"){
  #community R0 is zero
  changed_R0_community_mean<-0
  #p_LTCF2 outbreak is zero
  changed_p_LTCF2_outbreak_mean<-0}