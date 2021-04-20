# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to plot Figure 4



### PREP

# remove all else
rm(list=ls(all=TRUE))

# packages
require(ggplot2)
require(gridExtra)
require(patchwork)
require(dplyr)
library(reshape2)

# paths
Output<-"Outputs/Model/Testing_strategies/"
Plots<-"Plots/"


### SCENARIO

plot_type<-"testing"
relative_effectiveness<-"Y"
R0_scenario<-2


### READ IN MODEL OUTPUTS

all_dfs<-list()

a<-list.files(Output)

for(i in 1:length(a)){
  all_dfs[[i]]<-read.csv(paste0(Output,a[i]))
  all_dfs[[i]]$scenario<-a[i]
}

outputs<-do.call("rbind", all_dfs)

# make df smaller
outputs<-outputs%>%filter(time==30|time==90)%>%select(c("time","p.InfC_r_O", "p.InfC_r_LO","param.set", "scenario"))


### LABEL SCENARIO CHARACTERISTICS

# adding LTCF type
outputs$LTCF_type<-outputs$scenario
outputs[grep(outputs$LTCF_type, pattern = "nh_"),]$LTCF_type<-"nursing care home"
outputs[grep(outputs$LTCF_type, pattern = "res_"),]$LTCF_type<-"residential care home"

#-- R0
outputs$R0<-outputs$scenario
outputs[grep(outputs$R0, pattern = "R0base"),]$R0<-"R0a mean 2"
outputs[grep(outputs$R0, pattern = "R0a3"),]$R0<-"R0a mean 3"
outputs[grep(outputs$R0, pattern = "R0a1"),]$R0<-"R0a mean 1"

#-- community prevalence
outputs$cprev<-outputs$scenario
outputs[grep(outputs$cprev, pattern = "_prevm_"),]$cprev<-"medium community prevalence (baseline)"
outputs[grep(outputs$cprev, pattern = "_prevl_"),]$cprev<-"low community prevalence"
outputs[grep(outputs$cprev, pattern = "_prevh_"),]$cprev<-"high community prevalence"

## Which R0 to select
if(R0_scenario==2){
  outputs_selected_R0<-outputs%>%filter(R0=="R0a mean 2")
}
if(R0_scenario==1){
  outputs_selected_R0<-outputs%>%filter(R0=="R0a mean 1")
}
if(R0_scenario==3){
  outputs_selected_R0<-outputs%>%filter(R0=="R0a mean 3")
}
if (R0_scenario=="all"){
  outputs_selected_R0<-outputs%>%filter(cprev=="medium community prevalence (baseline)")
}

## p_more_than_0_residents_Ic_30d
p_more_than_0_residents_Ic_30d<-outputs_selected_R0%>%filter(time==30)%>%select(c("time","p.InfC_r_O", "param.set", "scenario", "LTCF_type", "R0", "cprev"))

## p_more_than_9_residents_Ic_90d
p_more_than_9_residents_Ic_90d<-outputs_selected_R0%>%filter(time==90)%>%select(c("time","p.InfC_r_LO", "param.set", "scenario","LTCF_type", "R0", "cprev"))


### RELEVEL FACTORS FOR PLOTS AND RENAME INTERVENTIONS

