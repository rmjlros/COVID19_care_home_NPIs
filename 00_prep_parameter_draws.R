# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to draw parameters from distributions



# death rate in the LTCF non-clinical residents pppd
delta  <- rgamma(n=n.sim,shape=12, scale=(delta_mean/12))

# hospitalisation rate for non-clinical residents pppd
kappa <- rgamma(n.sim,shape=10, scale=(kappa_mean/10))

# number of visitors per resident in LTCF on any one day
n_V <- if(n_V_mean==0){rep(0,n.sim)}else if(n_V_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - n_V_mean) / 0.1^2 - 1 / n_V_mean) * n_V_mean^2), ((((1 - n_V_mean) / 0.1^2 - 1 / n_V_mean) * n_V_mean^2)*(1/n_V_mean - 1)))}

# duration of latency period
d_latency <- rgamma(n.sim,shape=4,scale=d_latency_mean/4)

# duration of pre-clinical infectious period
d_pc_inf <- rgamma(n.sim,shape=4,scale=d_pc_inf_mean/4)

# duration of clinical infectious period
d_c_inf <- rgamma(n.sim,shape=4,scale=d_c_inf_mean/4)

# proportion of infected residents that never present with COVID-19  symptoms
p_a <- rbeta(n.sim,(((1 - p_a_mean) / 0.1^2 - 1 / p_a_mean) * p_a_mean^2), ((((1 - p_a_mean) / 0.1^2 - 1 / p_a_mean) * p_a_mean^2)*(1/p_a_mean - 1)))

# proportion of infected staff that never present with COVID-19  symptoms
p_as <- rbeta(n.sim,(((1 - p_as_mean) / 0.05^2 - 1 / p_as_mean) * p_as_mean^2), ((((1 - p_as_mean) / 0.05^2 - 1 / p_as_mean) * p_as_mean^2)*(1/p_as_mean - 1)))

# proportion of transmission that occurs prior to symptom onset (whilst pre-clinical) vs during the symptomatic phase (clinical) in pathway a
proportion_transmission_pre_c_vs_c <- rbeta(n.sim,(((1 - proportion_transmission_pre_c_vs_c_mean) / 0.05^2 - 1 / proportion_transmission_pre_c_vs_c_mean) * proportion_transmission_pre_c_vs_c_mean^2), ((((1 - proportion_transmission_pre_c_vs_c_mean) / 0.05^2 - 1 / proportion_transmission_pre_c_vs_c_mean) * proportion_transmission_pre_c_vs_c_mean^2)*(1/proportion_transmission_pre_c_vs_c_mean - 1)))

# proportion of transmission that occurs whilst symptomatic with low infectiousness (late stage of infection) vs whilst symptomatic wit high infectiousness (early stage of infection) for staff and residents in pathway a
proportion_transmission_cl_vs_ch <- rbeta(n.sim,(((1 - proportion_transmission_cl_vs_ch_mean) / 0.05^2 - 1 / proportion_transmission_cl_vs_ch_mean) * proportion_transmission_cl_vs_ch_mean^2), ((((1 - proportion_transmission_cl_vs_ch_mean) / 0.05^2 - 1 / proportion_transmission_cl_vs_ch_mean) * proportion_transmission_cl_vs_ch_mean^2)*(1/proportion_transmission_cl_vs_ch_mean - 1)))

# R0 from staff and  residents  within  the  LTCF in pathway a (eventually develop symptoms)
R0_LTCF_a<-rgamma(n.sim,shape=8, scale=R0_LTCF_a_mean/8)

# Modifyer of R0 from staff and  residents  within  the  LTCF in pathway b (never develop symptoms) vs. pathway a (if 0.5 pathway b half as infectious as a)
m_R0_LTCF_b_vs_a <- rbeta(n.sim,(((1 - m_R0_LTCF_b_vs_a_mean) / 0.1^2 - 1 / m_R0_LTCF_b_vs_a_mean) * m_R0_LTCF_b_vs_a_mean^2), ((((1 - m_R0_LTCF_b_vs_a_mean) / 0.1^2 - 1 / m_R0_LTCF_b_vs_a_mean) * m_R0_LTCF_b_vs_a_mean^2)*(1/m_R0_LTCF_b_vs_a_mean - 1)))

# R0 in the community
R0_community <- if(R0_community_mean==0){rep(0,n.sim)}else{rgamma(n.sim,shape=16,scale=R0_community_mean/16)}

# community prevalence
c_prev <- rgamma(n.sim,shape=20,scale=c_prev_mean/20)     

# duration of infectiousness in the community
d_total_inf_community <- rgamma(n.sim,shape=4,scale=d_total_inf_community_mean/4)

# probability a LTCF has an outbreak
p_LTCF2_outbreak <- if(p_LTCF2_outbreak_mean==0){rep(0,n.sim)}else{rbeta(n.sim,(((1 - p_LTCF2_outbreak_mean) / 0.02^2 - 1 / p_LTCF2_outbreak_mean) * p_LTCF2_outbreak_mean^2), ((((1 - p_LTCF2_outbreak_mean) / 0.02^2 - 1 / p_LTCF2_outbreak_mean) * p_LTCF2_outbreak_mean^2)*(1/p_LTCF2_outbreak_mean - 1)))}

