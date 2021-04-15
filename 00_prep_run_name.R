# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to name run


### Define run name

# name scenario

if(fix_param_scenario=="Y"){name_fix_param_scenario<-"p_fixed"}
if(fix_param_scenario=="N"){name_fix_param_scenario<-"p_drawn"}

if(hosp_scenario=="setpIpcIaE"){name_hosp_scenario<-pIpcIaE}
if(hosp_scenario=="steph"){name_hosp_scenario<-hosp_scenario}

if(scenario_previous_outbreak=="Y"){name_scenario_previous_outbreak<-paste0("pRinit",0.5)}
if(scenario_previous_outbreak=="N"){name_scenario_previous_outbreak<-"pRinitb"}

if(scenario_LTCF_size=="baseline"){name_scenario_LTCF_size<-"sizeb"}
if(scenario_LTCF_size=="small"){name_scenario_LTCF_size<-"sizeS"}
if(scenario_LTCF_size=="large"){name_scenario_LTCF_size<-"sizeL"}

if(scenario_p_tnc=="change_p_tnc"){name_scenario_p_tnc<-paste0("ptnc",changed_p_tnc)}
if(scenario_p_tnc=="baseline"){name_scenario_p_tnc<-"ptncbase"}
if(scenario_p_tc=="change_p_tc"){name_scenario_p_tc<-paste0("ptc",changed_p_tc)}
if(scenario_p_tc=="baseline"){name_scenario_p_tc<-"ptcbase"}

if(scenario_p_tncs=="change_p_tncs"){name_scenario_p_tncs<-paste0("ptncs",changed_p_tncs)}
if(scenario_p_tncs=="baseline"){name_scenario_p_tncs<-"ptncsbase"}

if(scenario_f_tnc=="baseline"){name_scenario_f_tnc<-"ftncbase"} # test always
if(scenario_f_tnc=="change_f_tnc"){name_scenario_f_tnc<-paste0("ftnc", changed_f_tnc)} 
if(scenario_f_tc=="baseline"){name_scenario_f_tc<-"ftcbase"} # test always
if(scenario_f_tc=="change_f_tc"){name_scenario_f_tc<-paste0("ftc", changed_f_tc)} 
if(scenario_f_tncs=="baseline"){name_scenario_f_tncs<-"ftncsbase"} # test always
if(scenario_f_tncs=="change_f_tncs"){name_scenario_f_tncs<-paste0("ftncs", changed_f_tncs)} 

if(scenario_tested_after_H=="N"){name_scenario_tested_after_H<-"ntaH"}
if(scenario_tested_after_H=="Y"){name_scenario_tested_after_H<-"taH"}

if(scenario_COVID_returns=="baseline"){name_scenario_COVID_returns<-"IcHb"}
if(scenario_COVID_returns=="all_R"){name_scenario_COVID_returns<-"IcHallR"}
if(scenario_COVID_returns=="all_I"){name_scenario_COVID_returns<-"IcHallI"}

if(scenario_p_fn=="baseline"){name_scenario_p_fn<-"pfnbase"} 
if(scenario_p_fn=="change_p_fn"){name_scenario_p_fn<-paste0("pfn", changed_p_fn, "pfnh",changed_p_fn_h)} 

if(scenario_p_i=="change_p_i"){name_p_i_scenario<-paste0("pi",changed_p_i)}
if(scenario_p_i=="baseline"){name_p_i_scenario<-"pibase"}

if(scenario_m_i=="change_m_i"){name_m_i_scenario<-paste0("mi",changed_m_i)}
if(scenario_m_i=="baseline"){name_m_i_scenario<-"mibase"}

if(scenario_delay_isolation=="change"){name_delay_isolation_scenario<-paste0("di",changed_delay_isolation,
                                                                             "dic",changed_delay_isolation_c)}
if(scenario_delay_isolation=="baseline"){name_delay_isolation_scenario<-"dibase"}

if(scenario_beta=="change_R0"){name_beta_scenario<-paste0("R0a",changed_R0_a,"mR0b",changed_mR0_b)}
if(scenario_beta=="baseline"){name_beta_scenario<-"R0base"}

if(scenario_beta2=="change_beta2"){name_beta2_scenario<-paste0("b2",round(changed_m_beta2,2))}
if(scenario_beta2=="baseline"){name_beta2_scenario<-"b2base"}

if(scenario_beta3=="change_beta3"){name_beta3_scenario<-paste0("msr",changed_msr, 
                                                               "mss",changed_mss,
                                                               "mrs",changed_mrs)}
if(scenario_beta3=="baseline"){name_beta3_scenario<-"b3base"}


if(scenario_replacement_staff=="N"){name_scenario_replacement_staff<-"ns2"}
if(scenario_replacement_staff=="Y"){name_scenario_replacement_staff<-"s2"}

if(scenario_staff_other_LTCF=="baseline"){name_scenario_staff_other_LTCF<-"p2LTCFb"}
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){name_scenario_staff_other_LTCF<-paste0("p2LTCF",changed_p_working_another_LTCF)}

if(scenario_community_prev=="prevl"){
  name_scenario_community_prev<-"prevl"
} 
if(scenario_community_prev=="prevm"){
  name_scenario_community_prev<-"prevm"
} 
if(scenario_community_prev=="prevh"){
  name_scenario_community_prev<-"prevh"
} 


if(scenario_staff_imp=="Y"){
  name_scenario_staff_imp<-"SimpY"}
if(scenario_staff_imp=="N"){
  name_scenario_staff_imp<-"SimpN"}


### Compose name
run_name<-paste0(scenario_LTCF,
                 "_", "himp", name_hosp_scenario,
                 "_vis", scenario_v,
                 "_",name_scenario_previous_outbreak,
                 "_",name_scenario_LTCF_size,
                 "_", name_beta_scenario,
                 "_", name_beta2_scenario,
                 "_", name_beta3_scenario,
                 "_", name_p_i_scenario,
                 "_", name_m_i_scenario,
                 "_", name_delay_isolation_scenario,
                 "_",name_scenario_p_tnc,
                 "_",name_scenario_p_tc,
                 "_",name_scenario_p_tncs,
                 "_",name_scenario_f_tnc,
                 "_",name_scenario_f_tc,
                 "_",name_scenario_f_tncs,
                 "_",name_scenario_tested_after_H,
                 "_",name_scenario_p_fn,
                 "_",name_scenario_replacement_staff,
                 "_",name_scenario_staff_other_LTCF,
                 "_",name_scenario_COVID_returns,
                 "_",name_scenario_community_prev,
                 "_",name_fix_param_scenario,
                 "_", name_scenario_staff_imp,
                 "_himp", scenario_h_inf_imp, "_",n.sim, "_sim")