if(plot_type=="testing"){
  
  ## outbreaks
  
  p_more_than_0_residents_Ic_30d$interventions<-as.character(p_more_than_0_residents_Ic_30d$scenario)
  # table(p_more_than_0_residents_Ic_30d$interventions)
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase"),]$interventions<-"PCR S 1xweek, R 1xmonth (baseline)"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptnc0_ptc0_ptncs0_ftncbase_ftcbase_ftncsbase_taH_pfnbase"),]$interventions<-"no testing"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs3.5_taH_pfnbase"),]$interventions<-"PCR S 2xweek, R 1xmonth"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc7_ftcbase_ftncs2.3_taH_pfnbase"),]$interventions<-"PCR S 3xweek, R 1xweek"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs2.3_taH_pfnbase"),]$interventions<-"PCR S 3xweek, R 1xmonth"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptnc0_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncs0_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR R 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday, R 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday, R 1xmonth"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncs0_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD R 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday, R 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs3.5_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 2xweek, R 1xmonth"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs2.3_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 3xweek, R 1xmonth"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptnc0_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday"
  p_more_than_0_residents_Ic_30d[grep(p_more_than_0_residents_Ic_30d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday, R 1xmonth"
  
  # calculate difference from no testing or from baseline
  p_more_than_0_residents_Ic_30d_notesting<-p_more_than_0_residents_Ic_30d%>%filter(interventions=="no testing")
  p_more_than_0_residents_Ic_30d_notesting$p.InfC_r_O_notesting<-p_more_than_0_residents_Ic_30d_notesting$p.InfC_r_O
  p_more_than_0_residents_Ic_30d_notesting<-p_more_than_0_residents_Ic_30d_notesting[,c("param.set","LTCF_type", "R0", "cprev","p.InfC_r_O_notesting")]
  p_more_than_0_residents_Ic_30d<-merge(p_more_than_0_residents_Ic_30d,p_more_than_0_residents_Ic_30d_notesting, by = c("param.set","LTCF_type", "R0", "cprev")) 
  if(relative_effectiveness=="N"){
    p_more_than_0_residents_Ic_30d$dif_p.InfC_r_O<-p_more_than_0_residents_Ic_30d$p.InfC_r_O_notesting-p_more_than_0_residents_Ic_30d$p.InfC_r_O
  }
  if(relative_effectiveness=="Y"){
    p_more_than_0_residents_Ic_30d$dif_p.InfC_r_O<-1-(p_more_than_0_residents_Ic_30d$p.InfC_r_O/p_more_than_0_residents_Ic_30d$p.InfC_r_O_notesting)
  }
  
  # remove baselines of zero
  if(relative_effectiveness=="Y"){
    p_more_than_0_residents_Ic_30d<-p_more_than_0_residents_Ic_30d%>%filter(p.InfC_r_O_notesting>0)
  }
  
  # only looking at one type of LTCF per plot
  p_more_than_0_residents_Ic_30d_nh<-p_more_than_0_residents_Ic_30d%>%filter(LTCF_type=="nursing care home")
  p_more_than_0_residents_Ic_30d_res<-p_more_than_0_residents_Ic_30d%>%filter(LTCF_type=="residential care home")
  
  
  ## large outbreaks
  
  # table(p_more_than_9_residents_Ic_90d$interventions) 
  p_more_than_9_residents_Ic_90d$interventions<-as.character(p_more_than_9_residents_Ic_90d$scenario)
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase"),]$interventions<-"PCR S 1xweek, R 1xmonth (baseline)"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptnc0_ptc0_ptncs0_ftncbase_ftcbase_ftncsbase_taH_pfnbase"),]$interventions<-"no testing"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs3.5_taH_pfnbase"),]$interventions<-"PCR S 2xweek, R 1xmonth"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc7_ftcbase_ftncs2.3_taH_pfnbase"),]$interventions<-"PCR S 3xweek, R 1xweek"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs2.3_taH_pfnbase"),]$interventions<-"PCR S 3xweek, R 1xmonth"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptnc0_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncs0_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR R 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday, R 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs0_taH_pfnbase"),]$interventions<-"PCR S 1xday, R 1xmonth"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncs0_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD R 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday, R 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs3.5_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 2xweek, R 1xmonth"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs2.3_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 3xweek, R 1xmonth"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptnc0_ptcbase_ptncsbase_ftnc0_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday"
  p_more_than_9_residents_Ic_90d[grep(p_more_than_9_residents_Ic_90d$interventions, pattern = "ptncbase_ptcbase_ptncsbase_ftnc28_ftcbase_ftncs0_taH_pfn0.3pfnh0.1"),]$interventions<-"LFD S 1xday, R 1xmonth"
  
  
  # calculate difference from no testing or from baseline
  p_more_than_9_residents_Ic_90d_notesting<-p_more_than_9_residents_Ic_90d%>%filter(interventions=="no testing")
  p_more_than_9_residents_Ic_90d_notesting$p.InfC_r_LO_notesting<-p_more_than_9_residents_Ic_90d_notesting$p.InfC_r_LO
  p_more_than_9_residents_Ic_90d_notesting<-p_more_than_9_residents_Ic_90d_notesting[,c("param.set","LTCF_type", "R0", "cprev","p.InfC_r_LO_notesting")]
  p_more_than_9_residents_Ic_90d<-merge(p_more_than_9_residents_Ic_90d,p_more_than_9_residents_Ic_90d_notesting, by = c("param.set","LTCF_type", "R0", "cprev")) 
  if(relative_effectiveness=="N"){
    p_more_than_9_residents_Ic_90d$dif_p.InfC_r_LO<-p_more_than_9_residents_Ic_90d$p.InfC_r_LO_notesting-p_more_than_9_residents_Ic_90d$p.InfC_r_LO
  }
  if(relative_effectiveness=="Y"){
    p_more_than_9_residents_Ic_90d$dif_p.InfC_r_LO<-1-(p_more_than_9_residents_Ic_90d$p.InfC_r_LO/p_more_than_9_residents_Ic_90d$p.InfC_r_LO_notesting)
  }
  
  # remove baselines of zero
  if(relative_effectiveness=="Y"){
    p_more_than_9_residents_Ic_90d<-p_more_than_9_residents_Ic_90d%>%filter(p.InfC_r_LO_notesting>0)
  }
  
  # only looking at one type of LTCF per plot
  p_more_than_9_residents_Ic_90d_nh<-p_more_than_9_residents_Ic_90d%>%filter(LTCF_type=="nursing care home")
  p_more_than_9_residents_Ic_90d_res<-p_more_than_9_residents_Ic_90d%>%filter(LTCF_type=="residential care home")
  
}


