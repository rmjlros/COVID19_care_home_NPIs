# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to define baseline parameters



## number of simulations
n.sim<-1500

## choose nursing LTCF or residential LTCF
scenario_LTCF<-"nh"

## choose whether to fix all parameters or draw from distributions
fix_param_scenario<-"N"

## choose hospital pravalence scenario 
hosp_scenario<-"steph"

## scenario with no visitors or visitor frequency set
scenario_v<-"prep" #scenario with visitors

## scenario with hospital importations to LTCF?  ##### not named!!!
scenario_h_imp<-"Y" #scenario with hospital importations to LTCF, baseline 

## scenario with infectious importations from H to LTCF?
scenario_h_inf_imp<-"Y" # baseline

## simulation starts with 1 exposed or 0 exposed in LTCF?
scenario_exp<-"0"

## simulation starts with 50% residents recovered, 50% susceptibles
scenario_previous_outbreak<-"N" # baseline, no previous outbreak in LTCF

## LTCF size
scenario_LTCF_size<-"baseline" # baseline

## Testing scenarios
#-- Variations of p_tnc
scenario_p_tnc<-"baseline" # baseline is 85%

#-- Variations of p_tc
scenario_p_tc<-"baseline" # baseline is 90%

#-- Variations of p_tncs
scenario_p_tncs<-"baseline" # baseline is 100%

#-- Variations of f_tnc (frequency of testing), baseline is governed by percentage tested above
scenario_f_tnc<-"baseline" # baseline is every 28 days

#-- Variations of f_tc (frequency of testing), baseline is governed by percentage tested above
scenario_f_tc<-"baseline" # baseline is continous

#-- Variations of f_tncs (frequency of testing), baseline is governed by percentage tested above
scenario_f_tncs<-"baseline" # baseline is every 7 days
# name scenario

## Scenario in which all exits from hospital are tested (non-COVID hospitalised)
scenario_tested_after_H<-"Y"

## Scenario in which hospitalised COVID residents become isolated when readmitted or all come back R
scenario_COVID_returns<-"all_I" # all tested at hospital exit, and if Icl, isolated upon return if not false negative

## p_fn and p_fn_h 
scenario_p_fn<-"baseline"

## Isolation scenarios
#-- p_i
scenario_p_i<-"baseline"

#-- m_i
scenario_m_i<-"baseline"

#-- days before isolation for those with symptoms or testing positive
scenario_delay_isolation<-"baseline"

## Variations of beta (handwashing, deep cleaning of surfaces, etc)
#-- changing betas by altering R0
scenario_beta<-"baseline"

#-- changing all betas when >=1 resident isolated or staff are absent in LTCF
scenario_beta2<-"baseline"

#-- changing betas according to contact type
scenario_beta3<-"baseline"

## scenario in which no replacement staff
scenario_replacement_staff<-"Y"# staff are replaced, baseline

## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"baseline"

## variations  of community prevalence -- overrides normal selection of parameters for R0, kappa, p_LTCF2_outbreak.
scenario_community_prev<-"prevm" 

## scenarios in which switch deaths off and isolation off to calculate R0
scenario_deaths<-"Y"# allow deaths, baseline
scenario_isolation<-"Y" # allow isolation, baseline

## no importations from staff (!important that this set after community prevalence scenario)
scenario_staff_imp<-"Y" # baseline
