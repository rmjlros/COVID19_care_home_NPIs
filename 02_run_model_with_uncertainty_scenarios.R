# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to run model using parameter sets outputted in "01_run_parameter_sets.R". Outputs produced are scenario comparisons


#### load packages
require(dplyr)
require(data.table)
require(pomp)


#### paths
Output_params <- "Outputs/Params/"
Output_model <- "Outputs/Model/"
transmission_model <- "00_model.R"
initialiser <- "00_initialiser.R"
param_combo <- "00_prep_parameter_combo.R"
model_function_uncertainty <- "00_model_function_uncertainty.R"


#### model function to run model with uncertainty in outputs
source(model_function_uncertainty)


#### 1a. run baseline parameters nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. run baseline parameters residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. run high community prevalence nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. run high community prevalence residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. run low community prevalence nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. run low community prevalence residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 4a. run R0a1 nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0a1mR0b0.5_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 4b. run R0a1 residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0a1mR0b0.5_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 5a. run R0a3 nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0a3mR0b0.5_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 5b. run R0a3 residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0a3mR0b0.5_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 6a. run no vsitors nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 6b. run no visitors residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 7a. run no visitors low community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 7b. run no visitors low community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 8a. run no visitors high community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 8b. run no visitors high community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visN_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 9a. run no hospital importation nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 9b. run no hospital importation residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 10a. run no hospital importation low community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 10b. run no hospital importation low community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 11a. run no hospital importation high community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 11b. run no hospital importation high community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpN_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 12a. run no staff working at LTCF2 nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 12b. run no staff working at LTCF2 residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 13a. run no staff working at LTCF2 low community prevalence nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 13b. run no staff working at LTCF2 low community prevalence residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 14a. run no staff working at LTCF2 high community prevalence nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 14b. run no staff working at LTCF2 high community prevalence residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCF0_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)


#### 15a. run no staff importation nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 15b. run no staff importation residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 16a. run no staff importation low community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 16b. run no staff importation low community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 17a. run no staff importation high community prev nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "nh"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 17b. run no staff importation high community prev residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

## define LTCF_type
LTCF_type <- "res"

## read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpN_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

## define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

## run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

## save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)