# community prevalence
if(R0_scenario!="all"){
  p_more_than_0_residents_Ic_30d_nh$cprev<-factor(p_more_than_0_residents_Ic_30d_nh$cprev, levels=c("low community prevalence",
                                                                                                    "medium community prevalence (baseline)",
                                                                                                    "high community prevalence"))
  p_more_than_9_residents_Ic_90d_nh$cprev<-factor(p_more_than_9_residents_Ic_90d_nh$cprev, levels=c("low community prevalence",
                                                                                                    "medium community prevalence (baseline)",
                                                                                                    "high community prevalence"))
  p_more_than_0_residents_Ic_30d_res$cprev<-factor(p_more_than_0_residents_Ic_30d_res$cprev, levels=c("low community prevalence",
                                                                                                      "medium community prevalence (baseline)",
                                                                                                      "high community prevalence"))
  p_more_than_9_residents_Ic_90d_res$cprev<-factor(p_more_than_9_residents_Ic_90d_res$cprev, levels=c("low community prevalence",
                                                                                                      "medium community prevalence (baseline)",
                                                                                                      "high community prevalence"))
}

# calculate medians and quantiles
p_more_than_0_residents_Ic_30d_nh_plot<-p_more_than_0_residents_Ic_30d_nh%>%group_by(LTCF_type, R0, cprev, interventions)%>%
  summarise(dif_p.InfC_r_O_median=quantile(dif_p.InfC_r_O, probs = 0.5),
            dif_p.InfC_r_O_UL75=quantile(dif_p.InfC_r_O, probs = 0.75),
            dif_p.InfC_r_O_UL95=quantile(dif_p.InfC_r_O, probs = 0.95),
            dif_p.InfC_r_O_LL25=quantile(dif_p.InfC_r_O, probs = 0.25),
            dif_p.InfC_r_O_LL05=quantile(dif_p.InfC_r_O, probs = 0.05))

p_more_than_0_residents_Ic_30d_res_plot<-p_more_than_0_residents_Ic_30d_res%>%group_by(LTCF_type, R0, cprev, interventions)%>%
  summarise(dif_p.InfC_r_O_median=quantile(dif_p.InfC_r_O, probs = 0.5),
            dif_p.InfC_r_O_UL75=quantile(dif_p.InfC_r_O, probs = 0.75),
            dif_p.InfC_r_O_UL95=quantile(dif_p.InfC_r_O, probs = 0.95),
            dif_p.InfC_r_O_LL25=quantile(dif_p.InfC_r_O, probs = 0.25),
            dif_p.InfC_r_O_LL05=quantile(dif_p.InfC_r_O, probs = 0.05))

p_more_than_9_residents_Ic_90d_nh_plot<-p_more_than_9_residents_Ic_90d_nh%>%group_by(LTCF_type, R0, cprev, interventions)%>%
  summarise(dif_p.InfC_r_LO_median=quantile(dif_p.InfC_r_LO, probs = 0.5),
            dif_p.InfC_r_LO_UL95=quantile(dif_p.InfC_r_LO, probs = 0.95),
            dif_p.InfC_r_LO_UL75=quantile(dif_p.InfC_r_LO, probs = 0.75),
            dif_p.InfC_r_LO_LL25=quantile(dif_p.InfC_r_LO, probs = 0.25),
            dif_p.InfC_r_LO_LL05=quantile(dif_p.InfC_r_LO, probs = 0.05))

