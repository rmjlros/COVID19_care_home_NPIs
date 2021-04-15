# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to run parameter sets and output these to Outputs/Params


#### clear environment
rm(list = ls(all = TRUE))	


#### load packages
require(readxl)
require(dplyr)
library(reshape2)


#### paths
Output_params<-"Outputs/Params/"
baseline_scenario<-"00_prep_baseline_parameters.R"
data_input<-"00_prep_data.R"
params<-"00_prep_parameter_means.R"
param_draws<-"00_prep_parameter_draws.R"
param_combo<-"00_prep_parameter_combo.R"
run_name_generator<-"00_prep_run_name.R"


#### 1a. run baseline parameters nursing care homes 
 
### set parameters
source(baseline_scenario)

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 1b. run baseline parameters for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 2a. run with high community prevalence for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevh" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 2b. run with high community prevalence for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
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
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 3a. run with low community prevalence for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevl" 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 3b. run with low community prevalence for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
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
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 4a. run with mean R0a=1 for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## R0a
scenario_beta<-"change_R0"
# set value if change_R0
if(scenario_beta=="change_R0"){
  changed_R0_a<-1# change R0 pathway a (end up symptomatic)
  changed_mR0_b<-0.5 # multiply by this to get R0 pathway b (stay asymptomatic), baseline is 0.5
}

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 4b. run with mean R0a=1 for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## R0a
scenario_beta<-"change_R0"
# set value if change_R0
if(scenario_beta=="change_R0"){
  changed_R0_a<-1# change R0 pathway a (end up symptomatic)
  changed_mR0_b<-0.5 # multiply by this to get R0 pathway b (stay asymptomatic), baseline is 0.5
}

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 5a. run with mean R0a=3 for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## R0a
scenario_beta<-"change_R0"
# set value if change_R0
if(scenario_beta=="change_R0"){
  changed_R0_a<-3# change R0 pathway a (end up symptomatic)
  changed_mR0_b<-0.5 # multiply by this to get R0 pathway b (stay asymptomatic), baseline is 0.5
}

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 5b. run with mean R0a=3 for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## R0a
scenario_beta<-"change_R0"
# set value if change_R0
if(scenario_beta=="change_R0"){
  changed_R0_a<-3# change R0 pathway a (end up symptomatic)
  changed_mR0_b<-0.5 # multiply by this to get R0 pathway b (stay asymptomatic), baseline is 0.5
}

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 6a. run with no visitors for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 6b. run with no visitors for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 7a. run with low community prevalence no visitors nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevl" 
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 7b. run with low community prevalence no visitors residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevl" 
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 8a. run with high community prevalence no visitors nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevh" 
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 8b. run with high community prevalence no visitors residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevh" 
## visitors
scenario_v<-"N" #scenario without visitors

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 9a. run with no importations from hospital for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 9b. run with no importations from hospital for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 10a. run with low community prevalence no importations from hospital nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevl" 
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 10b. run with low community prevalence no importations from hospital residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevl" 
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 11a. run with high community prevalence no importations from hospital nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevh" 
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 11b. run with high community prevalence no importations from hospital residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevh" 
## hospital infectious importations
scenario_h_inf_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 12a. run with no staff working at another LTCF for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 12b. run with no staff working at another LTCF for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 13a. run with low community prevalence no staff working at another LTCF nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevl" 
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 13b. run with low community prevalence no staff working at another LTCF residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevl" 
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 14a. run with high community prevalence no staff working at another LTCF nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevh" 
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 14b. run with high community prevalence no staff working at another LTCF residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevh" 
## variations in the proportion of staff working at different locations
scenario_staff_other_LTCF<-"change_p_working_another_LTCF"
# set value if change_p_working_another_LTCF
if(scenario_staff_other_LTCF=="change_p_working_another_LTCF"){changed_p_working_another_LTCF<-0} 

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 15a. run with no staff importations for nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 15b. run with no staff importations for residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 16a. run with low community prevalence no staff importations nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevl" 
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 16b. run with low community prevalence no staff importations residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevl" 
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 17a. run with high community prevalence no staff importations nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## community prevalence
scenario_community_prev<-"prevh" 
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 17b. run with high community prevalence no staff importations residential care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## residential LTCF
scenario_LTCF<-"res"
## community prevalence
scenario_community_prev<-"prevh" 
## no importations from staff 
scenario_staff_imp<-"N"

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 18. run with LFD nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## variations of p_fn and p_fn_h 
scenario_p_fn<-"change_p_fn"
# set values if scenario_p_fn=="change_p_fn"
if(scenario_p_fn=="change_p_fn"){
  changed_p_fn<-0.3
  changed_p_fn_h<-0.1} 
## days before isolation for those with symptoms or testing positive
scenario_delay_isolation<-"change"
# set value if scenario_delay_isolation=="change"
if(scenario_delay_isolation=="change"){changed_delay_isolation<-0.25
changed_delay_isolation_c<-1} #changes delay_isolation to this value

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 19. run with delay isolation 0.25 days nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## days before isolation for those with symptoms or testing positive
scenario_delay_isolation<-"change"
# set value if scenario_delay_isolation=="change"
if(scenario_delay_isolation=="change"){changed_delay_isolation<-0.25
changed_delay_isolation_c<-0.25} #changes delay_isolation to this value

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 20. run with p_i 0.95 and m_i 0.05 nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## p_i
scenario_p_i<-"change_p_i"
# set value if change_p_i
if(scenario_p_i=="change_p_i"){changed_p_i<-0.95} #changes p_i to this value
## m_i
scenario_m_i<-"change_m_i"
# set value if change_m_i
if(scenario_m_i=="change_m_i"){changed_m_i<-0.05} #changes m_i to this value

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))



#### 21. run with beta2 0.25 nursing care homes

### set parameters
source(baseline_scenario)

### changes from baseline
## changing all betas when >=1 resident isolated or staff are absent in LTCF
scenario_beta2<-"change_beta2"
# set value if change_beta2
if(scenario_beta2=="change_beta2"){
  changed_m_beta2<-0.25
}

### run name
source(run_name_generator)

### generate parameter set
source(data_input)
source(params)
source(param_draws)
# write parameter set before combo
write.csv(data.frame(theta_matrix_1),file = paste0(Output_params,run_name,"_params_before_combo.csv",sep=""))
# generate combination parameters
source(param_combo)
# aggregate theta matrix
theta_matrix<-rbind(theta_matrix_1,theta_matrix_combo)
# write parameter set after combo
write.csv(data.frame(theta_matrix),file = paste0(Output_params,run_name,"_params.csv",sep=""))