# probability that in a LTCF with an outbreak a resident or staff is infectious
p_LTCF2_outbreak_inf <- rbeta(n.sim,(((1 - p_LTCF2_outbreak_inf_mean) / 0.05^2 - 1 / p_LTCF2_outbreak_inf_mean) * p_LTCF2_outbreak_inf_mean^2), ((((1 - p_LTCF2_outbreak_inf_mean) / 0.05^2 - 1 / p_LTCF2_outbreak_inf_mean) * p_LTCF2_outbreak_inf_mean^2)*(1/p_LTCF2_outbreak_inf_mean - 1)))

# number of days that staff are absent for
n_days_absent <- rgamma(n.sim,shape=40,scale=n_days_absent_mean/40)

# probability staff work at another LTCF
p_working_another_LTCF  <- if(p_working_another_LTCF_mean==0){rep(0,n.sim)}else{rbeta(n.sim,(((1 - p_working_another_LTCF_mean) / 0.005^2 - 1 / p_working_another_LTCF_mean) * p_working_another_LTCF_mean^2), ((((1 - p_working_another_LTCF_mean) / 0.005^2 - 1 / p_working_another_LTCF_mean) * p_working_another_LTCF_mean^2)*(1/p_working_another_LTCF_mean - 1)))}

# probability replacement staff work at another LTCF
p_working_another_LTCF2  <- rbeta(n.sim,(((1 - p_working_another_LTCF2_mean) / 0.07^2 - 1 / p_working_another_LTCF2_mean) * p_working_another_LTCF2_mean^2), ((((1 - p_working_another_LTCF2_mean) / 0.07^2 - 1 / p_working_another_LTCF2_mean) * p_working_another_LTCF2_mean^2)*(1/p_working_another_LTCF2_mean - 1)))

# how much do transmission rates adjusted by after 1st case isolated/absent
m_beta2 <- rgamma(n.sim,shape=15,scale=m_beta2_mean/15)

# probability clinical residents return to the LTCF from hospital having survived COVID-19. 
p_survival <- rbeta(n.sim,(((1 - p_survival_mean) / 0.1^2 - 1 / p_survival_mean) * p_survival_mean^2), ((((1 - p_survival_mean) / 0.1^2 - 1 / p_survival_mean) * p_survival_mean^2)*(1/p_survival_mean - 1)))

# delay from start of state to isolation in symptomatic
delay_to_isolation_c = rgamma(n.sim,shape=4,scale=delay_to_isolation_c_mean/4)

# delay from start of state to isolation in those without symptoms
delay_to_isolation_nc = rgamma(n.sim,shape=4,scale=delay_to_isolation_nc_mean/4)

# relative infectiousness of clinical residents being isolated (Ici) vs Ic
m_i <- if(m_i_mean==0){rep(0,n.sim)}else if(m_i_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - m_i_mean) / 0.15^2 - 1 / m_i_mean) * m_i_mean^2), ((((1 - m_i_mean) / 0.15^2 - 1 / m_i_mean) * m_i_mean^2)*(1/m_i_mean - 1)))}

# relative infectiousness of visitors vs Ia
m_v <- rnorm(n.sim,m_v_mean,0.2)

# probability of visitors being infectious
p_v_infectious <- rgamma(n.sim,shape=20,scale=p_v_infectious_mean/20)

# probability of being tested if not symptomatic with COVID-19
p_tnc <- if(p_tnc_mean==0){rep(0,n.sim)}else if(p_tnc_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_tnc_mean) / 0.05^2 - 1 / p_tnc_mean) * p_tnc_mean^2), ((((1 - p_tnc_mean) / 0.05^2 - 1 / p_tnc_mean) * p_tnc_mean^2)*(1/p_tnc_mean - 1)))}

## probability of being tested if symptomatic with COVID-19
p_tc <- if(p_tc_mean==0){rep(0,n.sim)}else if(p_tc_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_tc_mean) / 0.05^2 - 1 / p_tc_mean) * p_tc_mean^2), ((((1 - p_tc_mean) / 0.05^2 - 1 / p_tc_mean) * p_tc_mean^2)*(1/p_tc_mean - 1)))}

# probability of STAFF being tested if not symptomatic with COVID-19
p_tncs <- if(p_tncs_mean==0){rep(0,n.sim)}else if(p_tncs_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_tncs_mean) / 0.05^2 - 1 / p_tncs_mean) * p_tncs_mean^2), ((((1 - p_tncs_mean) / 0.05^2 - 1 / p_tncs_mean) * p_tncs_mean^2)*(1/p_tncs_mean - 1)))}

# probability of having a false-negative test in care home
p_fn <- if(p_fn_mean==0){rep(0,n.sim)}else if(p_fn_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_fn_mean) / 0.05^2 - 1 / p_fn_mean) * p_fn_mean^2), ((((1 - p_fn_mean) / 0.05^2 - 1 / p_fn_mean) * p_fn_mean^2)*(1/p_fn_mean - 1)))}