p_more_than_9_residents_Ic_90d_res_plot<-p_more_than_9_residents_Ic_90d_res%>%group_by(LTCF_type, R0, cprev, interventions)%>%
  summarise(dif_p.InfC_r_LO_median=quantile(dif_p.InfC_r_LO, probs = 0.5),
            dif_p.InfC_r_LO_UL95=quantile(dif_p.InfC_r_LO, probs = 0.95),
            dif_p.InfC_r_LO_UL75=quantile(dif_p.InfC_r_LO, probs = 0.75),
            dif_p.InfC_r_LO_LL25=quantile(dif_p.InfC_r_LO, probs = 0.25),
            dif_p.InfC_r_LO_LL05=quantile(dif_p.InfC_r_LO, probs = 0.05))

## order interventions by least to most successful
# which variable to order by
if(R0_scenario=="all"){
  p_more_than_0_residents_Ic_30d_nh_plot$var_order<-p_more_than_0_residents_Ic_30d_nh_plot$R0
  p_more_than_0_residents_Ic_30d_res_plot$var_order<-p_more_than_0_residents_Ic_30d_res_plot$R0
  p_more_than_9_residents_Ic_90d_nh_plot$var_order<-p_more_than_9_residents_Ic_90d_nh_plot$R0
  p_more_than_9_residents_Ic_90d_res_plot$var_order<-p_more_than_9_residents_Ic_90d_res_plot$R0
  order_by<-"R0a mean 2"
}else{
  p_more_than_0_residents_Ic_30d_nh_plot$var_order<-p_more_than_0_residents_Ic_30d_nh_plot$cprev
  p_more_than_0_residents_Ic_30d_res_plot$var_order<-p_more_than_0_residents_Ic_30d_res_plot$cprev
  p_more_than_9_residents_Ic_90d_nh_plot$var_order<-p_more_than_9_residents_Ic_90d_nh_plot$cprev
  p_more_than_9_residents_Ic_90d_res_plot$var_order<-p_more_than_9_residents_Ic_90d_res_plot$cprev
  order_by<-"medium community prevalence (baseline)"
}
# order
ordered_int_df<-p_more_than_0_residents_Ic_30d_nh_plot%>%filter(var_order==order_by)%>%arrange(dif_p.InfC_r_O_median)
ordered_int<-ordered_int_df$interventions
p_more_than_0_residents_Ic_30d_nh_plot$interventions<-factor(p_more_than_0_residents_Ic_30d_nh_plot$interventions,
                                                             levels=ordered_int)
ordered_int_df<-p_more_than_0_residents_Ic_30d_res_plot%>%filter(var_order==order_by)%>%arrange(dif_p.InfC_r_O_median)
ordered_int<-ordered_int_df$interventions
p_more_than_0_residents_Ic_30d_res_plot$interventions<-factor(p_more_than_0_residents_Ic_30d_res_plot$interventions,
                                                              levels=ordered_int)
table(p_more_than_9_residents_Ic_90d_nh_plot$interventions)
ordered_int_df<-p_more_than_9_residents_Ic_90d_nh_plot%>%filter(var_order==order_by)%>%arrange(dif_p.InfC_r_LO_median)
ordered_int<-ordered_int_df$interventions
p_more_than_9_residents_Ic_90d_nh_plot$interventions<-factor(p_more_than_9_residents_Ic_90d_nh_plot$interventions,
                                                             levels=ordered_int)
ordered_int_df<-p_more_than_9_residents_Ic_90d_res_plot%>%filter(var_order==order_by)%>%arrange(dif_p.InfC_r_LO_median)
ordered_int<-ordered_int_df$interventions
p_more_than_9_residents_Ic_90d_res_plot$interventions<-factor(p_more_than_9_residents_Ic_90d_res_plot$interventions,
                                                              levels=ordered_int)

if(plot_type=="testing"){
  # remove "no testing"
  p_more_than_0_residents_Ic_30d_nh_plot<-p_more_than_0_residents_Ic_30d_nh_plot%>%filter(interventions!="no testing")
  p_more_than_0_residents_Ic_30d_res_plot<-p_more_than_0_residents_Ic_30d_res_plot%>%filter(interventions!="no testing")
  p_more_than_9_residents_Ic_90d_nh_plot<-p_more_than_9_residents_Ic_90d_nh_plot%>%filter(interventions!="no testing")
  p_more_than_9_residents_Ic_90d_res_plot<-p_more_than_9_residents_Ic_90d_res_plot%>%filter(interventions!="no testing")
}

## Define colours for plot
if(plot_type=="testing"){
  plot_col<-c("#e31a1c")
}


