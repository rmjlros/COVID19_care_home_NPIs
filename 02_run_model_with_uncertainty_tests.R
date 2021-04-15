# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to run model using parameter sets outputted in "01_run_parameter_sets.R". Outputs produced are test comparisons.


#### load packages
require(dplyr)
require(data.table)
require(pomp)


#### paths
Output_params <- "Outputs/Params/"
Output_model_tests <- "Outputs/Model/Testing_strategies/"
transmission_model <- "00_model.R"
initialiser <- "00_initialiser.R"
param_combo <- "00_prep_parameter_combo.R"
model_function_uncertainty <- "00_model_function_uncertainty.R"


#### model function to run model with uncertainty in outputs
source(model_function_uncertainty)


######### No testing #########

#### 1a. baseline parameters, nursing care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes, no testing

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# no testing
theta_matrix_1["p_tnc", ] <- 0
theta_matrix_1["p_tc", ] <- 0
theta_matrix_1["p_tncs", ] <- 0
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ptncbase", "ptnc0", run_name)
run_name <- gsub("ptcbase", "ptc0", run_name)
run_name <- gsub("ptncsbase", "ptncs0", run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



######### PCR #########

###### PCR 1xday R, PCR 1xday S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xmonth R, PCR 1xday S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xmonth R, PCR 3xweek S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xweek R, PCR 3xweek S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 7 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xmonth R, PCR 2xweek S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xday S only

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### PCR 1xday R only

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
n.sim <- 1500
source(param_combo) # generate combination parameters
theta_matrix_combo <- data.frame(theta_matrix_combo)
theta_matrix_2 <- rbind(theta_matrix_1, theta_matrix_combo) # aggregate theta matrix
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)


######### LFD #########

###### LFD 1xday R, LFD 1xday S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### LFD 1xmonth R, LFD 1xday S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 0 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### LFD 1xmonth R, LFD 3xweek S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 2.3 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### LFD 1xmonth R, LFD 2xweek S

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
freq_staff <- 3.5 # 0 means daily
freq_res <- 28 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### LFD 1xday S only

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tnc", ] <- 0
run_name <- gsub("ptncbase", "ptnc0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



###### LFD 1xday R only

#### 1a. baseline parameters, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 1b. baseline parameters, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2a. low community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 2b. low community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3a. high community prev, nursing care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "nh"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)



#### 3b. high community prev, residential care homes

# remove everything except these objects from environment
rm(list = setdiff(ls(), c("percentiles_model", "Output_params", "Output_model_tests", "transmission_model", "initialiser", "param_combo", "model_function_uncertainty")))

# define LTCF_type
LTCF_type <- "res"

# read in parameter set
run_name <- "_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim"
theta_matrix_1 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params_before_combo.csv", sep = ""), row.names = 1)
theta_matrix_2 <- read.csv(file = paste0(Output_params, LTCF_type, run_name, "_params.csv", sep = ""), row.names = 1)

# LFD test
theta_matrix_1_b <- read.csv(file = paste0(Output_params, "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_di0.25dic1_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfn0.3pfnh0.1_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim_params_before_combo.csv", sep = ""), row.names = 1)
row_delay_to_isolation_nc <- theta_matrix_1_b["delay_to_isolation_nc", ]
theta_matrix_1["delay_to_isolation_nc", ] <- row_delay_to_isolation_nc
row_p_fn <- theta_matrix_1_b["p_fn", ]
theta_matrix_1["p_fn", ] <- row_p_fn
run_name <- gsub("dibase", "di0", run_name)
run_name <- gsub("pfnbase", "pfn0.3pfnh0.1", run_name)

# change frequency test
theta_matrix_1["p_tncs", ] <- 0
run_name <- gsub("ptncsbase", "ptncs0", run_name)
freq_staff <- 0 # 0 means daily
freq_res <- 0 # 0 means daily
theta_matrix_1["tnc_period", ] <- freq_res
theta_matrix_1["tncs_period", ] <- freq_staff
run_name <- gsub("ftncbase", paste0("ftnc", freq_res), run_name)
run_name <- gsub("ftncsbase", paste0("ftncs", freq_staff), run_name)

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
file_save <- paste0(Output_model_tests, LTCF_type, run_name, ".csv", sep = "")
write.csv(df_p_InfC_r, file_save, row.names = FALSE)