# probability of having a false-negative test in hospital
p_fn_h <- if(p_fn_h_mean==0){rep(0,n.sim)}else if(p_fn_h_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_fn_h_mean) / 0.01^2 - 1 / p_fn_h_mean) * p_fn_h_mean^2), ((((1 - p_fn_h_mean) / 0.01^2 - 1 / p_fn_h_mean) * p_fn_h_mean^2)*(1/p_fn_h_mean - 1)))}

# probability of clinical residents being isolated
p_i <- if(p_i_mean==0){rep(0,n.sim)}else if(p_i_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_i_mean) / 0.08^2 - 1 / p_i_mean) * p_i_mean^2), ((((1 - p_i_mean) / 0.08^2 - 1 / p_i_mean) * p_i_mean^2)*(1/p_i_mean - 1)))}

# case fatality ratio in residents
CFR <- if(CFR_mean==0){rep(0,n.sim)}else if(CFR_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - CFR_mean) / 0.08^2 - 1 / CFR_mean) * CFR^2), ((((1 - CFR_mean) / 0.08^2 - 1 / CFR_mean) * CFR^2)*(1/CFR_mean - 1)))}

# deaths in  hospital
p_deaths_in_LTCF_vs_H <- rbeta(n.sim,(((1 - p_deaths_in_LTCF_vs_H_mean) / 0.05^2 - 1 / p_deaths_in_LTCF_vs_H_mean) * p_deaths_in_LTCF_vs_H_mean^2), ((((1 - p_deaths_in_LTCF_vs_H_mean) / 0.05^2 - 1 / p_deaths_in_LTCF_vs_H_mean) * p_deaths_in_LTCF_vs_H_mean^2)*(1/p_deaths_in_LTCF_vs_H_mean - 1)))

# deaths in res vs nh
if(m_delta_c_res_mean<1){
  m_delta_c_res <- rbeta(n.sim,(((1 - m_delta_c_res_mean) / 0.15^2 - 1 / m_delta_c_res_mean) * m_delta_c_res_mean^2), ((((1 - m_delta_c_res_mean) / 0.15^2 - 1 / m_delta_c_res_mean) * m_delta_c_res_mean^2)*(1/m_delta_c_res_mean - 1)))
}else{
  m_delta_c_res <- 1
}

# probability of staff absent being replaced
p_replaced <- rbeta(n.sim,(((1 - p_replaced_mean) / 0.05^2 - 1 / p_replaced_mean) * p_replaced_mean^2), ((((1 - p_replaced_mean) / 0.05^2 - 1 / p_replaced_mean) * p_replaced_mean^2)*(1/p_replaced_mean - 1)))

# proportion all entries from hospital into R
p_R_hosp  <-  rbeta(n.sim,(((1 - p_R_hosp_mean) / 0.03^2 - 1 / p_R_hosp_mean) * p_R_hosp_mean^2), ((((1 - p_R_hosp_mean) / 0.03^2 - 1 / p_R_hosp_mean) * p_R_hosp_mean^2)*(1/p_R_hosp_mean - 1)))

# proportion all entries from hospital into E, Ipc, Ia (infectious entries)
p_EIpcIa_hosp  <-  if(p_EIpcIa_hosp_mean==0){rep(0,n.sim)}else if(p_EIpcIa_hosp_mean==1){rep(1,n.sim)}else{rbeta(n.sim,(((1 - p_EIpcIa_hosp_mean) / 0.001^2 - 1 / p_EIpcIa_hosp_mean) * p_EIpcIa_hosp_mean^2), ((((1 - p_EIpcIa_hosp_mean) / 0.001^2 - 1 / p_EIpcIa_hosp_mean) * p_EIpcIa_hosp_mean^2)*(1/p_EIpcIa_hosp_mean - 1)))}

# proportion still shedding after COVID-19 hospitalisation
p_shedding_after_H  <-  rbeta(n.sim,(((1 - p_shedding_after_H_mean) / 0.02^2 - 1 / p_shedding_after_H_mean) * p_shedding_after_H_mean^2), ((((1 - p_shedding_after_H_mean) / 0.02^2 - 1 / p_shedding_after_H_mean) * p_shedding_after_H_mean^2)*(1/p_shedding_after_H_mean - 1)))

# proportion of replacement staff entering R
p_R_s2 <-  rbeta(n.sim,(((1 - p_R_s2_mean) / 0.03^2 - 1 / p_R_s2_mean) * p_R_s2_mean^2), ((((1 - p_R_s2_mean) / 0.03^2 - 1 / p_R_s2_mean) * p_R_s2_mean^2)*(1/p_R_s2_mean - 1)))

# proportion all replacement staff entering E, Ipc, Ia (infectious)
p_EIpcIa_s2 <- rbeta(n.sim,(((1 - p_EIpcIa_s2_mean) / 0.001^2 - 1 / p_EIpcIa_s2_mean) * p_EIpcIa_s2_mean^2), ((((1 - p_EIpcIa_s2_mean) / 0.001^2 - 1 / p_EIpcIa_s2_mean) * p_EIpcIa_s2_mean^2)*(1/p_EIpcIa_s2_mean - 1)))




###  EXTREME PARAMETER VALUES 

