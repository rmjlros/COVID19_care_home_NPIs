# Impact of non-pharmaceutical interventions on SARS-CoV-2 in care homes in England: a modelling study

# Alicia Rosello (2021)
# https://github.com/rmjlros/COVID19_care_home_NPIs

# R script to plot Figure 2



### PREP

# clear environment
rm(list = ls(all = TRUE))	

# paths
Output_model<-"Outputs/Model/"
Plots<-"Plots/"

# packages
require(ggplot2)
require(gridExtra)
require(patchwork)
require(dplyr)
require(reshape2)


### READ IN MODEL OUTPUTS

all_dfs<-list()

a<-list.files(Output_model)

# select files
selected_files<-c("nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim.csv",
     "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim.csv",
     "nh_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim.csv",
     "res_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevh_p_drawn_SimpY_himpY_1500_sim.csv",
     "res_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevl_p_drawn_SimpY_himpY_1500_sim.csv",
     "res_himpsteph_visprep_pRinitb_sizeb_R0base_b2base_b3base_pibase_mibase_dibase_ptncbase_ptcbase_ptncsbase_ftncbase_ftcbase_ftncsbase_taH_pfnbase_s2_p2LTCFb_IcHallI_prevm_p_drawn_SimpY_himpY_1500_sim.csv")

a<-a[a%in%selected_files]

for(i in 1:length(a)){
  all_dfs[[i]]<-read.csv(paste0(Output_model,a[i]))
  all_dfs[[i]]$scenario<-a[i]
}

df_all<-do.call("rbind", all_dfs)

rm(all_dfs)


### LABEL DATASET

# adding LTCF type
df_all$LTCF_type<-df_all$scenario
df_all[grep(df_all$LTCF_type, pattern = "nh_"),]$LTCF_type<-"nursing care home"
df_all[grep(df_all$LTCF_type, pattern = "res_"),]$LTCF_type<-"residential care home"

#-- R0
df_all$R0<-df_all$scenario
df_all[grep(df_all$R0, pattern = "R0base"),]$R0<-"R0a mean 2"
df_all[grep(df_all$R0, pattern = "R0a3"),]$R0<-"R0a mean 3"
df_all[grep(df_all$R0, pattern = "R0a1"),]$R0<-"R0a mean 1"

# #-- visitors
df_all$visitors<-df_all$scenario
df_all[grep(df_all$visitors, pattern = "_visN_"),]$visitors<-"no visitors"
df_all[grep(df_all$visitors, pattern = "_visprep_"),]$visitors<-"visitors (baseline)"
# df_all[grep(df_all$visitors, pattern = "_visweekly_"),]$visitors<-"weekly visitors"

#-- community prevalence
df_all$cprev<-df_all$scenario
df_all[grep(df_all$cprev, pattern = "_prevm_"),]$cprev<-"medium community prevalence (baseline)"
df_all[grep(df_all$cprev, pattern = "_prevl_"),]$cprev<-"low community prevalence"
df_all[grep(df_all$cprev, pattern = "_prevh_"),]$cprev<-"high community prevalence"

#-- p_staff_other_LTCF
df_all$p_staff_other_LTCF<-df_all$scenario
df_all[grep(df_all$p_staff_other_LTCF, pattern = "p2LTCFb"),]$p_staff_other_LTCF<-"p staff working at anonther LTCF 0.115 (baseline)"
df_all[grep(df_all$p_staff_other_LTCF, pattern = "p2LTCF0"),]$p_staff_other_LTCF<-"p staff working at anonther LTCF 0"

#-- no_transmission_staff
df_all$no_transmission_staff<-df_all$scenario
df_all[grep(df_all$no_transmission_staff, pattern = "_SimpN_"),]$no_transmission_staff<-"no importation from staff"
df_all[grep(df_all$no_transmission_staff, pattern = "_SimpY_"),]$no_transmission_staff<-"importation from staff (baseline)"

#-- no_transmission_hospital
df_all$no_transmission_hospital<-df_all$scenario
df_all[grep(df_all$no_transmission_hospital, pattern = "_himpN_"),]$no_transmission_hospital<-"no importation from hospital"
df_all[grep(df_all$no_transmission_hospital, pattern = "_himpY_"),]$no_transmission_hospital<-"importation from hospital (baseline)"


### SELECT INTERVENTION BEING MODELLED