## test type for plotting with different symbols
if(plot_type=="testing"){
  p_more_than_0_residents_Ic_30d_nh_plot$test_type<-NA
  p_more_than_0_residents_Ic_30d_nh_plot$test_type<-as.character(p_more_than_0_residents_Ic_30d_nh_plot$interventions)
  p_more_than_0_residents_Ic_30d_nh_plot[grep(p_more_than_0_residents_Ic_30d_nh_plot$test_type, pattern = "LFD"),]$test_type<-"LFD"
  p_more_than_0_residents_Ic_30d_nh_plot[grep(p_more_than_0_residents_Ic_30d_nh_plot$test_type, pattern = "PCR"),]$test_type<-"PCR"
  
  p_more_than_0_residents_Ic_30d_res_plot$test_type<-NA
  p_more_than_0_residents_Ic_30d_res_plot$test_type<-as.character(p_more_than_0_residents_Ic_30d_res_plot$interventions)
  p_more_than_0_residents_Ic_30d_res_plot[grep(p_more_than_0_residents_Ic_30d_res_plot$test_type, pattern = "LFD"),]$test_type<-"LFD"
  p_more_than_0_residents_Ic_30d_res_plot[grep(p_more_than_0_residents_Ic_30d_res_plot$test_type, pattern = "PCR"),]$test_type<-"PCR"
  
  p_more_than_9_residents_Ic_90d_nh_plot$test_type<-NA
  p_more_than_9_residents_Ic_90d_nh_plot$test_type<-as.character(p_more_than_9_residents_Ic_90d_nh_plot$interventions)
  p_more_than_9_residents_Ic_90d_nh_plot[grep(p_more_than_9_residents_Ic_90d_nh_plot$test_type, pattern = "LFD"),]$test_type<-"LFD"
  p_more_than_9_residents_Ic_90d_nh_plot[grep(p_more_than_9_residents_Ic_90d_nh_plot$test_type, pattern = "PCR"),]$test_type<-"PCR"
  
  p_more_than_9_residents_Ic_90d_res_plot$test_type<-NA
  p_more_than_9_residents_Ic_90d_res_plot$test_type<-as.character(p_more_than_9_residents_Ic_90d_res_plot$interventions)
  p_more_than_9_residents_Ic_90d_res_plot[grep(p_more_than_9_residents_Ic_90d_res_plot$test_type, pattern = "LFD"),]$test_type<-"LFD"
  p_more_than_9_residents_Ic_90d_res_plot[grep(p_more_than_9_residents_Ic_90d_res_plot$test_type, pattern = "PCR"),]$test_type<-"PCR"
}else if (plot_type=="IPC_other"){
  p_more_than_0_residents_Ic_30d_nh_plot$test_type<-"NA"
  p_more_than_0_residents_Ic_30d_res_plot$test_type<-"NA"
  p_more_than_9_residents_Ic_90d_nh_plot$test_type<-"NA"
  p_more_than_9_residents_Ic_90d_res_plot$test_type<-"NA"
}

# which variable to  make facets by
if(R0_scenario=="all"){
  p_more_than_0_residents_Ic_30d_nh_plot$facet_var<-p_more_than_0_residents_Ic_30d_nh_plot$R0
  p_more_than_0_residents_Ic_30d_res_plot$facet_var<-p_more_than_0_residents_Ic_30d_res_plot$R0
  p_more_than_9_residents_Ic_90d_nh_plot$facet_var<-p_more_than_9_residents_Ic_90d_nh_plot$R0
  p_more_than_9_residents_Ic_90d_res_plot$facet_var<-p_more_than_9_residents_Ic_90d_res_plot$R0
}else{
  p_more_than_0_residents_Ic_30d_nh_plot$facet_var<-p_more_than_0_residents_Ic_30d_nh_plot$cprev
  p_more_than_0_residents_Ic_30d_res_plot$facet_var<-p_more_than_0_residents_Ic_30d_res_plot$cprev
  p_more_than_9_residents_Ic_90d_nh_plot$facet_var<-p_more_than_9_residents_Ic_90d_nh_plot$cprev
  p_more_than_9_residents_Ic_90d_res_plot$facet_var<-p_more_than_9_residents_Ic_90d_res_plot$cprev
}