## LL

delta_ll <- rep(quantile(delta,0.05)[[1]], n.sim)
kappa_ll <- rep(quantile(kappa,0.05)[[1]], n.sim)
n_V_ll <- rep(quantile(n_V,0.05)[[1]], n.sim)
d_latency_ll <- rep(quantile(d_latency,0.05)[[1]], n.sim)
d_pc_inf_ll <- rep(quantile(d_pc_inf,0.05)[[1]], n.sim)
d_c_inf_ll <- rep(quantile(d_c_inf,0.05)[[1]], n.sim)
p_a_ll <- rep(quantile(p_a,0.05)[[1]], n.sim)
p_as_ll <- rep(quantile(p_as,0.05)[[1]], n.sim)
proportion_transmission_pre_c_vs_c_ll <- rep(quantile(proportion_transmission_pre_c_vs_c,0.05)[[1]], n.sim)
proportion_transmission_cl_vs_ch_ll <- rep(quantile(proportion_transmission_cl_vs_ch,0.05)[[1]], n.sim)
R0_LTCF_a_ll <- rep(quantile(R0_LTCF_a,0.05)[[1]], n.sim)
m_R0_LTCF_b_vs_a_ll <- rep(quantile(m_R0_LTCF_b_vs_a,0.05)[[1]], n.sim)
R0_community_ll <- rep(quantile(R0_community,0.05)[[1]], n.sim)
c_prev_ll <- rep(quantile(c_prev,0.05)[[1]], n.sim)
d_total_inf_community_ll <- rep(quantile(d_total_inf_community,0.05)[[1]], n.sim)
p_LTCF2_outbreak_ll <- rep(quantile(p_LTCF2_outbreak,0.05)[[1]], n.sim)
p_LTCF2_outbreak_inf_ll <- rep(quantile(p_LTCF2_outbreak_inf,0.05)[[1]], n.sim)
n_days_absent_ll <- rep(quantile(n_days_absent,0.05)[[1]], n.sim)
p_working_another_LTCF_ll <- rep(quantile(p_working_another_LTCF,0.05)[[1]], n.sim)
p_working_another_LTCF2_ll <- rep(quantile(p_working_another_LTCF2,0.05)[[1]], n.sim)
m_beta2_ll <- rep(quantile(m_beta2,0.05)[[1]], n.sim)
p_survival_ll <- rep(quantile(p_survival,0.05)[[1]], n.sim)
delay_to_isolation_c_ll <- rep(quantile(delay_to_isolation_c,0.05)[[1]], n.sim)
delay_to_isolation_nc_ll <- rep(quantile(delay_to_isolation_nc,0.05)[[1]], n.sim)
m_i_ll <- rep(quantile(m_i,0.05)[[1]], n.sim)
m_v_ll <- rep(quantile(m_v,0.05)[[1]], n.sim)
p_v_infectious_ll <- rep(quantile(p_v_infectious,0.05)[[1]], n.sim)
p_tnc_ll <- rep(quantile(p_tnc,0.05)[[1]], n.sim)
p_tc_ll <- rep(quantile(p_tc,0.05)[[1]], n.sim)
p_tncs_ll <- rep(quantile(p_tncs,0.05)[[1]], n.sim)
p_fn_ll <- rep(quantile(p_fn,0.05)[[1]], n.sim)
p_fn_h_ll <- rep(quantile(p_fn_h,0.05)[[1]], n.sim)
p_i_ll <- rep(quantile(p_i,0.05)[[1]], n.sim)
CFR_ll <- rep(quantile(CFR,0.05)[[1]], n.sim)
p_deaths_in_LTCF_vs_H_ll <- rep(quantile(p_deaths_in_LTCF_vs_H,0.05)[[1]], n.sim)
if(quantile(m_delta_c_res,0.05)[[1]]<1){
  m_delta_c_res_ll <- rep(quantile(m_delta_c_res,0.05)[[1]], n.sim)
}else{
  m_delta_c_res_ll <- rep(1, n.sim)
}
p_replaced_ll <- rep(quantile(p_replaced,0.05)[[1]], n.sim)
p_R_hosp_ll <- rep(quantile(p_R_hosp,0.05)[[1]], n.sim)
p_EIpcIa_hosp_ll <- rep(quantile(p_EIpcIa_hosp,0.05)[[1]], n.sim)
p_shedding_after_H_ll <- rep(quantile(p_shedding_after_H,0.05)[[1]], n.sim)
p_R_s2_ll <- rep(quantile(p_R_s2,0.05)[[1]], n.sim)
p_EIpcIa_s2_ll <- rep(quantile(p_EIpcIa_s2,0.05)[[1]], n.sim)



## UL