#-- interventions
df_all$interventions<-df_all$scenario
df_all$interventions<-"baseline"
table(df_all$interventions)


### MERGING LABEL FOR PLOTTING

df_all$big_table<-paste(df_all$R0, df_all$cprev, df_all$interventions, sep=", ")


### NAME THE SCENARIO

name_scenario<-"community_prev"


### MAX 100 DAYS

df1<-df_all
max_time<-100
df1<-df1%>%filter(time<=max_time)


### SET THE NAME OF THE VARIABLE CONSIDERED

df1$variable_considered<-df1$cprev


### CALCULATE UNCERTAINTY INTERVALS

# adjust class
df1$n.InfC_r<-as.numeric(as.character(df1$n.InfC_r))
df1$p.InfC_r_O<-as.numeric(as.character(df1$p.InfC_r_O))
df1$p.InfC_r_LO<-as.numeric(as.character(df1$p.InfC_r_LO))

df1<-df1%>%
  group_by(time, n.sims, scenario, LTCF_type, R0, cprev, interventions, variable_considered)%>%
  summarise(n.InfC_r_median=quantile(n.InfC_r,probs = 0.5),
            n.InfC_r_L5=quantile(n.InfC_r,probs = 0.05),
            n.InfC_r_L10=quantile(n.InfC_r,probs = 0.10),
            n.InfC_r_L25=quantile(n.InfC_r,probs = 0.25),
            n.InfC_r_U95=quantile(n.InfC_r,probs = 0.95),
            n.InfC_r_U90=quantile(n.InfC_r,probs = 0.90),
            n.InfC_r_U75=quantile(n.InfC_r,probs = 0.75),
            
            p.InfC_r_O_median=quantile(p.InfC_r_O,probs = 0.5),
            p.InfC_r_O_L5=quantile(p.InfC_r_O,probs = 0.05),
            p.InfC_r_O_L10=quantile(p.InfC_r_O,probs = 0.10),
            p.InfC_r_O_L25=quantile(p.InfC_r_O,probs = 0.25),
            p.InfC_r_O_U95=quantile(p.InfC_r_O,probs = 0.95),
            p.InfC_r_O_U90=quantile(p.InfC_r_O,probs = 0.90),
            p.InfC_r_O_U75=quantile(p.InfC_r_O,probs = 0.75),
            
            
            p.InfC_r_LO_median=quantile(p.InfC_r_LO,probs = 0.5),
            p.InfC_r_LO_L5=quantile(p.InfC_r_LO,probs = 0.05),
            p.InfC_r_LO_L10=quantile(p.InfC_r_LO,probs = 0.10),
            p.InfC_r_LO_L25=quantile(p.InfC_r_LO,probs = 0.25),
            p.InfC_r_LO_U95=quantile(p.InfC_r_LO,probs = 0.95),
            p.InfC_r_LO_U90=quantile(p.InfC_r_LO,probs = 0.90),
            p.InfC_r_LO_U75=quantile(p.InfC_r_LO,probs = 0.75))

# all variables as character
df1<-data.frame(lapply(df1, as.character), stringsAsFactors=FALSE)
# long
df1_long<-melt(df1, id.vars=c("time", "n.sims", "scenario", "LTCF_type", "R0", "cprev","interventions", "variable_considered"))
# value column as numeric
df1_long$value<-as.numeric(as.character(df1_long$value))
# time column as numeric
df1_long$time<-as.numeric(as.character(df1_long$time))


### RELEVELING LABEL FOR PLOTTING

df1_long$variable_considered<-factor(df1_long$variable_considered, levels=c("low community prevalence",
                                                                            "medium community prevalence (baseline)",
                                                                            "high community prevalence"))


### PLOTS

##  1.-- probability at each timepoint of having had 1 or more Ic resident in the care home 
# select appropriate  data
df1_long_pO<-df1_long%>%filter(variable%in%c("p.InfC_r_O_median","p.InfC_r_O_L25","p.InfC_r_O_U75"))
# wide
df1_pO<-dcast(df1_long_pO, time + n.sims + scenario + LTCF_type + R0 + cprev + interventions +  variable_considered ~ variable, value.var="value")