### PLOTS
plot_more_than_0_residents_Ic_30d_nh<-ggplot(data=p_more_than_0_residents_Ic_30d_nh_plot,aes(x=interventions, y=dif_p.InfC_r_O_median, shape=test_type))+
  geom_point(size=3, col=plot_col)+theme_bw()+
  geom_errorbar(aes(ymin=dif_p.InfC_r_O_LL05, ymax=dif_p.InfC_r_O_UL95), alpha=0.25, col=plot_col)+
  geom_errorbar(aes(ymin=dif_p.InfC_r_O_LL25, ymax=dif_p.InfC_r_O_UL75), col=plot_col)+
  facet_wrap(~facet_var)+
  scale_colour_manual(values=plot_col)+
  theme(axis.text.x = element_text(angle = 90))+
  ylab("Effectiveness of intervention in preventing outbreaks at 30 days")+
  xlab("Interventions")+
  geom_hline(yintercept = 0, linetype="dashed")+
  theme(legend.position = "none")+
  coord_flip()

plot_more_than_9_residents_Ic_90d_nh<-ggplot(data=p_more_than_9_residents_Ic_90d_nh_plot,aes(x=interventions, y=dif_p.InfC_r_LO_median, shape=test_type))+
  geom_point(size=3, col=plot_col)+theme_bw()+
  geom_errorbar(aes(ymin=dif_p.InfC_r_LO_LL05, ymax=dif_p.InfC_r_LO_UL95), alpha=0.25, col=plot_col)+
  geom_errorbar(aes(ymin=dif_p.InfC_r_LO_LL25, ymax=dif_p.InfC_r_LO_UL75), col=plot_col)+  
  facet_wrap(~facet_var)+
  scale_colour_manual(values=plot_col)+
  theme(axis.text.x = element_text(angle = 90))+
  ylab("Effectiveness of intervention in preventing large outbreaks at 90 days")+
  xlab("Interventions")+
  geom_hline(yintercept = 0, linetype="dashed")+
  theme(legend.position = "none")+
  coord_flip()

plot_more_than_0_residents_Ic_30d_res<-ggplot(data=p_more_than_0_residents_Ic_30d_res_plot,aes(x=interventions, y=dif_p.InfC_r_O_median, shape=test_type))+
  geom_point(size=3, col=plot_col)+theme_bw()+
  geom_errorbar(aes(ymin=dif_p.InfC_r_O_LL05, ymax=dif_p.InfC_r_O_UL95), alpha=0.25, col=plot_col)+
  geom_errorbar(aes(ymin=dif_p.InfC_r_O_LL25, ymax=dif_p.InfC_r_O_UL75), col=plot_col)+
  facet_wrap(~facet_var)+
  scale_colour_manual(values=plot_col)+
  theme(axis.text.x = element_text(angle = 90))+
  ylab("Effectiveness of intervention in preventing outbreaks at 30 days")+
  xlab("Interventions")+
  geom_hline(yintercept = 0, linetype="dashed")+
  theme(legend.position = "none")+
  coord_flip()

plot_more_than_9_residents_Ic_90d_res<-ggplot(data=p_more_than_9_residents_Ic_90d_res_plot,aes(x=interventions, y=dif_p.InfC_r_LO_median, shape=test_type))+
  geom_point(size=3, col=plot_col)+theme_bw()+
  geom_errorbar(aes(ymin=dif_p.InfC_r_LO_LL05, ymax=dif_p.InfC_r_LO_UL95), alpha=0.25, col=plot_col)+
  geom_errorbar(aes(ymin=dif_p.InfC_r_LO_LL25, ymax=dif_p.InfC_r_LO_UL75), col=plot_col)+  
  facet_wrap(~facet_var)+
  scale_colour_manual(values=plot_col)+
  theme(axis.text.x = element_text(angle = 90))+
  ylab("Effectiveness of intervention in preventing large outbreaks at 90 days")+
  xlab("Interventions")+
  geom_hline(yintercept = 0, linetype="dashed")+
  theme(legend.position = "none")+
  coord_flip()

# gather  plots
plot1_nh<-plot_more_than_0_residents_Ic_30d_nh/plot_more_than_9_residents_Ic_90d_nh
plot1_nh<-plot1_nh + plot_layout(guides = "collect")

plot1_res<-plot_more_than_0_residents_Ic_30d_res/plot_more_than_9_residents_Ic_90d_res
plot1_res<-plot1_res + plot_layout(guides = "collect")

### SAVE
ggsave(plot1_nh, file=paste0(Plots,Sys.Date(),"Fig4.png"), width=30, height=20, units = "cm")
ggsave(plot1_res, file=paste0(Plots,Sys.Date(),"FigS16.png"), width=30, height=20, units = "cm")