delta_ul <- rep(quantile(delta,0.95)[[1]], n.sim)
kappa_ul <- rep(quantile(kappa,0.95)[[1]], n.sim)
n_V_ul <- rep(quantile(n_V,0.95)[[1]], n.sim)
d_latency_ul <- rep(quantile(d_latency,0.95)[[1]], n.sim)
d_pc_inf_ul <- rep(quantile(d_pc_inf,0.95)[[1]], n.sim)
d_c_inf_ul <- rep(quantile(d_c_inf,0.95)[[1]], n.sim)
p_a_ul <- rep(quantile(p_a,0.95)[[1]], n.sim)
p_as_ul <- rep(quantile(p_as,0.95)[[1]], n.sim)
proportion_transmission_pre_c_vs_c_ul <- rep(quantile(proportion_transmission_pre_c_vs_c,0.95)[[1]], n.sim)
proportion_transmission_cl_vs_ch_ul <- rep(quantile(proportion_transmission_cl_vs_ch,0.95)[[1]], n.sim)
R0_LTCF_a_ul <- rep(quantile(R0_LTCF_a,0.95)[[1]], n.sim)
m_R0_LTCF_b_vs_a_ul <- rep(quantile(m_R0_LTCF_b_vs_a,0.95)[[1]], n.sim)
R0_community_ul <- rep(quantile(R0_community,0.95)[[1]], n.sim)
c_prev_ul <- rep(quantile(c_prev,0.95)[[1]], n.sim)
d_total_inf_community_ul <- rep(quantile(d_total_inf_community,0.95)[[1]], n.sim)
p_LTCF2_outbreak_ul <- rep(quantile(p_LTCF2_outbreak,0.95)[[1]], n.sim)
p_LTCF2_outbreak_inf_ul <- rep(quantile(p_LTCF2_outbreak_inf,0.95)[[1]], n.sim)
n_days_absent_ul <- rep(quantile(n_days_absent,0.95)[[1]], n.sim)
p_working_another_LTCF_ul <- rep(quantile(p_working_another_LTCF,0.95)[[1]], n.sim)
p_working_another_LTCF2_ul <- rep(quantile(p_working_another_LTCF2,0.95)[[1]], n.sim)
m_beta2_ul <- rep(quantile(m_beta2,0.95)[[1]], n.sim)
p_survival_ul <- rep(quantile(p_survival,0.95)[[1]], n.sim)
delay_to_isolation_c_ul <- rep(quantile(delay_to_isolation_c,0.95)[[1]], n.sim)
delay_to_isolation_nc_ul <- rep(quantile(delay_to_isolation_nc,0.95)[[1]], n.sim)
m_i_ul <- rep(quantile(m_i,0.95)[[1]], n.sim)
m_v_ul <- rep(quantile(m_v,0.95)[[1]], n.sim)
p_v_infectious_ul <- rep(quantile(p_v_infectious,0.95)[[1]], n.sim)
p_tnc_ul <- rep(quantile(p_tnc,0.95)[[1]], n.sim)
p_tc_ul <- rep(quantile(p_tc,0.95)[[1]], n.sim)
p_tncs_ul <- rep(quantile(p_tncs,0.95)[[1]], n.sim)
p_fn_ul <- rep(quantile(p_fn,0.95)[[1]], n.sim)
p_fn_h_ul <- rep(quantile(p_fn_h,0.95)[[1]], n.sim)
p_i_ul <- rep(quantile(p_i,0.95)[[1]], n.sim)
CFR_ul <- rep(quantile(CFR,0.95)[[1]], n.sim)
p_deaths_in_LTCF_vs_H_ul <- rep(quantile(p_deaths_in_LTCF_vs_H,0.95)[[1]], n.sim)
if(quantile(m_delta_c_res,0.95)[[1]]<1){
  m_delta_c_res_ul <- rep(quantile(m_delta_c_res,0.95)[[1]], n.sim)
}else{
  m_delta_c_res_ul <- rep(1, n.sim)
}
p_replaced_ul <- rep(quantile(p_replaced,0.95)[[1]], n.sim)
p_R_hosp_ul <- rep(quantile(p_R_hosp,0.95)[[1]], n.sim)
p_EIpcIa_hosp_ul <- rep(quantile(p_EIpcIa_hosp,0.95)[[1]], n.sim)
p_shedding_after_H_ul <- rep(quantile(p_shedding_after_H,0.95)[[1]], n.sim)
p_R_s2_ul <- rep(quantile(p_R_s2,0.95)[[1]], n.sim)
p_EIpcIa_s2_ul <- rep(quantile(p_EIpcIa_s2,0.95)[[1]], n.sim)




###  SCENARIO IN WHICH FIXING ALL PARAMETERS

