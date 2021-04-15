# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to run model using parameter sets outputted in "01_run_parameter_sets.R". Outputs produced are comparisons of other IPC interventions besides testing.


#### load packages
require(dplyr)
require(data.table)
require(pomp)


#### paths
Output_params <- "Outputs/Params/"
Output_model_IPC_other <- "Outputs/Model/IPC_other_strategies/"
transmission_model <- "00_model.R"
initialiser <- "00_initialiser.R"
param_combo <- "00_prep_parameter_combo.R"
model_function_uncertainty <- "00_model_function_uncertainty.R"


#### model function to run model with uncertainty in outputs
source(model_function_uncertainty)



######### No visitors #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no visitors
theta_matrix_1["n_V", ] <- 0
run_name <- gsub("_visprep_", "_visN_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### Delay to isolation 0.25 days #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# delay to isolation
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic0.25_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_delay_to_isolation_c <- theta_matrix_1_b["delay_to_isolation_c", ]
theta_matrix_1["delay_to_isolation_c", ] <- row_delay_to_isolation_c
run_name <- gsub("dibase", "di0.25dic0.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### isolation of 95% of residents  95% effective #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# p_i and m_i
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pi0.95_mi0.05_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_p_i <- theta_matrix_1_b["p_i", ]
theta_matrix_1["p_i", ] <- row_p_i
row_m_i <- theta_matrix_1_b["m_i", ]
theta_matrix_1["m_i", ] <- row_m_i
run_name <- gsub("pibase_mibase", "pi0.95_mi0.05", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### betas reduced by 75% #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# mbeta
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b20.25_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_m_beta2 <- theta_matrix_1_b["m_beta2", ]
theta_matrix_1["m_beta2", ] <- row_m_beta2
run_name <- gsub("b2base", "b20.25", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### staff work at only 1 LTCF #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# staff working at another LTCF
theta_matrix_1["p_working_another_LTCF", ] <- 0
run_name <- gsub("_p2LTCFb_", "_p2LTCF0_", run_name)

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### 50% immune at start simulations #########

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_IPC_other", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# 50% recovered
n_R_res <- round((theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) * 0.5)
n_S_res <- (theta_matrix_1["N_R", 1] + theta_matrix_1["N_S", 1]) - n_R_res
theta_matrix_1["N_R", ] <- n_R_res
theta_matrix_1["N_S", ] <- n_S_res
run_name <- paste0(run_name, "_0.5R")

# update parameter matrix
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix

# define number of parameter sets and simulations to run
if (LTCF_type == "nh") {
  n.sim <- 700
} else if (LTCF_type == "res") {
  n.sim <- 800
} else {
  print("error")
}

# run model
l_p_InfC_r <- lapply(1:n.sim, FUN = percentiles_model, N_sims_per_param_set = 600)

# save outputs
df_p_InfC_r <- rbindlist(l_p_InfC_r)
file_save <- paste0(Output_model_IPC_other, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)
