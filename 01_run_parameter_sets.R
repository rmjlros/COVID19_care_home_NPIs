# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to run parameter sets



#### paths
Output<-"Outputs/Params/"
data_input<-"00_prep_data.R"
params<-"00_prep_parameter_means.R"
param_draws<-"00_prep_parameter_draws.R"
param_combo<-"00_prep_parameter_combo.R"
run_name_generator<-"00_prep_run_name.R"


#### 1a. run baseline parameters nursing care homes 
 
### set parameters

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
if(scenario_v=="N" & scenario_h_imp=="N"){scenario_exp<-"1"}else{scenario_exp<-"0"}

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

## scenarios in which switch deaths off and isolation off to calculate R0
scenario_deaths<-"Y"# allow deaths, baseline
scenario_isolation<-"Y" # allow isolation, baseline

## no importations from staff (!important that this set after community prevalence scenario)
scenario_staff_imp<-"Y" # baseline
if(scenario_staff_imp=="N"){
  #community R0 is zero
  changed_R0_community_mean<-0
  #p_LTCF2 outbreak is zero
  changed_p_LTCF2_outbreak_mean<-0}


### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))



#### 1b. run baseline parameters for residential care homes

### set parameters
## choose nursing LTCF or residential LTCF
scenario_LTCF<-"res"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))



#### 2a. run with high community prevalence for nursing care homes

### set parameters

## choose nursing LTCF or residential LTCF
scenario_LTCF<-"nh"

## community prevalence
scenario_community_prev<-"prevh" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))


#### 2b. run with high community prevalence for residential care homes

### set parameters

## choose nursing LTCF or residential LTCF
scenario_LTCF<-"res"

## community prevalence
scenario_community_prev<-"prevh" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))



#### 3a. run with low community prevalence for nursing care homes

### set parameters

## choose nursing LTCF or residential LTCF
scenario_LTCF<-"nh"

## community prevalence
scenario_community_prev<-"prevl" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))


#### 3b. run with low community prevalence for residential care homes

### set parameters

## choose nursing LTCF or residential LTCF
scenario_LTCF<-"res"

## community prevalence
scenario_community_prev<-"prevl" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output,run_name,"_params.csv",sep=""))


#### 4a. run with mean R0a=1 for nursing care homes