if (fix_param_scenario=="Y")
{
  delta  <- rep(quantile(delta,0.5)[[1]], n.sim)
  kappa <- rep(quantile(kappa,0.5)[[1]], n.sim)
  n_V <- rep(quantile(n_V,0.5)[[1]], n.sim)
  d_latency <- rep(quantile(d_latency,0.5)[[1]], n.sim)
  d_pc_inf <- rep(quantile(d_pc_inf,0.5)[[1]], n.sim)
  d_c_inf <- rep(quantile(d_c_inf,0.5)[[1]], n.sim)
  p_a <- rep(quantile(p_a,0.5)[[1]], n.sim)
  p_as <- rep(quantile(p_as,0.5)[[1]], n.sim)
  proportion_transmission_pre_c_vs_c <- rep(quantile(proportion_transmission_pre_c_vs_c,0.5)[[1]], n.sim)
  proportion_transmission_cl_vs_ch <- rep(quantile(proportion_transmission_cl_vs_ch,0.5)[[1]], n.sim)
  R0_LTCF_a <- rep(quantile(R0_LTCF_a,0.5)[[1]], n.sim)
  m_R0_LTCF_b_vs_a <- rep(quantile(m_R0_LTCF_b_vs_a,0.5)[[1]], n.sim)
  R0_community <- rep(quantile(R0_community,0.5)[[1]], n.sim)
  c_prev <- rep(quantile(c_prev,0.5)[[1]], n.sim)
  d_total_inf_community <- rep(quantile(d_total_inf_community,0.5)[[1]], n.sim)
  p_LTCF2_outbreak <- rep(quantile(p_LTCF2_outbreak,0.5)[[1]], n.sim)
  p_LTCF2_outbreak_inf <- rep(quantile(p_LTCF2_outbreak_inf,0.5)[[1]], n.sim)
  n_days_absent <- rep(quantile(n_days_absent,0.5)[[1]], n.sim)
  p_working_another_LTCF  <- rep(quantile(p_working_another_LTCF,0.5)[[1]], n.sim)
  p_working_another_LTCF2  <- rep(quantile(p_working_another_LTCF2,0.5)[[1]], n.sim)
  m_beta2 <- rep(quantile(m_beta2,0.5)[[1]], n.sim)
  p_survival <- rep(quantile(p_survival,0.5)[[1]], n.sim)
  delay_to_isolation_c <- rep(quantile(delay_to_isolation_c,0.5)[[1]], n.sim)
  delay_to_isolation_nc <- rep(quantile(delay_to_isolation_nc,0.5)[[1]], n.sim)
  m_i <- rep(quantile(m_i,0.5)[[1]], n.sim)
  m_v <- rep(quantile(m_v,0.5)[[1]], n.sim)
  p_v_infectious <- rep(quantile(p_v_infectious,0.5)[[1]], n.sim)
  p_tnc <- rep(quantile(p_tnc,0.5)[[1]], n.sim)
  p_tc <- rep(quantile(p_tc,0.5)[[1]], n.sim)
  p_tncs <- rep(quantile(p_tncs,0.5)[[1]], n.sim)
  p_fn <- rep(quantile(p_fn,0.5)[[1]], n.sim)
  p_fn_h <- rep(quantile(p_fn_h,0.5)[[1]], n.sim)
  p_i <- rep(quantile(p_i,0.5)[[1]], n.sim)
  CFR <- rep(quantile(CFR,0.5)[[1]], n.sim)
  p_deaths_in_LTCF_vs_H <- rep(quantile(p_deaths_in_LTCF_vs_H,0.5)[[1]], n.sim)
  if(m_delta_c_res_mean<1){
    m_delta_c_res <- rep(quantile(m_delta_c_res,0.5)[[1]], n.sim)
  }else{
    m_delta_c_res <- rep(1, n.sim)
  }
  p_replaced <- rep(quantile(p_replaced,0.5)[[1]], n.sim)
  p_R_hosp  <- rep(quantile( p_R_hosp,0.5)[[1]], n.sim)
  p_EIpcIa_hosp  <- rep(quantile( p_EIpcIa_hosp,0.5)[[1]], n.sim)
  p_shedding_after_H  <- rep(quantile( p_shedding_after_H,0.5)[[1]], n.sim)
  p_R_s2 <- rep(quantile( p_R_s2,0.5)[[1]], n.sim)
  p_EIpcIa_s2 <- rep(quantile(p_EIpcIa_s2,0.5)[[1]], n.sim)
  
}








### COMBINATION OF PARAMETERS FOR THETA

theta_matrix_rates<-rbind(delta, 
                          kappa, 
                          n_V)

theta_matrix_other<-rbind(d_latency,
                          d_pc_inf,
                          d_c_inf,
                          p_a,
                          p_as,
                          proportion_transmission_pre_c_vs_c,
                          proportion_transmission_cl_vs_ch,
                          R0_LTCF_a,
                          m_R0_LTCF_b_vs_a,
                          R0_community,
                          c_prev,
                          d_total_inf_community,
                          p_LTCF2_outbreak,
                          p_LTCF2_outbreak_inf,
                          n_days_absent,
                          p_working_another_LTCF,
                          p_working_another_LTCF2,
                          m_beta2,
                          p_survival,
                          delay_to_isolation_c,
                          delay_to_isolation_nc,
                          m_i,
                          m_v,
                          p_v_infectious,
                          p_tnc,
                          p_tc,
                          p_tncs,
                          p_fn,
                          p_fn_h,
                          p_i,
                          CFR,
                          p_deaths_in_LTCF_vs_H,
                          m_delta_c_res,
                          p_replaced,
                          p_R_hosp,
                          p_EIpcIa_hosp,
                          p_shedding_after_H,
                          p_R_s2,
                          p_EIpcIa_s2)

