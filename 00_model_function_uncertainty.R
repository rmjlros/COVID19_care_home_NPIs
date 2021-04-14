# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script that defines percentiles_model function, which runs model and gives p(outbreak at 30 days), p(large outbreak at 90 days) for each parameter set. The number of  parameter sets are defined by N_parameter_set argument, and the number  of simulations to run per parameter set are defined by N_sims_per_param_set argument.


percentiles_model<-function(N_param_set, N_sims_per_param_set){
  
  ## which parameter set to use 
  to_repeat<-theta_matrix_2[,N_param_set]
  a<-matrix(rep(to_repeat, each=N_sims_per_param_set), ncol = N_sims_per_param_set,  byrow=TRUE)
  row.names(a)<-row.names(theta_matrix_2)
  theta_matrix<-a
  n.sim<-N_sims_per_param_set
  
  ### define stochastic model, for use with euler.sim, see ?euler.sim
  source(transmission_model)
  
  ### define sampling random point observations from model incidence. The simulator of the observed process,conditional   on the unobserved state
  rmeas.c <- '
  obs = rpois(rho * NewIc); //random draw from a Poisson distribution with mean rho*NewIc, and stores it in the variable   obs
  '
  
  ### define point observation probability density. 
  dmeas.c <- '
  lik = dpois(obs, rho * NewIc, give_log);
  '
  
  ### time step
  timestep<- 1 # days
  
  ### variables
  state_names<-c("S", "E", "Ipcpi", "Ipc", "Ia", "Iapi", "Ipci", "Iai", 
                 "Ichpi1", "Ichpi2", "Ichpi3", "Ichpi4",
                 "Ich","Ichi1", "Ichi2", "Ichi3",
                 "Iclpi1","Iclpi2","Icli1","Icli2","Icli3","Icl",
                 "R",
                 "Ss", "Es", "Ipcpis", "Ipcs", "Ias", "Iapis", 
                 "Ichpi1s","Ichpi2s", "As", "Rs",
                 "Ss2", "Es2", "Ipcpis2", "Ipcs2", "Ias2", "Iapis2", 
                 "Ichpi1s2","Ichpi2s2", "As2", "Rs2")
  accum_vars<-c("NewIc","NewIpcIa", "NewE", "NewR", 
                "NewAs", "NewIpcsIas", "NewEs", "NewRs",
                "NewAs2", "NewIpcsIas2", "NewEs2", "NewRs2",
                "totalExits", 
                "totalDeaths", "totalDeathsClinical",
                "SDeaths", "EDeaths", "IpcpiDeaths", "IpcDeaths", "IaDeaths", "IapiDeaths", "IpciDeaths", "IaiDeaths", 
                "Ichpi1Deaths", "Ichpi2Deaths", "Ichpi3Deaths", "Ichpi4Deaths",
                "IchDeaths","Ichi1Deaths", "Ichi2Deaths", "Ichi3Deaths",
                "Iclpi1Deaths","Iclpi2Deaths","Icli1Deaths","Icli2Deaths","Icli3Deaths","IclDeaths",
                "RDeaths",
                "totalHospitalExits", "totalHospitalExitsInfected",
                "totalHospitalExitsInfectious","totalHospitalExitsClinical",
                "SHospitalExits", "EHospitalExits",  
                "IpcpiHospitalExits", "IpcHospitalExits", "IaHospitalExits", "IapiHospitalExits", 
                "IpciHospitalExits", "IaiHospitalExits", 
                "Ichpi1HospitalExits", "Ichpi2HospitalExits", "Ichpi3HospitalExits", "Ichpi4HospitalExits",
                "IchHospitalExits","Ichi1HospitalExits", "Ichi2HospitalExits", "Ichi3HospitalExits",
                "Iclpi1HospitalExits","Iclpi2HospitalExits","Icli1HospitalExits",
                "Icli2HospitalExits","Icli3HospitalExits",
                "IclHospitalExits",
                "RHospitalExits",
                "totalEntries",
                "totalEntries_non_hc",
                "totalEntries_hc",
                "totalEntriesInfected", "totalEntriesInfectious","totalEntriesClinical",
                "SEntries", "EEntries", "IpcpiEntries", "IpcEntries", "IaEntries", "IapiEntries", 
                "IpciEntries", "IaiEntries", 
                "Ichpi1Entries", "Ichpi2Entries", "Ichpi3Entries", "Ichpi4Entries",
                "IchEntries","Ichi1Entries", "Ichi2Entries", "Ichi3Entries",
                "Iclpi1Entries","Iclpi2Entries","Icli1Entries","Icli2Entries","Icli3Entries","IclEntries",
                "REntries",
                "S2Entries", "S1Exits", 
                "S1Entries" , "S2Exits",
                "TestRes","TestStaff1","TestStaff2",
                "Isolated") 
  
  # N individuals in each compartment at the start of simulation
  source(initialiser)
  
  ### simulation of stochastic model
  model.sim <- simulate(times=seq(from=1, to=100, by=timestep), 
                        t0=1,
                        rmeasure = Csnippet(rmeas.c),
                        rinit= Csnippet(rinit),
                        rprocess = euler(step.fun = Csnippet(SIS.sim.c), delta.t = 1),
                        statenames = c(state_names,accum_vars),
                        obsnames="obs",
                        params = theta_matrix, 
                        paramnames = rownames(theta_matrix),
                        accumvars = accum_vars,
                        nsim=1, seed=121008, # 1 sim for each parameter set
                        format = "data.frame")
  
  ## simple outputs
  # get all Ic residents
  model.sim$InfC_r<-NA
  model.sim$InfC_r<-model.sim$Ichpi1+model.sim$Ichpi2+model.sim$Ichpi3+model.sim$Ichpi4+model.sim$Ich+model.sim$Ichi1+model.sim$Ichi2+model.sim$Ichi3+model.sim$Iclpi1+model.sim$Iclpi2+model.sim$Icli1+model.sim$Icli2+model.sim$Icli3+model.sim$Icl
  # get incidence Ic by calculating the difference in subsequent rows by scenario and .id
  model.sim<-arrange(model.sim, .id, time)
  model.sim<-model.sim %>%
    group_by(.id) %>%
    mutate(new_InfC_r = InfC_r - lag(InfC_r)) # get incidence by calculating the difference in subsequent rows
  model.sim$new_InfC_r<-(abs(model.sim$new_InfC_r)+model.sim$new_InfC_r)/2 # convert all negatives into zero
  model.sim$new_InfC_r[is.na(model.sim$new_InfC_r)] <- 0 #convert NAs into zero
  # cumulative sum of new Ic infections
  model.sim<-model.sim %>% group_by(.id) %>% mutate(cumsum_new_InfC_r=cumsum(new_InfC_r))
  # set threshold of cases
  n_threshold_outbreak<-0
  n_threshold_large_outbreak<-9
  # number of simulations with X or more Ic, probability of X or more Ic
  df_p_InfC_r<-model.sim%>%group_by(time)%>%
    summarise(n.sims=sum(cumsum_new_InfC_r>=0),
              n.InfC_r=median(cumsum_new_InfC_r),
              n.InfC_r_O=sum(cumsum_new_InfC_r>n_threshold_outbreak),
              p.InfC_r_O=sum(cumsum_new_InfC_r>n_threshold_outbreak)/sum(cumsum_new_InfC_r>=0),
              n.InfC_r_LO=sum(cumsum_new_InfC_r>n_threshold_large_outbreak),
              p.InfC_r_LO=sum(cumsum_new_InfC_r>n_threshold_large_outbreak)/sum(cumsum_new_InfC_r>=0))
  # add column with parameter set
  df_p_InfC_r$param.set<-N_param_set
  df_p_InfC_r
}