# plot
p_O_r<-ggplot(data=df1_pO, aes(x=time, y=p.InfC_r_O_median, col= variable_considered, fill=variable_considered)) + 
  geom_ribbon(aes(ymin=p.InfC_r_O_L25, ymax=p.InfC_r_O_U75), alpha=0.25, colour=NA,show.legend = FALSE)+
  geom_line(size=1) +
  scale_colour_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  scale_fill_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  facet_grid(~LTCF_type)+
  xlab("Day of the study")+
  ylab("Cumulative probability of an outbreak")+
  theme_bw()+
  theme(legend.key.width = unit(0.5, "cm"),legend.key.height=unit(1, "cm"))+
  labs(colour="scenario")+
  theme(legend.position="bottom",
        legend.direction="vertical")+
  geom_vline(aes(xintercept = 30), linetype="dashed")
# save
# ggsave(p_O_r, file=paste0(Plots, Sys.Date(),"_p_more_than_0_residents_Ic_", max_time, "d_",name_scenario,".png"), width = 8, height=8)

## 2.-- probability at each timepoint of having had 10 or more Ic resident in the care home 
# select appropriate  data
df1_long_pLO<-df1_long%>%filter(variable%in%c("p.InfC_r_LO_median","p.InfC_r_LO_L25","p.InfC_r_LO_U75"))
# wide
df1_pLO<-dcast(df1_long_pLO, time + n.sims + scenario + LTCF_type + R0 + cprev + interventions + variable_considered ~ variable, value.var="value")

# plot
p_LO_r<-ggplot(data=df1_pLO, aes(x=time, y=p.InfC_r_LO_median, col= variable_considered, fill=variable_considered)) + 
  geom_ribbon(aes(ymin=p.InfC_r_LO_L25, ymax=p.InfC_r_LO_U75), alpha=0.25, colour=NA,show.legend = FALSE)+
  geom_line(size=1) +
  scale_colour_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  scale_fill_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  facet_grid(~LTCF_type)+
  xlab("Day of the study")+
  ylab("Cumulative probability of a large outbreak")+
  theme_bw()+
  theme(legend.key.width = unit(0.5, "cm"),legend.key.height=unit(1, "cm"))+
  labs(colour="scenario")+
  theme(legend.position="bottom",
        legend.direction="vertical")+
  geom_vline(aes(xintercept = 90), linetype="dashed")
# save
# ggsave(p_LO_r, file=paste0(Plots, Sys.Date(),"_p_more_than_9_residents_Ic_", max_time, "d_",name_scenario,".png"), width = 8, height=8)


## 3.-- median number of infectious and Ic residents in the LTCF by each time point 

# select appropriate  data
df1_long_nIc<-df1_long%>%filter(variable%in%c("n.InfC_r_median","n.InfC_r_L25","n.InfC_r_U75"))
# wide
df1_nIc<-dcast(df1_long_nIc, time + n.sims + scenario + LTCF_type + R0 + cprev + interventions +  variable_considered ~ variable, value.var="value")

# plot
p_nIc<-ggplot(data=df1_nIc, aes(x=time, y=n.InfC_r_median, col= variable_considered, fill=variable_considered)) + 
  geom_ribbon(aes(ymin=n.InfC_r_L25, ymax=n.InfC_r_U75), alpha=0.25, colour=NA,show.legend = FALSE)+
  geom_line(size=1) +
  scale_colour_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  scale_fill_manual(values=c("#41b6c4","#2c7fb8","#253494"))+ #blues
  facet_grid(~LTCF_type)+
  xlab("Day of the study")+
  ylab("Cumulative N residents symptomatic")+
  theme_bw()+
  theme(legend.key.width = unit(0.5, "cm"),legend.key.height=unit(1, "cm"))+
  labs(colour="scenario")+
  theme(legend.position="bottom",
        legend.direction="vertical")# save
# ggsave(p_nIc, file=paste0(Plots, Sys.Date(),"_number_residents_Ic_", max_time, "d_",name_scenario,".png"), width = 8, height=8)


### COMBINE PLOTS

plot_1<-(p_O_r+
           theme(legend.position = "none")+
           ggtitle("a")+
           p_LO_r+
           ggtitle("b")+
           p_nIc+
           theme(legend.position = "none")+
           ggtitle("c")+
           plot_layout(ncol = 1, guides="collect"))


## save plot
ggsave(plot_1, file=paste0(Plots, "Fig2.png"), width = 12, height=10)