theta_matrix_fixed<-rbind(rho=rep(rho,n.sim),
                          switch_h_imp=rep(switch_h_imp,n.sim),
                          switch_new_staff=rep(switch_new_staff,n.sim),
                          msr_pc=rep(msr_pc,n.sim), 
                          msr_h=rep(msr_h,n.sim), 
                          msr_a=rep(msr_a,n.sim),
                          mss_pc=rep(mss_pc,n.sim), 
                          mss_h=rep(mss_h,n.sim), 
                          mss_a=rep(mss_a,n.sim),
                          mrs_pc=rep(mrs_pc,n.sim), 
                          mrs_h=rep(mrs_h,n.sim), 
                          mrs_l=rep(mrs_l,n.sim), 
                          mrs_a=rep(mrs_a,n.sim),
                          tnc_period=rep(tnc_period,n.sim),
                          tc_period=rep(tc_period,n.sim),
                          tncs_period=rep(tncs_period,n.sim),
                          p_E_if_inf_hosp=rep(p_E_if_inf_hosp,n.sim),
                          p_Ipc_if_inf_hosp=rep(p_Ipc_if_inf_hosp,n.sim),
                          p_Ia_if_inf_hosp=rep(p_Ia_if_inf_hosp,n.sim),
                          p_E_if_inf_s2=rep(p_E_if_inf_s2,n.sim),
                          p_Ipc_if_inf_s2=rep(p_Ipc_if_inf_s2,n.sim),
                          p_Ia_if_inf_s2=rep(p_Ia_if_inf_s2,n.sim),
                          switch_h_testing=rep(switch_h_testing,n.sim),
                          switch_all_COVID_returns=rep(switch_all_COVID_returns,n.sim),
                          N_S=rep(N_S,n.sim),
                          N_E=rep(N_E,n.sim),
                          N_R=rep(N_R,n.sim),
                          N_Ss=rep(N_Ss,n.sim),
                          N_Rs=rep(N_Rs,n.sim)
)


theta_matrix_rates_ll<-rbind(delta_ll, 
                             kappa_ll, 
                             n_V_ll)

theta_matrix_other_ll<-rbind(d_latency_ll,
                             d_pc_inf_ll,
                             d_c_inf_ll,
                             p_a_ll,
                             p_as_ll,
                             proportion_transmission_pre_c_vs_c_ll,
                             proportion_transmission_cl_vs_ch_ll,
                             R0_LTCF_a_ll,
                             m_R0_LTCF_b_vs_a_ll,
                             R0_community_ll,
                             c_prev_ll,
                             d_total_inf_community_ll,
                             p_LTCF2_outbreak_ll,
                             p_LTCF2_outbreak_inf_ll,
                             n_days_absent_ll,
                             p_working_another_LTCF_ll,
                             p_working_another_LTCF2_ll,
                             m_beta2_ll,
                             p_survival_ll,
                             delay_to_isolation_c_ll,
                             delay_to_isolation_nc_ll,
                             m_i_ll,
                             m_v_ll,
                             p_v_infectious_ll,
                             p_tnc_ll,
                             p_tc_ll,
                             p_tncs_ll,
                             p_fn_ll,
                             p_fn_h_ll,
                             p_i_ll,
                             CFR_ll,
                             p_deaths_in_LTCF_vs_H_ll,
                             m_delta_c_res_ll,
                             p_replaced_ll,
                             p_R_hosp_ll,
                             p_EIpcIa_hosp_ll,
                             p_shedding_after_H_ll,
                             p_R_s2_ll,
                             p_EIpcIa_s2_ll)

theta_matrix_fixed_ll<-rbind(rho_ll=rep(rho_ll,n.sim),
                             switch_h_imp_ll=rep(switch_h_imp_ll,n.sim),
                             switch_new_staff_ll=rep(switch_new_staff_ll,n.sim),
                             msr_pc_ll=rep(msr_pc_ll,n.sim), 
                             msr_h_ll=rep(msr_h_ll,n.sim), 
                             msr_a_ll=rep(msr_a_ll,n.sim),
                             mss_pc_ll=rep(mss_pc_ll,n.sim), 
                             mss_h_ll=rep(mss_h_ll,n.sim), 
                             mss_a_ll=rep(mss_a_ll,n.sim),
                             mrs_pc_ll=rep(mrs_pc_ll,n.sim), 
                             mrs_h_ll=rep(mrs_h_ll,n.sim), 
                             mrs_l_ll=rep(mrs_l_ll,n.sim), 
                             mrs_a_ll=rep(mrs_a_ll,n.sim),
                             tnc_period_ll=rep(tnc_period_ll,n.sim),
                             tc_period_ll=rep(tc_period_ll,n.sim),
                             tncs_period_ll=rep(tncs_period_ll,n.sim),
                             p_E_if_inf_hosp_ll=rep(p_E_if_inf_hosp_ll,n.sim),
                             p_Ipc_if_inf_hosp_ll=rep(p_Ipc_if_inf_hosp_ll,n.sim),
                             p_Ia_if_inf_hosp_ll=rep(p_Ia_if_inf_hosp_ll,n.sim),
                             p_E_if_inf_s2_ll=rep(p_E_if_inf_s2_ll,n.sim),
                             p_Ipc_if_inf_s2_ll=rep(p_Ipc_if_inf_s2_ll,n.sim),
                             p_Ia_if_inf_s2_ll=rep(p_Ia_if_inf_s2_ll,n.sim),
                             switch_h_testing_ll=rep(switch_h_testing_ll,n.sim),
                             switch_all_COVID_returns_ll=rep(switch_all_COVID_returns_ll,n.sim),
                             N_S_ll=rep(N_S_ll,n.sim),
                             N_E_ll=rep(N_E_ll,n.sim),
                             N_R_ll=rep(N_R_ll,n.sim),
                             N_Ss_ll=rep(N_Ss_ll,n.sim),
                             N_Rs_ll=rep(N_Rs_ll,n.sim))

