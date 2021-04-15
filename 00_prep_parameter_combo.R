# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to combine parameters



### COMBINATION PARAMETERS

# update underlying parameters
delay_to_isolation_nc<-as.numeric(theta_matrix_1["delay_to_isolation_nc",])
delay_to_isolation_c<-as.numeric(theta_matrix_1["delay_to_isolation_c",])
d_pc_inf<-as.numeric(theta_matrix_1["d_pc_inf",])
d_c_inf<-as.numeric(theta_matrix_1["d_c_inf",])

# delay from start of pre symptomatic state to isolation 
delay_to_isolation_pc <- rep(NA, n.sim)
for(i in 1:length(delay_to_isolation_nc)){
  if(delay_to_isolation_nc[i]>=(d_pc_inf[i]+delay_to_isolation_c[i])){
    delay_to_isolation_pc[i] <- (d_pc_inf[i]+delay_to_isolation_c[i]) # CAP DELAY TO ISOLATION PC (should be no longer than time spent infectious pc + duration to isolation if clinical)
  } else if(delay_to_isolation_nc[i]<(d_pc_inf[i]+delay_to_isolation_c[i])){
    delay_to_isolation_pc[i] = delay_to_isolation_nc[i] 
  }
}

# delay from start of asymptomatic state to isolation 
delay_to_isolation_a <- delay_to_isolation_nc #asymptomatic

# duration of pre-clinical infectious period isolated
d_pc_inf_i <-rep(NA, n.sim)
for(i in 1:length(d_pc_inf_i)){
  if((d_pc_inf[i]-delay_to_isolation_pc[i])<=0){
    d_pc_inf_i[i] <- 0
  } else if((d_pc_inf[i]-delay_to_isolation_pc[i])>0){
    d_pc_inf_i[i] = d_pc_inf[i]-delay_to_isolation_pc[i]#(pathway l1)
  }
}

# duration of clinical high infectious period before being isolated 
d_ch_inf_pi_l1<-rep(NA, n.sim)
for(i in 1:length(d_ch_inf_pi_l1)){
  if((delay_to_isolation_pc[i]-d_pc_inf[i])<=0){
    d_ch_inf_pi_l1[i] <- 0
  } else if((delay_to_isolation_pc[i]-d_pc_inf[i])>0){
    d_ch_inf_pi_l1[i] = delay_to_isolation_pc[i]-d_pc_inf[i]#(pathway l1)
  }
}

# duration of clinical high infectious period isolated
d_ch_inf_i<-rep(NA, n.sim)
for(i in 1:length(d_ch_inf_i)){
  if(((d_c_inf[i]/2)-delay_to_isolation_c[i])<=0){
    d_ch_inf_i[i] <- 0
  } else if(((d_c_inf[i]/2)-delay_to_isolation_c[i])>0){
    d_ch_inf_i[i] = ((d_c_inf[i]/2)-delay_to_isolation_c[i])
  }
}

# duration of clinical high infectious period isolated l1
d_ch_inf_i_l1<-rep(NA, n.sim)
for(i in 1:length(d_ch_inf_i_l1)){
  if(delay_to_isolation_c[i]-d_pc_inf[i]<=0){
    d_ch_inf_i_l1[i] <- 0
  } else if (((d_c_inf[i]/2)-(delay_to_isolation_c[i]-d_pc_inf[i]))<=0){
    d_ch_inf_i_l1[i] <- 0
  }else{
    d_ch_inf_i_l1[i] = ((d_c_inf[i]/2)-(delay_to_isolation_c[i]-d_pc_inf[i]))#(pathway l1)
  }
}

# duration of asymptomatic infectous period isolated
d_a_inf_i<-rep(NA, n.sim)
for(i in 1:length(d_a_inf_i)){
  if(((d_pc_inf[i]+d_c_inf[i])-delay_to_isolation_a[i])<=0){
    d_a_inf_i[i] <- 0
  } else if(((d_pc_inf[i]+d_c_inf[i])-delay_to_isolation_a[i])>0){
    d_a_inf_i[i] = ((d_pc_inf[i]+d_c_inf[i])-delay_to_isolation_a[i])
  }
}

# duration of clinical low infectious period before being isolated l2
d_cl_inf_pi_l2<-rep(NA, n.sim)
for(i in 1:length(d_cl_inf_pi_l2)){
  if((delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2))<=0){
    d_cl_inf_pi_l2[i] <- 0
  } else if((delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2))>0){
    d_cl_inf_pi_l2[i] = (delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2))
  }
}

# duration of clinical low infectious period before being isolated l4
d_cl_inf_pi_l4<-rep(NA, n.sim)
for(i in 1:length(d_cl_inf_pi_l4)){
  if((delay_to_isolation_c[i]-(d_c_inf[i]/2))<=0){
    d_cl_inf_pi_l4[i] <- 0
  } else if((delay_to_isolation_c[i]-(d_c_inf[i]/2))>0){
    d_cl_inf_pi_l4[i] = (delay_to_isolation_c[i]-(d_c_inf[i]/2))
  }
}

# duration of clinical low infectious period isolated l2
d_cl_inf_i_l2<-rep(NA, n.sim)
for(i in 1:length(d_cl_inf_i_l2)){
  if((delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2))<=0){
    d_cl_inf_i_l2[i] <- 0
  } else if(((d_c_inf[i]/2)-(delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2)))<=0){
    d_cl_inf_i_l2[i] <- 0
  } else {
    d_cl_inf_i_l2[i] = ((d_c_inf[i]/2)-(delay_to_isolation_pc[i]-d_pc_inf[i]-(d_c_inf[i]/2)))
  }
}

# duration of clinical low infectious period isolated l4
d_cl_inf_i_l4<-rep(NA, n.sim)
for(i in 1:length(d_cl_inf_i_l4)){
  if((delay_to_isolation_c[i]-(d_c_inf[i]/2))<=0){
    d_cl_inf_i_l4[i] <- 0
  } else if(((d_c_inf[i]/2)-(delay_to_isolation_c[i]-(d_c_inf[i]/2)))<=0)
  {
    d_cl_inf_i_l4[i] <- 0
  } else {
    d_cl_inf_i_l4[i] = ((d_c_inf[i]/2)-(delay_to_isolation_c[i]-(d_c_inf[i]/2)))
  }
}

theta_matrix_combo<- rbind(delay_to_isolation_pc,
                           delay_to_isolation_a,
                           d_pc_inf_i,
                           d_ch_inf_pi_l1,
                           d_ch_inf_i,
                           d_ch_inf_i_l1,
                           d_a_inf_i,
                           d_cl_inf_pi_l2,
                           d_cl_inf_pi_l4,
                           d_cl_inf_i_l2,
                           d_cl_inf_i_l4)