theta_matrix_rates_ul<-rbind(delta_ul, 
                             kappa_ul, 
                             n_V_ul)

theta_matrix_other_ul<-rbind(d_latency_ul,
                             d_pc_inf_ul,
                             d_c_inf_ul,
                             p_a_ul,
                             p_as_ul,
                             proportion_transmission_pre_c_vs_c_ul,
                             proportion_transmission_cl_vs_ch_ul,
                             R0_LTCF_a_ul,
                             m_R0_LTCF_b_vs_a_ul,
                             R0_community_ul,
                             c_prev_ul,
                             d_total_inf_community_ul,
                             p_LTCF2_outbreak_ul,
                             p_LTCF2_outbreak_inf_ul,
                             n_days_absent_ul,
                             p_working_another_LTCF_ul,
                             p_working_another_LTCF2_ul,
                             m_beta2_ul,
                             p_survival_ul,
                             delay_to_isolation_c_ul,
                             delay_to_isolation_nc_ul,
                             m_i_ul,
                             m_v_ul,
                             p_v_infectious_ul,
                             p_tnc_ul,
                             p_tc_ul,
                             p_tncs_ul,
                             p_fn_ul,
                             p_fn_h_ul,
                             p_i_ul,
                             CFR_ul,
                             p_deaths_in_LTCF_vs_H_ul,
                             m_delta_c_res_ul,
                             p_replaced_ul,
                             p_R_hosp_ul,
                             p_EIpcIa_hosp_ul,
                             p_shedding_after_H_ul,
                             p_R_s2_ul,
                             p_EIpcIa_s2_ul)

theta_matrix_fixed_ul<-rbind(rho_ul=rep(rho_ul,n.sim),
                             switch_h_imp_ul=rep(switch_h_imp_ul,n.sim),
                             switch_new_staff_ul=rep(switch_new_staff_ul,n.sim),
                             msr_pc_ul=rep(msr_pc_ul,n.sim), 
                             msr_h_ul=rep(msr_h_ul,n.sim), 
                             msr_a_ul=rep(msr_a_ul,n.sim),
                             mss_pc_ul=rep(mss_pc_ul,n.sim), 
                             mss_h_ul=rep(mss_h_ul,n.sim), 
                             mss_a_ul=rep(mss_a_ul,n.sim),
                             mrs_pc_ul=rep(mrs_pc_ul,n.sim), 
                             mrs_h_ul=rep(mrs_h_ul,n.sim), 
                             mrs_l_ul=rep(mrs_l_ul,n.sim), 
                             mrs_a_ul=rep(mrs_a_ul,n.sim),
                             tnc_period_ul=rep(tnc_period_ul,n.sim),
                             tc_period_ul=rep(tc_period_ul,n.sim),
                             tncs_period_ul=rep(tncs_period_ul,n.sim),
                             p_E_if_inf_hosp_ul=rep(p_E_if_inf_hosp_ul,n.sim),
                             p_Ipc_if_inf_hosp_ul=rep(p_Ipc_if_inf_hosp_ul,n.sim),
                             p_Ia_if_inf_hosp_ul=rep(p_Ia_if_inf_hosp_ul,n.sim),
                             p_E_if_inf_s2_ul=rep(p_E_if_inf_s2_ul,n.sim),
                             p_Ipc_if_inf_s2_ul=rep(p_Ipc_if_inf_s2_ul,n.sim),
                             p_Ia_if_inf_s2_ul=rep(p_Ia_if_inf_s2_ul,n.sim),
                             switch_h_testing_ul=rep(switch_h_testing_ul,n.sim),
                             switch_all_COVID_returns_ul=rep(switch_all_COVID_returns_ul,n.sim),
                             N_S_ul=rep(N_S_ul,n.sim),
                             N_E_ul=rep(N_E_ul,n.sim),
                             N_R_ul=rep(N_R_ul,n.sim),
                             N_Ss_ul=rep(N_Ss_ul,n.sim),
                             N_Rs_ul=rep(N_Rs_ul,n.sim))


# aggregate matrices
theta_matrix_1<-rbind(theta_matrix_rates, theta_matrix_other, theta_matrix_fixed)  
theta_matrix_1_ll<-rbind(theta_matrix_rates_ll, theta_matrix_other_ll, theta_matrix_fixed_ll)   
theta_matrix_1_ul<-rbind(theta_matrix_rates_ul, theta_matrix_other_ul, theta_matrix_fixed_ul)  
theta_matrix_1_ll_ul<-rbind(theta_matrix_1_ll,theta_matrix_1_ul)  


