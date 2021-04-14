### define stochastic model, for use with euler.sim, see ?euler.sim

SIS.sim.c <- '

// DECLARE COMPOSIT PARAMETERS

double delta_c;
double kappa_c;
double beta_pc;
double beta_h;
double beta_l;
double beta_a;
double epsilon;
double tau;
double tau_i;
double gamma_pc;
double gamma_pc_l1;
double gamma_pc_l2;
double gamma_c;
double gamma_c_l4;
double gamma_a;
double gamma_pc_s;
double gamma_pc_l1_s;
double gamma_a_s;
double gamma_c_s;
double phi;
double phi_a;
double phi_ai;
double phi_i_l4;
double phi_i_l2;
double omega;
double omega_i;
double omega_i_l1;
double foi_c2s;
double foi_o2s;
double nu;
double p_COVID_hosp;
double xS;
double xE;
double xIpcpi;
double xIpc;
double xIa;
double xIapi;
double xIpci;
double xIai;
double xIchpi1;
double xIchpi2;
double xIchpi3;
double xIchpi4;
double xIch;
double xIchi1;
double xIchi2;
double xIchi3;
double xIclpi1;
double xIclpi2;
double xIcli1;
double xIcli2;
double xIcli3;
double xIcl;
double xR;
double zS;
double zE;
double zIpcpi;
double zIpc;
double zIa;
double zIapi;
double zIpci;
double zIai;
double zIchpi1;
double zIchpi2;
double zIchpi3;
double zIchpi4;
double zIch;
double zIchi1;
double zIchi2;
double zIchi3;
double zIclpi1;
double zIclpi2;
double zIcli1;
double zIcli2;
double zIcli3;
double zIcl;
double zR;
double aSs2;
double aEs2;
double aIpcpis2;
double aIpcs2;
double aIas2;
double aIapis2;
double aIchpi1s2;
double aIchpi2s2;
double aAs2;
double aRs2;
double l1;
double l2;
double l3;
double l4;
double l5;
double l1s;
double l2s;
double switch_isolation_gamma_nc;
double switch_isolation_gamma_c;
double switch_isolation_gamma_a_s;


// DECLARE STORAGE OBJECTS
double rate[105];
double dN[105];

double resN = S + E + Ipcpi + Ipc + Ia + Iapi + Ipci + Iai + Ichpi1 + Ichpi2 + Ichpi3 + Ichpi4 + Ichi1 + Ichi2  + Ichi3 + Ich + Iclpi1 + Iclpi2 + Icli1 + Icli2 + Icli3 + Icl + R;
double staffN = Ss + Es + Ipcpis + Ipcs + Ias + Iapis + Ichpi1s + Ichpi2s + Rs + Ss2 + Es2 + Ipcpis2 + Ipcs2 + Ias2 + Iapis2 + Ichpi1s2 + Ichpi2s2 + Rs2;

// DECLARE OBJECS FOR ENTRIES AND EXITS
double exits;
double exits_h;
double exits_hc;
double exits_non_hc;

double bS;
double bE;
double bIpcpi;
double bIpc;
double bIa;
double bIapi;
double bIpci;
double bIai;
double bIchpi1;
double bIchpi2;
double bIchpi3;
double bIchpi4;
double bIch;
double bIchi1;
double bIchi2;
double bIchi3;
double bIclpi1;
double bIclpi2;
double bIcli1;
double bIcli2;
double bIcli3;
double bIcl;
double bR;

//double CS;
//double CE;
//double CIpcpi;
//double CIpc;
//double CIa;
//double CIapi;
//double CIpci;
//double CIai;
//double CIchpi1;
//double CIchpi2;
//double CIchpi3;
//double CIchpi4;
//double CIch;
//double CIchi1;
//double CIchi2;
//double CIchi3;
//double CIclpi1;
//double CIclpi2;
//double CIcli1;
//double CIcli2;
//double CIcli3;
//double CIcl;
//double CR;

double HS;
double HE;
double HIpcpi;
double HIpc;
double HIa;
double HIapi;
double HIpci;
double HIai;
double HIchpi1;
double HIchpi2;
double HIchpi3;
double HIchpi4;
double HIch;
double HIchi1;
double HIchi2;
double HIchi3;
double HIclpi1;
double HIclpi2;
double HIcli1;
double HIcli2;
double HIcli3;
double HIcl;
double HR;

double HS_non_hc;
double HE_non_hc;
double HIpcpi_non_hc;
double HIpc_non_hc;
double HIa_non_hc;
double HIapi_non_hc;
double HIpci_non_hc;
double HIai_non_hc;
double HIchpi1_non_hc;
double HIchpi2_non_hc;
double HIchpi3_non_hc;
double HIchpi4_non_hc;
double HIch_non_hc;
double HIchi1_non_hc;
double HIchi2_non_hc;
double HIchi3_non_hc;
double HIclpi1_non_hc;
double HIclpi2_non_hc;
double HIcli1_non_hc;
double HIcli2_non_hc;
double HIcli3_non_hc;
double HIcl_non_hc;
double HR_non_hc;

double HS_hc;
double HE_hc;
double HIpcpi_hc;
double HIpc_hc;
double HIa_hc;
double HIapi_hc;
double HIpci_hc;
double HIai_hc;
double HIchpi1_hc;
double HIchpi2_hc;
double HIchpi3_hc;
double HIchpi4_hc;
double HIch_hc;
double HIchi1_hc;
double HIchi2_hc;
double HIchi3_hc;
double HIclpi1_hc;
double HIclpi2_hc;
double HIcli1_hc;
double HIcli2_hc;
double HIcli3_hc;
double HIcl_hc;
double HR_hc;

double bSs2;
double bEs2;
double bIpcpis2;
double bIpcs2;
double bIas2;
double bIapis2;
double bIchpi1s2;
double bIchpi2s2;
double bAs2;
double bRs2;

double exitSs2;
double exitEs2;
double exitIpcpis2;
double exitIpcs2;
double exitIas2;
double exitIapis2;
double exitIchpi1s2;
double exitIchpi2s2;
double exitAs2;
double exitRs2;

double absent_staff;
double returning_staff;

// DECLARE OBJECS FOI

double lambda_r2r;
double lambda_v2r;
double lambda_s2r;
double lambda_s2s;
double lambda_r2s;
double lambda_c2s;
double lambda_o2s;
double lambda_o2s2;

double beta2_pc;
double beta2_h;
double beta2_l;
double beta2_a;

//  DECLARE OBJECTS TESTING

int m_tnc_period;
int m_tc_period;
int m_tncs_period;

//--Auxiliary variables, to be used below

// CALCULATING RATES 

//death rate in the LTCF COVID symptomatic residents pppd
delta_c=((CFR*p_deaths_in_LTCF_vs_H)/d_c_inf)*m_delta_c_res; 

//hospitalisation rate for COVID symptomatic residents pppd
kappa_c=((CFR*(1-p_deaths_in_LTCF_vs_H))/(1-p_survival))/d_c_inf;  //if probability of COVID resident dying is 25%, and if 80% of COVID deaths are in CH (vs Hospital) -> 0.25*0.2=0.05 -> 5% COVID residents die in H. Probability of being hospitalised if have COVID in residents=0.05/0.3=0.17

//transmission rate from preclinical residents pppd
beta_pc=(R0_LTCF_a*proportion_transmission_pre_c_vs_c)/d_pc_inf; 

//transmission rate from clinical residents with high infectiousness pppd
beta_h=(R0_LTCF_a*(1-proportion_transmission_pre_c_vs_c)*(1-proportion_transmission_cl_vs_ch))/(d_c_inf/2); 

//transmission rate from clinical residents with low infectiousness pppd
beta_l=(R0_LTCF_a*(1-proportion_transmission_pre_c_vs_c)*(proportion_transmission_cl_vs_ch))/(d_c_inf/2); 

//transmission rate from asymptomatic residents pppd
beta_a=(R0_LTCF_a*m_R0_LTCF_b_vs_a)/(d_pc_inf+d_c_inf); 

//rate to infectiousness (latency) pppd
epsilon=1/d_latency; 

//onset rate pppd
tau=1/d_pc_inf; 

//onset rate pppd for those who have been isolated pre-clinical
tau_i=1/d_pc_inf_i;
if(d_pc_inf_i==0){
  tau_i=0;
}

//rate of isolation of residents pppd
gamma_pc=1/delay_to_isolation_pc; 
if(delay_to_isolation_pc==0){
  gamma_pc=0;
}
gamma_pc_l1=1/d_ch_inf_pi_l1;
if(d_ch_inf_pi_l1==0){
  gamma_pc_l1=0;
}
gamma_pc_l2=1/d_cl_inf_pi_l2; 
if(d_cl_inf_pi_l2==0){
  gamma_pc_l2=0;
}
gamma_c=1/delay_to_isolation_c;
if(delay_to_isolation_c==0){
  gamma_c=0;
}
gamma_c_l4=1/d_cl_inf_pi_l4;
if(d_cl_inf_pi_l4==0){
  gamma_c_l4=0;
}
gamma_a=1/delay_to_isolation_a;
if(delay_to_isolation_a==0){
  gamma_a=0;
}

//rate of isolation of staff pppd 
gamma_pc_s=1/delay_to_isolation_pc;
if(delay_to_isolation_pc==0){
  gamma_pc_s=0;
}
gamma_pc_l1_s=1/d_ch_inf_pi_l1;
if(d_ch_inf_pi_l1==0){
  gamma_pc_l1_s=0;
}
gamma_c_s=1/delay_to_isolation_c; 
if(delay_to_isolation_c==0){
  gamma_c_s=0;
}
gamma_a_s=1/delay_to_isolation_a;
if(delay_to_isolation_a==0){
  gamma_a_s=0;
}

//rate of progression to less transmissible disease pppd
omega=1/(d_c_inf/2); 

//rate of progression to less transmissible disease for those who have been isolated clinical pppd
omega_i=1/d_ch_inf_i;
if(d_ch_inf_i==0){
  omega_i=0;
}
omega_i_l1=1/d_ch_inf_i_l1;
if(d_ch_inf_i_l1==0){
  omega_i_l1=0;
}

//recovery rate for clinical residents pppd
phi=1/(d_c_inf/2); 

//recovery rate for asymptomatic residents pppd
phi_a=1/(d_pc_inf+d_c_inf);

//recovery rate for asymptomatic residents being isolated pppd
phi_ai=1/d_a_inf_i;
if(d_a_inf_i==0){
  phi_ai=0;
}

// recovery rate for clinical residents isolated
phi_i_l2=1/d_cl_inf_i_l2;
if(d_cl_inf_i_l2==0){
  phi_i_l2=0;
}
phi_i_l4=1/d_cl_inf_i_l4;
if(d_cl_inf_i_l4==0){
  phi_i_l4=0;
}

//rate at which staff that are absent come back recovered pppd 
nu=1/n_days_absent;   

//force of infection from the communtiy to staff
foi_c2s=(R0_community/d_total_inf_community)*c_prev;

//force of infection from another LTCF to staff
foi_o2s=((R0_LTCF_a/(d_pc_inf+d_c_inf))*p_LTCF2_outbreak*p_LTCF2_outbreak_inf*(1-p_a))+
(((R0_LTCF_a*m_R0_LTCF_b_vs_a)/(d_pc_inf+d_c_inf))*p_LTCF2_outbreak*p_LTCF2_outbreak_inf*p_a)+
((R0_LTCF_a/d_total_inf_community)*p_LTCF2_outbreak*p_LTCF2_outbreak_inf*(1-p_as))+
(((R0_LTCF_a*m_R0_LTCF_b_vs_a)/d_total_inf_community)*p_LTCF2_outbreak*p_LTCF2_outbreak_inf*p_as);


// CALCULATING WHICH ISOLATION STRATEGY TO TAKE DEPENDING ON GAMMA FOR RESIDENTS

if(delay_to_isolation_pc<d_pc_inf){
l1=0;
l2=0;
l3=0;
} else if(delay_to_isolation_pc>d_pc_inf && delay_to_isolation_pc<(d_pc_inf+(d_c_inf/2))){
l1=1;
l2=0;
l3=0;
} else if(delay_to_isolation_pc>d_pc_inf && delay_to_isolation_pc>(d_pc_inf+(d_c_inf/2)) && delay_to_isolation_pc<(d_pc_inf+(d_c_inf/2)+(d_c_inf/2))){
l1=0;
l2=1;
l3=0;
} else{ 
l1=0; 
l2=0;
l3=1; //(delay_to_isolation_pc>d_pc_inf && delay_to_isolation_pc>(d_pc_inf+(d_c_inf/2)) && delay_to_isolation_pc>(d_pc_inf+(d_c_inf/2)+(d_c_inf/2)))
}

if(delay_to_isolation_c<(d_c_inf/2)){
l4=0;
l5=0;
} else if(delay_to_isolation_c>(d_c_inf/2) && delay_to_isolation_c<((d_c_inf/2)+(d_c_inf/2))){
l4=1;
l5=0;
} else{ 
l4=0;
l5=1; //(delay_to_isolation_c>(d_c_inf/2) && delay_to_isolation_c>((d_c_inf/2)+(d_c_inf/2)))
}

if(l3==1){
switch_isolation_gamma_nc=0; // no isolation (same as no testing) if delay is longer than infectious period
} else{
switch_isolation_gamma_nc=1; // isolation as normal
}

if(l5==1){
switch_isolation_gamma_c=0; // no isolation (same as no testing) if delay is longer than infectious period
} else{
switch_isolation_gamma_c=1; // isolation as normal
}


// CALCULATING WHICH ISOLATION STRATEGY TO TAKE DEPENDING ON GAMMA FOR STAFF

if(delay_to_isolation_pc<d_pc_inf){
l1s=0;
} else {
l1s=1;
} 
if(delay_to_isolation_a<(d_pc_inf+d_c_inf)){ 
l2s=0;
} else{
l2s=1;
}

if(l2s==1){
switch_isolation_gamma_a_s=0; // isolation same as no testing if delay is longer than pre-clinical
} else{
switch_isolation_gamma_a_s=1; // isolation as normal
}


// CALCULATING PROPORTIONS ENTERING EACH COMPARTMENT FROM HOSPITAL AFTER NON-COVID HOSPITALISATION

// proportion entries from hospital into S
xS=1-(p_R_hosp+p_EIpcIa_hosp);

// proportion entries from hospital into E
xE=p_EIpcIa_hosp * p_E_if_inf_hosp;

// proportion entries from hospital into Ipcpi
if(switch_h_testing==0){
xIpcpi = p_EIpcIa_hosp * p_Ipc_if_inf_hosp * (p_tnc * switch_isolation_gamma_nc) * (1-p_fn); // if no testing after H
}else{
xIpcpi = p_EIpcIa_hosp * p_Ipc_if_inf_hosp * (1-p_fn_h);  // if testing after H
}

// proportion entries from hospital into Ipc
if(switch_h_testing==0){
xIpc = p_EIpcIa_hosp * p_Ipc_if_inf_hosp * ((p_tnc * switch_isolation_gamma_nc) * p_fn + (1-(p_tnc * switch_isolation_gamma_nc))); // if no testing after H
}else{
xIpc = p_EIpcIa_hosp * p_Ipc_if_inf_hosp * p_fn_h;  // if testing after H
}

// proportion entries from hospital into Ia
if(switch_h_testing==0){
xIa = p_EIpcIa_hosp * p_Ia_if_inf_hosp * ((p_tnc * switch_isolation_gamma_nc) * p_fn + (1-(p_tnc * switch_isolation_gamma_nc))); // if no testing after H
}else{
xIa = p_EIpcIa_hosp * p_Ia_if_inf_hosp * p_fn_h;  // if testing after H
}

// proportion entries from hospital into Iapi
if(switch_h_testing==0){
xIapi = p_EIpcIa_hosp * p_Ia_if_inf_hosp * (p_tnc * switch_isolation_gamma_nc) * (1-p_fn); // if no testing after H
}else{
xIapi = p_EIpcIa_hosp * p_Ia_if_inf_hosp * (1-p_fn_h);  // if testing after H
}

// proportion entries from hospital into Ipci
xIpci=0;

// proportion entries from hospital into Iai
xIai=0;

// proportion entries from hospital into Ichpi1  (assuming nobody is coming in clinical)
xIchpi1=0;

// proportion entries from hospital into Ichpi2  (assuming nobody is coming in clinical)
xIchpi2=0;

// proportion entries from hospital into Ichpi3  (assuming nobody is coming in clinical)
xIchpi3=0;

// proportion entries from hospital into Ichpi4  (assuming nobody is coming in clinical)
xIchpi4=0;

// proportion entries from hospital into Ich  (assuming nobody is coming in clinical)
xIch=0;

// proportion entries from hospital into Ichi1  (assuming nobody is coming in clinical)
xIchi1=0;

// proportion entries from hospital into Ichi2  (assuming nobody is coming in clinical)
xIchi2=0;

// proportion entries from hospital into Ichi3  (assuming nobody is coming in clinical)
xIchi3=0;

// proportion entries from hospital into Iclpi1  (assuming nobody is coming in clinical)
xIclpi1=0;

// proportion entries from hospital into Iclpi2  (assuming nobody is coming in clinical)
xIclpi2=0;

// proportion entries from hospital into Icli1  (assuming nobody is coming in clinical)
xIcli1=0;

// proportion entries from hospital into Icli2  (assuming nobody is coming in clinical)
xIcli2=0;

// proportion entries from hospital into Icli3  (assuming nobody is coming in clinical)
xIcli3=0;

// proportion entries from hospital into Icl  (assuming nobody is coming in clinical)
xIcl=0;

// proportion entries from hospital into R
xR=p_R_hosp;


// CALCULATING PROPORTIONS ENTERING EACH COMPARTMENT FROM HOSPITAL AFTER COVID HOSPITALISATION

// proportion entries from hospital into S (COVID patients returning) 
zS=0;

// proportion entries from hospital into E (COVID patients returning)
zE=0;

// proportion entries from hospital into Ipcpi (COVID patients returning)
zIpcpi = 0; 

// proportion entries from hospital into Ipc (COVID patients returning)
zIpc = 0;

// proportion entries from hospital into Ia (COVID patients returning)
zIa = 0;

// proportion entries from hospital into Iapi (COVID patients returning)
zIapi = 0;

// proportion entries from hospital into Ipci (COVID patients returning)
zIpci=0;

// proportion entries from hospital into Iai (COVID patients returning)
zIai=0;

// proportion entries from hospital into Ichpi1 (COVID patients returning)
zIchpi1=0;

// proportion entries from hospital into Ichpi2 (COVID patients returning)
zIchpi2=0;

// proportion entries from hospital into Ichpi3 (COVID patients returning)
zIchpi3=0;

// proportion entries from hospital into Ichpi4 (COVID patients returning)
zIchpi4=0;

// proportion entries from hospital into Ich (COVID patients returning)
zIch=0;

// proportion entries from hospital into Ichi1 (COVID patients returning)
zIchi1=0;

// proportion entries from hospital into Ichi2 (COVID patients returning)
zIchi2=0;

// proportion entries from hospital into Ichi3 (COVID patients returning)
zIchi3=0;

// proportion entries from hospital into Iclpi1 (COVID patients returning)
zIclpi1=0;

// proportion entries from hospital into Iclpi2 (COVID patients returning)
zIclpi2=0;

// proportion entries from hospital into Icli1 (COVID patients returning)
if(switch_all_COVID_returns==1){
zIcli1 = 0.06 * (1-p_fn_h); // if all COVID returns are isolated
}else{
zIcli1 = 0; // if all COVID returns are NOT isolated
}

// proportion entries from hospital into Icli2 (COVID patients returning)
zIcli2 = 0;

// proportion entries from hospital into Icli3 (COVID patients returning)
zIcli3 = 0;

// proportion entries from hospital into Icl (COVID patients returning)
if(switch_all_COVID_returns==2){
zIcl = 0; // if all COVID returns are recovered
}if(switch_all_COVID_returns==1){
zIcl = 0.06 * p_fn_h; // if all COVID returns are isolated
}else{
zIcl = 0.06; 
}

// proportion entries from hospital into R (COVID patients returning)
if(switch_all_COVID_returns==2){
zR = 1; // if all COVID returns are recovered
}else{
zR = 0.94; 
}


// CALCULATING PROPORTIONS ENTERING EACH COMPARTMENT FROM REPLACEMENT STAFF

// proportion of replacement staff entering Ss2
aSs2=1-(p_R_s2+p_EIpcIa_s2);

// proportion of replacement staff entering Es2
aEs2=p_EIpcIa_s2 * p_E_if_inf_s2;

// proportion of replacement staff entering Ipcpis2
aIpcpis2=p_EIpcIa_s2 * p_Ipc_if_inf_s2 * p_tncs * (1-p_fn);

// proportion of replacement staff entering Ipcs2
aIpcs2=p_EIpcIa_s2 * p_Ipc_if_inf_s2 * (p_tncs * p_fn + (1-p_tncs));

// proportion of replacement staff entering Ias2
aIas2=p_EIpcIa_s2 * p_Ia_if_inf_s2 * ((p_tncs*switch_isolation_gamma_a_s) * p_fn + (1-(p_tncs*switch_isolation_gamma_a_s)));

// proportion of replacement staff entering Iapis2
aIapis2=p_EIpcIa_s2 * p_Ia_if_inf_s2  * (p_tncs*switch_isolation_gamma_a_s) * (1-p_fn);

// proportion of replacement staff entering Ichpi1s2
aIchpi1s2=0;

// proportion of replacement staff entering Ichpi2s2
aIchpi2s2=0;

// proportion of replacement staff entering As2
aAs2=0;

// proportion of replacement staff entering Rs2
aRs2=p_R_s2;


// BETA MODIFIED AFTER 1 RESIDENT ISOLATED OR 1 STAFF ABSENT

if(Ipci+Iai+Ichi1+Ichi2+Ichi3+Icli1+Icli2+Icli3+As+As2>=1){
beta2_pc = beta_pc*m_beta2;
beta2_h = beta_h*m_beta2;
beta2_l = beta_l*m_beta2;
beta2_a = beta_a*m_beta2;
} else {
beta2_pc = beta_pc;
beta2_h = beta_h;
beta2_l = beta_l;
beta2_a = beta_a;
}

// FOI
lambda_r2r = (beta2_pc * ((Ipc+Ipcpi + (Ipci * m_i))/resN)) + (beta2_h * ((Ich+Ichpi1+Ichpi2+Ichpi3+Ichpi4 + ((Ichi1+Ichi2+Ichi3) * m_i))/resN)) + (beta2_l * ((Icl+Iclpi1+Iclpi2+ ((Icli1+Icli2+Icli3) * m_i))/resN)) + (beta2_a * ((Ia+Iapi+ (Iai* m_i))/resN)); //FoI from resident to resident

lambda_v2r = beta2_a * (n_V * resN * p_v_infectious * m_v)/resN; //FoI from visitor to resident

lambda_s2r = (beta2_pc * msr_pc * ((Ipcpis+Ipcs+Ipcpis2+Ipcs2)/staffN)) + (beta2_h * msr_h * ((Ichpi1s+Ichpi1s2+Ichpi2s+Ichpi2s2)/staffN)) + (beta2_a * msr_a * ((Ias+Iapis+Ias2+Iapis2)/staffN)); //FoI from staff to resident

lambda_s2s = (beta2_pc * mss_pc * ((Ipcpis+Ipcs+Ipcpis2+Ipcs2)/staffN)) + (beta2_h * mss_h * ((Ichpi1s+Ichpi1s2+Ichpi2s+Ichpi2s2)/staffN)) + (beta2_a * mss_a * ((Ias+Iapis+Ias2+Iapis2)/staffN)); //FoI from staff to staff

lambda_r2s = (beta2_pc * mrs_pc * ((Ipc+Ipcpi + (Ipci * m_i))/resN)) + (beta2_h * mrs_h * ((Ich+Ichpi1+Ichpi2+Ichpi3+Ichpi4 + ((Ichi1+Ichi2+Ichi3) * m_i))/resN)) + (beta2_l * mrs_l * ((Icl+Iclpi1+Iclpi2+ ((Icli1+Icli2+Icli3) * m_i))/resN)) + (beta2_a * mrs_a * (Ia+Iapi+ (Iai* m_i)/resN)); //FoI from resident to staff

lambda_c2s = foi_c2s; //FoI from the community to staff

lambda_o2s = p_working_another_LTCF * foi_o2s; //FoI from other LTCFs to staff 

lambda_o2s2 = p_working_another_LTCF2 * foi_o2s; //FoI from other LTCFs to staff 


// TESTING

// define the frequency of testing non-clinical residents, m_tnc_period
if(tnc_period==0){
m_tnc_period = 1; // if no testing period, test according to proportion tested
}else{
m_tnc_period= (((int)t) % ((int)tnc_period)) == 0 ? 1 : 0; // if t is in seq(0,max(t), by=tnc_period), then m_tnc_period=1, otherwise 0
}

// define the frequency of testing clinical residents, m_tc_period
if(tc_period==0){
m_tc_period = 1;// if no testing period, test according to proportion tested
}else{
m_tc_period = (((int)t) % ((int)tc_period)) == 0 ? 1 : 0; // if t is in seq(0,max(t), by=tc_period), then m_tc_period=1, otherwise 0
}

// define the frequency of testing non-clinical staff, define m_tncs_period
if(tncs_period==0){
m_tncs_period = 1;// if no testing period, test according to proportion tested
}else{
m_tncs_period= (((int)t) % ((int)tncs_period)) == 0 ? 1 : 0; // if t is in seq(0,max(t), by=tncs_period), then m_tncs_period=1, otherwise 0
}


// RESIDENTS

//exits S compartment
rate[0] = delta; // normal death rate
rate[1] = kappa; // hospitalisation rate
rate[2] = lambda_r2r + lambda_v2r + lambda_s2r; // infection, rate at which S become E
  
//exits E compartment
rate[3] = delta; // normal death rate
rate[4] = kappa; // hospitalisation rate
rate[5] = epsilon * (1-p_a) * ((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * (1-p_fn) * p_i; // incubation in those that will be isolated and will develop symptoms, rate at which E become Ipcpi 
rate[6] = epsilon * (1-p_a) * ((((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * p_fn) + 
                           (1-((p_tnc * switch_isolation_gamma_nc) * m_tnc_period)) +
                           (((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * (1-p_fn) * (1-p_i))); // incubation in those that will develop symptoms and will NOT be isolated, rate at which E become Ipc
rate[7] = epsilon * p_a * ((((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * p_fn) + 
                       (1-((p_tnc * switch_isolation_gamma_nc) * m_tnc_period)) +
                       (((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * (1-p_fn) * (1-p_i))); // incubation in those that will NOT develop symptoms and will NOT be isolated, rate at which E become Ia
rate[8] = epsilon * p_a * ((p_tnc * switch_isolation_gamma_nc) * m_tnc_period) * (1-p_fn) * p_i; // incubation in those that will NOT develop symptoms and will be isolated, rate at which E become Iapi

//exits Ipcpi compartment
rate[9] = delta; // normal death rate
rate[10] = kappa; // hospitalisation rate
rate[11] = gamma_pc * (1-l1) * (1-l2); // rate of isolation, rate at which Ipcpi become Ipci
rate[12] = tau * l1; // onset in those that will be isolated, rate at which Ipcpi become Ichpi3
rate[13] = tau * l2; // onset in those that will be isolated, rate at which Ipcpi become Ichpi4

//exits Ipc compartment
rate[14] = delta; // normal death rate
rate[15] = kappa; // hospitalisation rate
rate[16] = tau * ((((p_tc*switch_isolation_gamma_c) * m_tc_period) * p_fn * (1-p_i)) + 
         (((p_tc*switch_isolation_gamma_c) * m_tc_period) * (1-p_fn) * (1-p_i)) + 
         ((1-((p_tc*switch_isolation_gamma_c) * m_tc_period)) * (1-p_i))); // onset in those that will NOT be isolated, rate at which Ipc become Ich
rate[17] = tau * ((((p_tc*switch_isolation_gamma_c) * m_tc_period) * (1-p_fn) * p_i) + 
         (((p_tc*switch_isolation_gamma_c) * m_tc_period) * p_fn * p_i) + 
         ((1-((p_tc*switch_isolation_gamma_c) * m_tc_period)) * p_i)) * (1-l4); // onset in those that will be isolated, rate at which Ipc become Ichpi1 
rate[18] = tau * ((((p_tc*switch_isolation_gamma_c) * m_tc_period) * (1-p_fn) * p_i) + 
         (((p_tc*switch_isolation_gamma_c) * m_tc_period) * p_fn * p_i) + 
         ((1-((p_tc*switch_isolation_gamma_c) * m_tc_period)) * p_i)) * l4; // onset in those that will be isolated, rate at which Ipc become Ichpi2 

//exits Ia compartment
rate[19] = delta; // normal death rate
rate[20] = kappa; // hospitalisation rate
rate[21] = phi_a; // rate of removal (recovery) in asymptomatic, rate at which Ia become R

//exits Iapi compartment
rate[22] = delta; // normal death rate
rate[23] = kappa; // hospitalisation rate
rate[24] = gamma_a; // rate of isolation, rate at which Iapi become Iai

//exits Ipci compartment
rate[25] = delta; // normal death rate
rate[26] = kappa; // hospitalisation rate
rate[27] = tau_i; // onset after isolation at pre-clinical stage, rate at which Ipci become Ichi2

//exits Iai compartment
rate[28] = delta; // normal death rate
rate[29] = kappa; // hospitalisation rate
rate[30] = phi_ai; // rate of removal (recovery) in asymptomatic in isolation, rate at which Iai become R

//exits Ichpi1 compartment
rate[31] = delta_c; // death rate in those presenting with clinical symptoms
rate[32] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[33] = gamma_c; // rate of isolation, rate at which Ichpi1 become Ichi1

//exits Ichpi2 compartment
rate[34] = delta_c; // death rate in those presenting with clinical symptoms
rate[35] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[36] = omega; // rate of progression to less infectious clinical disease, rate at which Ichpi2 become Iclpi1

//exits Ichpi3 compartment
rate[37] = delta_c; // death rate in those presenting with clinical symptoms
rate[38] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[39] = gamma_pc_l1; // rate of isolation, rate at which Ichpi3 become Ichi3

//exits Ichpi4 compartment
rate[40] = delta_c; // death rate in those presenting with clinical symptoms
rate[41] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[42] = omega; // rate of progression to less infectious clinical disease, rate at which Ichpi4 become Iclpi2

//exits Ich compartment
rate[43] = delta_c; // death rate in those presenting with clinical symptoms
rate[44] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[45] = omega; // rate of progression to less infectious clinical disease, rate at which Ich become Icl

//exits Ichi1 compartment
rate[46] = delta_c; // death rate in those presenting with clinical symptoms
rate[47] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[48] = omega_i; // rate of progression to less infectious clinical disease, rate at which Ichi1 become Icli1

//exits Ichi2 compartment
rate[49] = delta_c; // death rate in those presenting with clinical symptoms
rate[50] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[51] = omega; // rate of progression to less infectious clinical disease, rate at which Icih2 become Icli1

//exits Ichi3 compartment
rate[52] = delta_c; // death rate in those presenting with clinical symptoms
rate[53] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[54] = omega_i_l1; // rate of progression to less infectious clinical disease, rate at which Icih3 become Icli1

//exits Iclpi1 compartment
rate[55] = delta_c; // death rate in those presenting with clinical symptoms
rate[56] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[57] = gamma_c_l4; // rate of isolation, rate at which Iclpi1 become Icli2

//exits Iclpi2 compartment
rate[58] = delta_c; // death rate in those presenting with clinical symptoms
rate[59] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[60] = gamma_pc_l2; // rate of isolation, rate at which Iclpi2 become Icli3

//exits Icli1 compartment
rate[61] = delta_c; // death rate in those presenting with clinical symptoms
rate[62] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[63] = phi; // rate of removal (recovery) in symptomatic in isolation, rate at which Icli1 become R

//exits Icli2 compartment
rate[64] = delta_c; // death rate in those presenting with clinical symptoms
rate[65] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[66] = phi_i_l4; // rate of removal (recovery) in symptomatic in isolation, rate at which Icli2 become R

//exits Icli3 compartment
rate[67] = delta_c; // death rate in those presenting with clinical symptoms
rate[68] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[69] = phi_i_l2; // rate of removal (recovery) in symptomatic in isolation, rate at which Icli3 become R

//exits Icl compartment
rate[70] = delta_c; // death rate in those presenting with clinical symptoms
rate[71] = kappa_c; // hospitalisation rate in those presenting with clinical symptoms
rate[72] = phi; // rate of removal (recovery) in symptomatic NOT in isolation, rate at which Icl become R

//exits R compartment
rate[73] = delta; // normal death rate
rate[74] = kappa; // hospitalisation rate


//STAFF

//exits Ss compartment
rate[75] = lambda_r2s + lambda_s2s + lambda_c2s + lambda_o2s; // infection, rate at which Ss become Es
  
//exits Es compartment
rate[76] = epsilon * (1-p_as) * (p_tncs * m_tncs_period) * (1-p_fn); // incubation in those that will be isolated and will develop symptoms, rate at which Es become Ipcpis 
rate[77] = epsilon * (1-p_as) * (((p_tncs * m_tncs_period) * p_fn) + (1-(p_tncs * m_tncs_period))); // incubation in those that will develop symptoms and will NOT be isolated, rate at which Es become Ipcs
rate[78] = epsilon * p_as * ((((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period) * p_fn) + (1-((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period))); // incubation in those that will NOT develop symptoms and will NOT be isolated, rate at which Es become Ias
rate[79] = epsilon * p_as * ((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period) * (1-p_fn); // incubation in those that will NOT develop symptoms and will be isolated, rate at which Es become Iapis

//exits Ipcpis compartment
rate[80] = gamma_pc_s * (1-l1s); // rate of isolation, rate at which Ipcpis become As
rate[81] = tau *  l1s; //rate of onset,  rate at whiich Ipcpis become Ichpi2s

//exits Ipcs compartment
rate[82] = tau ; // onset, rate at which Ipcs become Ichpi1s

//exits Ias compartment
rate[83] = phi_a; // rate of removal (recovery) in asymptomatic, rate at which Ias become Rs

//exits Iapis compartment
rate[84] = gamma_a_s; // rate of isolation, rate at which Iapis become As

//exits Ichpi1s compartment
rate[85] = gamma_c_s; // rate of isolation, rate at which Ichpi1s become As

//exits Ichpi2s compartment
rate[86] = gamma_pc_l1_s; // rate of isolation, rate at which Ichpi2s become As

//exits As compartment
rate[87] = nu; // rate of removal (recovery) in isolation, rate at which As become Rs


//REPLACEMENT STAFF

//exits Ss2 compartment
rate[88] = lambda_r2s + lambda_s2s + lambda_c2s + lambda_o2s2; // infection, rate at which Ss2 become Es2
  
//exits Es2 compartment
rate[89] = epsilon * (1-p_as) * (p_tncs * m_tncs_period) * (1-p_fn); // incubation in those that will be isolated and will develop symptoms, rate at which Es2 become Ipcpis2 
rate[90] = epsilon * (1-p_as) * (((p_tncs * m_tncs_period) * p_fn) + (1-(p_tncs * m_tncs_period))); // incubation in those that will develop symptoms and will NOT be isolated, rate at which Es2 become Ipcs2
rate[91] = epsilon * p_as * ((((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period) * p_fn) + (1-((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period))); // incubation in those that will NOT develop symptoms and will NOT be isolated, rate at which Es2 become Ias2
rate[92] = epsilon * p_as * ((p_tncs*switch_isolation_gamma_a_s) * m_tncs_period) * (1-p_fn); // incubation in those that will NOT develop symptoms and will be isolated, rate at which Es2 become Iapis2

//exits Ipcpis2 compartment
rate[93] = gamma_pc_s * (1-l1s); // rate of isolation, rate at which Ipcpis2 become As2
rate[94] = tau * l1s; // rate of onset, at which Ipcpis2 become Ichpi2s2 

//exits Ipcs2 compartment
rate[95] = tau ; // onset, rate at which Ipcs2 become Ichpi1s2 (will be isolated)

//exits Ias2 compartment
rate[96] = phi_a; // rate of removal (recovery) in asymptomatic, rate at which Ias2 become Rs2

//exits Iapis2 compartment
rate[97] = gamma_a_s; // rate of isolation, rate at which Iapis2 become As2

//exits Ichpi1s2 compartment
rate[98] = gamma_c_s; // rate of isolation, rate at which Ichpi1s2 become As2

//exits Ichpi2s2 compartment
rate[99] = gamma_pc_l1_s; // rate of isolation, rate at which Ichpi2s2 become As2


//--Stochastic draw of individuals for each transition

reulermultinom(3, S, &rate[0], dt, &dN[0]); 
reulermultinom(6, E, &rate[3], dt, &dN[3]);
reulermultinom(5, Ipcpi, &rate[9], dt, &dN[9]);
reulermultinom(5, Ipc, &rate[14], dt, &dN[14]);
reulermultinom(3, Ia, &rate[19], dt, &dN[19]);
reulermultinom(3, Iapi, &rate[22], dt, &dN[22]);
reulermultinom(3, Ipci, &rate[25], dt, &dN[25]);
reulermultinom(3, Iai, &rate[28], dt, &dN[28]);
reulermultinom(3, Ichpi1, &rate[31], dt, &dN[31]);
reulermultinom(3, Ichpi2, &rate[34], dt, &dN[34]);
reulermultinom(3, Ichpi3, &rate[37], dt, &dN[37]);
reulermultinom(3, Ichpi4, &rate[40], dt, &dN[40]);
reulermultinom(3, Ich, &rate[43], dt, &dN[43]);
reulermultinom(3, Ichi1, &rate[46], dt, &dN[46]);
reulermultinom(3, Ichi2, &rate[49], dt, &dN[49]);
reulermultinom(3, Ichi3, &rate[52], dt, &dN[52]);
reulermultinom(3, Iclpi1, &rate[55], dt, &dN[55]);
reulermultinom(3, Iclpi2, &rate[58], dt, &dN[58]);
reulermultinom(3, Icli1, &rate[61], dt, &dN[61]);
reulermultinom(3, Icli2, &rate[64], dt, &dN[64]);
reulermultinom(3, Icli3, &rate[67], dt, &dN[67]);
reulermultinom(3, Icl, &rate[70], dt, &dN[70]);
reulermultinom(2, R, &rate[73], dt, &dN[73]);

reulermultinom(1, Ss, &rate[75], dt, &dN[75]);
reulermultinom(4, Es, &rate[76], dt, &dN[76]);
reulermultinom(2, Ipcpis, &rate[80], dt, &dN[80]);
reulermultinom(1, Ipcs, &rate[82], dt, &dN[82]);
reulermultinom(1, Ias, &rate[83], dt, &dN[83]);
reulermultinom(1, Iapis, &rate[84], dt, &dN[84]);
reulermultinom(1, Ichpi1s, &rate[85], dt, &dN[85]);
reulermultinom(1, Ichpi2s, &rate[86], dt, &dN[86]);
reulermultinom(1, As, &rate[87], dt, &dN[87]);

reulermultinom(1, Ss2, &rate[88], dt, &dN[88]);
reulermultinom(4, Es2, &rate[89], dt, &dN[89]);
reulermultinom(2, Ipcpis2, &rate[93], dt, &dN[93]);
reulermultinom(1, Ipcs2, &rate[95], dt, &dN[95]);
reulermultinom(1, Ias2, &rate[96], dt, &dN[96]);
reulermultinom(1, Iapis2, &rate[97], dt, &dN[97]);
reulermultinom(1, Ichpi1s2, &rate[98], dt, &dN[98]);
reulermultinom(1, Ichpi2s2, &rate[99], dt, &dN[99]);

//Rprintf(\"%f is time of reulermultinom draw\\n",t);


//--Total number of exits from the LTCF from residents

exits = dN[0]+dN[1]+dN[3]+dN[4]+dN[9]+dN[10]+dN[14]+dN[15]+dN[19]+dN[20]+dN[22]+dN[23]+dN[25]+dN[26]+dN[28]+dN[29]+dN[31]+dN[32]+dN[34]+dN[35]+dN[37]+dN[38]+dN[40]+dN[41]+dN[43]+dN[44]+dN[46]+dN[47]+dN[49]+dN[50]+dN[52]+dN[53]+dN[55]+dN[56]+dN[58]+dN[59]+dN[61]+dN[62]+dN[64]+dN[65]+dN[67]+dN[68]+dN[70]+dN[71]+dN[73]+dN[74]; 

exits_h = dN[1]+dN[4]+dN[10]+dN[15]+dN[20]+dN[23]+dN[26]+dN[29]+dN[32]+dN[35]+dN[38]+dN[41]+dN[44]+dN[47]+dN[50]+dN[53]+dN[56]+dN[59]+dN[62]+dN[65]+dN[68]+dN[71]+dN[74]; //exits to hospital

exits_hc = dN[32]+dN[35]+dN[38]+dN[41]+dN[44]+dN[47]+dN[50]+dN[53]+dN[56]+dN[59]+dN[62]+dN[65]+dN[68]+dN[71]; //exits to hospital from those with COVID clinical symptoms

exits_non_hc = dN[0]+dN[1]+dN[3]+dN[4]+dN[9]+dN[10]+dN[14]+dN[15]+dN[19]+dN[20]+dN[22]+dN[23]+dN[25]+dN[26]+dN[28]+dN[29]+dN[73]+dN[74]; //exits to hospital general (non-COVID) or dying general (non-COVID)


//--Entries from community and hospital

//only if entries include those from the community
//CS=rpois(exits*y1*(1-hl)); //entries from the community into S
//CE=rpois(exits*y2*(1-hl)); //entries from the community into E
//CIpc=rpois(exits*y5*(1-hl)); //entries from the community into Ipc
//CIa=rpois(exits*y6*(1-hl)); //entries from the community into Ia
//CIc=rpois(exits*y7*(1-hl)); //entries from the community into Ic
//CIcpi=rpois(exits*y8*(1-hl)); //entries from the community into Icpi
//CR=rpois(exits*y9*(1-hl)); //entries from the community into R
//CIci=rpois(exits*y10*(1-hl)); //entries from the community into Ici

//only if entries include those from the community
//HS=rpois(exits*xS*hl); //entries from the hospital into S
//HE=rpois(exits*xE*hl); //entries from the hospital into E
//HIpc=rpois(exits*xIpc*hl); //entries from the hospital into Ipc
//HIa=rpois(exits*xIa*hl); //entries from the hospital into Ia
//HIc=rpois(exits*xIapi*hl); //entries from the hospital into Ic
//HIcpi=rpois(exits*xIpci*hl); //entries from the hospital into Icpi
//HR=rpois(exits*xIai*hl); //entries from the hospital into R
//HIci=rpois(exits*xIchi2*(1-hl)); //entries from the hospital into Ici

//only if entries include those from the community
//bS=(HS+CS); //all entries into S
//bE=(HE+CE); //all entries into E
//bIpc=(HIpc+CIpc); //all entries into Ipc
//bIa=(HIa+CIa); //all entries into Ia
//bIc=(HIc+CIc); //all entries into Ic
//bIcpi=(HIcpi+CIcpi); //all entries into Icpi
//bR=(HR+CR); //all entries into R
//bIci=(HIci+CIci); //all entries into Ici

//if entries only from hospital. These entries are from clinical residents that left and did not die + other admissions to the care home from hospital
HS_non_hc=rpois(exits_non_hc*xS); //entries from the hospital into S general admissions to the care home from hospital
HE_non_hc=rpois(exits_non_hc*xE); //entries from the hospital into E general admissions to the care home from hospital
HIpcpi_non_hc=rpois(exits_non_hc*xIpcpi); //entries from the hospital into Ipcpi general admissions to the care home from hospital
HIpc_non_hc=rpois(exits_non_hc*xIpc); //entries from the hospital into Ipc general admissions to the care home from hospital
HIa_non_hc=rpois(exits_non_hc*xIa); //entries from the hospital into Ia general admissions to the care home from hospital
HIapi_non_hc=rpois(exits_non_hc*xIapi); //entries from the hospital into Iapi general admissions to the care home from hospital
HIpci_non_hc=rpois(exits_non_hc*xIpci); //entries from the hospital into Ipci general admissions to the care home from hospital
HIai_non_hc=rpois(exits_non_hc*xIai); //entries from the hospital into Iai general admissions to the care home from hospital
HIchpi1_non_hc=rpois(exits_non_hc*xIchpi1); //entries from the hospital into Ichpi1 general admissions to the care home from hospital
HIchpi2_non_hc=rpois(exits_non_hc*xIchpi2); //entries from the hospital into Ichpi2 general admissions to the care home from hospital
HIchpi3_non_hc=rpois(exits_non_hc*xIchpi3); //entries from the hospital into Ichpi3 general admissions to the care home from hospital
HIchpi4_non_hc=rpois(exits_non_hc*xIchpi4); //entries from the hospital into Ichpi4 general admissions to the care home from hospital
HIch_non_hc=rpois(exits_non_hc*xIch); //entries from the hospital into Ich general admissions to the care home from hospital
HIchi1_non_hc=rpois(exits_non_hc*xIchi1); //entries from the hospital into Ichi1 general admissions to the care home from hospital
HIchi2_non_hc=rpois(exits_non_hc*xIchi2); //entries from the hospital into Ichi2 general admissions to the care home from hospital
HIchi3_non_hc=rpois(exits_non_hc*xIchi3); //entries from the hospital into Ichi3 general admissions to the care home from hospital
HIclpi1_non_hc=rpois(exits_non_hc*xIclpi1); //entries from the hospital into Iclpi1 general admissions to the care home from hospital
HIclpi2_non_hc=rpois(exits_non_hc*xIclpi2); //entries from the hospital into Iclpi2 general admissions to the care home from hospital
HIcli1_non_hc=rpois(exits_non_hc*xIcli1); //entries from the hospital into Icli1 general admissions to the care home from hospital
HIcli2_non_hc=rpois(exits_non_hc*xIcli2); //entries from the hospital into Icli2 general admissions to the care home from hospital
HIcli3_non_hc=rpois(exits_non_hc*xIcli3); //entries from the hospital into Icli3 general admissions to the care home from hospital
HIcl_non_hc=rpois(exits_non_hc*xIcl); //entries from the hospital into Icl general admissions to the care home from hospital
HR_non_hc=rpois(exits_non_hc*xR); //entries from the hospital into R general admissions to the care home from hospital

HS_hc=rpois(exits_hc*p_survival*zS); //entries from the hospital into S from clinical residents that left and did not die
HE_hc=rpois(exits_hc*p_survival*zE); //entries from the hospital into E from clinical residents that left and did not die
HIpcpi_hc=rpois(exits_hc*p_survival*zIpcpi); //entries from the hospital into Ipcpi from clinical residents that left and did not die
HIpc_hc=rpois(exits_hc*p_survival*zIpc); //entries from the hospital into Ipc from clinical residents that left and did not die
HIa_hc=rpois(exits_hc*p_survival*zIa); //entries from the hospital into Ia from clinical residents that left and did not die
HIapi_hc=rpois(exits_hc*p_survival*zIapi); //entries from the hospital into Iapi from clinical residents that left and did not die
HIpci_hc=rpois(exits_hc*p_survival*zIpci); //entries from the hospital into Ipci from clinical residents that left and did not die
HIai_hc=rpois(exits_hc*p_survival*zIai); //entries from the hospital into Iai from clinical residents that left and did not die
HIchpi1_hc=rpois(exits_hc*p_survival*zIchpi1); //entries from the hospital into Ichpi1 from clinical residents that left and did not die
HIchpi2_hc=rpois(exits_hc*p_survival*zIchpi2); //entries from the hospital into Ichpi2 from clinical residents that left and did not die
HIchpi3_hc=rpois(exits_hc*p_survival*zIchpi3); //entries from the hospital into Ichpi3 from clinical residents that left and did not die
HIchpi4_hc=rpois(exits_hc*p_survival*zIchpi4); //entries from the hospital into Ichpi4 from clinical residents that left and did not die
HIch_hc=rpois(exits_hc*p_survival*zIch); //entries from the hospital into Ich from clinical residents that left and did not die
HIchi1_hc=rpois(exits_hc*p_survival*zIchi1); //entries from the hospital into Ichi1 from clinical residents that left and did not die
HIchi2_hc=rpois(exits_hc*p_survival*zIchi2); //entries from the hospital into Ichi2 from clinical residents that left and did not die
HIchi3_hc=rpois(exits_hc*p_survival*zIchi3); //entries from the hospital into Ichi3 from clinical residents that left and did not die
HIclpi1_hc=rpois(exits_hc*p_survival*zIclpi1); //entries from the hospital into Iclpi1 from clinical residents that left and did not die
HIclpi2_hc=rpois(exits_hc*p_survival*zIclpi2); //entries from the hospital into Iclpi2 from clinical residents that left and did not die
HIcli1_hc=rpois(exits_hc*p_survival*zIcli1); //entries from the hospital into Icli1 from clinical residents that left and did not die
HIcli2_hc=rpois(exits_hc*p_survival*zIcli2); //entries from the hospital into Icli2 from clinical residents that left and did not die
HIcli3_hc=rpois(exits_hc*p_survival*zIcli3); //entries from the hospital into Icli3 from clinical residents that left and did not die
HIcl_hc=rpois(exits_hc*p_survival*zIcl); //entries from the hospital into Icl from clinical residents that left and did not die
HR_hc=rpois(exits_hc*p_survival*zR); //entries from the hospital into R from clinical residents that left and did not die

HS=HS_non_hc+HS_hc; //entries from the hospital into S
HE=HE_non_hc+HE_hc;
HIpcpi=HIpcpi_non_hc+HIpcpi_hc;
HIpc=HIpc_non_hc+HIpc_hc;
HIa=HIa_non_hc+HIa_hc;
HIapi=HIapi_non_hc+HIapi_hc;
HIpci=HIpci_non_hc+HIpci_hc;
HIai=HIai_non_hc+HIai_hc;
HIchpi1=HIchpi1_non_hc+HIchpi1_hc;
HIchpi2=HIchpi2_non_hc+HIchpi2_hc;
HIchpi3=HIchpi3_non_hc+HIchpi3_hc;
HIchpi4=HIchpi4_non_hc+HIchpi4_hc;
HIch=HIch_non_hc+HIch_hc;
HIchi1=HIchi1_non_hc+HIchi1_hc;
HIchi2=HIchi2_non_hc+HIchi2_hc;
HIchi3=HIchi3_non_hc+HIchi3_hc;
HIclpi1=HIclpi1_non_hc+HIclpi1_hc;
HIclpi2=HIclpi2_non_hc+HIclpi2_hc;
HIcli1=HIcli1_non_hc+HIcli1_hc;
HIcli2=HIcli2_non_hc+HIcli2_hc;
HIcli3=HIcli3_non_hc+HIcli3_hc;
HIcl=HIcl_non_hc+HIcl_hc;
HR=HR_non_hc+HR_hc;

while ((HS+HE+HIpcpi+HIpc+HIa+HIapi+HIpci+HIai+HIchpi1+HIchpi2+HIchpi3+HIchpi4+HIch+HIchi1+HIchi2+HIchi3+HIclpi1+HIclpi2+HIcli1+HIcli2+HIcli3+HIcl+HR)!=exits_non_hc){ 

  HS_non_hc=rpois(exits_non_hc*xS); //entries from the hospital into S general admissions to the care home from hospital
  HE_non_hc=rpois(exits_non_hc*xE); //entries from the hospital into E general admissions to the care home from hospital
  HIpcpi_non_hc=rpois(exits_non_hc*xIpcpi); //entries from the hospital into Ipcpi general admissions to the care home from hospital
  HIpc_non_hc=rpois(exits_non_hc*xIpc); //entries from the hospital into Ipc general admissions to the care home from hospital
  HIa_non_hc=rpois(exits_non_hc*xIa); //entries from the hospital into Ia general admissions to the care home from hospital
  HIapi_non_hc=rpois(exits_non_hc*xIapi); //entries from the hospital into Iapi general admissions to the care home from hospital
  HIpci_non_hc=rpois(exits_non_hc*xIpci); //entries from the hospital into Ipci general admissions to the care home from hospital
  HIai_non_hc=rpois(exits_non_hc*xIai); //entries from the hospital into Iai general admissions to the care home from hospital
  HIchpi1_non_hc=rpois(exits_non_hc*xIchpi1); //entries from the hospital into Ichpi1 general admissions to the care home from hospital
  HIchpi2_non_hc=rpois(exits_non_hc*xIchpi2); //entries from the hospital into Ichpi2 general admissions to the care home from hospital
  HIchpi3_non_hc=rpois(exits_non_hc*xIchpi3); //entries from the hospital into Ichpi3 general admissions to the care home from hospital
  HIchpi4_non_hc=rpois(exits_non_hc*xIchpi4); //entries from the hospital into Ichpi4 general admissions to the care home from hospital
  HIch_non_hc=rpois(exits_non_hc*xIch); //entries from the hospital into Ich general admissions to the care home from hospital
  HIchi1_non_hc=rpois(exits_non_hc*xIchi1); //entries from the hospital into Ichi1 general admissions to the care home from hospital
  HIchi2_non_hc=rpois(exits_non_hc*xIchi2); //entries from the hospital into Ichi2 general admissions to the care home from hospital
  HIchi3_non_hc=rpois(exits_non_hc*xIchi3); //entries from the hospital into Ichi3 general admissions to the care home from hospital
  HIclpi1_non_hc=rpois(exits_non_hc*xIclpi1); //entries from the hospital into Iclpi1 general admissions to the care home from hospital
  HIclpi2_non_hc=rpois(exits_non_hc*xIclpi2); //entries from the hospital into Iclpi2 general admissions to the care home from hospital
  HIcli1_non_hc=rpois(exits_non_hc*xIcli1); //entries from the hospital into Icli1 general admissions to the care home from hospital
  HIcli2_non_hc=rpois(exits_non_hc*xIcli2); //entries from the hospital into Icli2 general admissions to the care home from hospital
  HIcli3_non_hc=rpois(exits_non_hc*xIcli3); //entries from the hospital into Icli3 general admissions to the care home from hospital
  HIcl_non_hc=rpois(exits_non_hc*xIcl); //entries from the hospital into Icl general admissions to the care home from hospital
  HR_non_hc=rpois(exits_non_hc*xR); //entries from the hospital into R general admissions to the care home from hospital
  
  HS_hc=rpois(exits_hc*p_survival*zS); //entries from the hospital into S from clinical residents that left and did not die
  HE_hc=rpois(exits_hc*p_survival*zE); //entries from the hospital into E from clinical residents that left and did not die
  HIpcpi_hc=rpois(exits_hc*p_survival*zIpcpi); //entries from the hospital into Ipcpi from clinical residents that left and did not die
  HIpc_hc=rpois(exits_hc*p_survival*zIpc); //entries from the hospital into Ipc from clinical residents that left and did not die
  HIa_hc=rpois(exits_hc*p_survival*zIa); //entries from the hospital into Ia from clinical residents that left and did not die
  HIapi_hc=rpois(exits_hc*p_survival*zIapi); //entries from the hospital into Iapi from clinical residents that left and did not die
  HIpci_hc=rpois(exits_hc*p_survival*zIpci); //entries from the hospital into Ipci from clinical residents that left and did not die
  HIai_hc=rpois(exits_hc*p_survival*zIai); //entries from the hospital into Iai from clinical residents that left and did not die
  HIchpi1_hc=rpois(exits_hc*p_survival*zIchpi1); //entries from the hospital into Ichpi1 from clinical residents that left and did not die
  HIchpi2_hc=rpois(exits_hc*p_survival*zIchpi2); //entries from the hospital into Ichpi2 from clinical residents that left and did not die
  HIchpi3_hc=rpois(exits_hc*p_survival*zIchpi3); //entries from the hospital into Ichpi3 from clinical residents that left and did not die
  HIchpi4_hc=rpois(exits_hc*p_survival*zIchpi4); //entries from the hospital into Ichpi4 from clinical residents that left and did not die
  HIch_hc=rpois(exits_hc*p_survival*zIch); //entries from the hospital into Ich from clinical residents that left and did not die
  HIchi1_hc=rpois(exits_hc*p_survival*zIchi1); //entries from the hospital into Ichi1 from clinical residents that left and did not die
  HIchi2_hc=rpois(exits_hc*p_survival*zIchi2); //entries from the hospital into Ichi2 from clinical residents that left and did not die
  HIchi3_hc=rpois(exits_hc*p_survival*zIchi3); //entries from the hospital into Ichi3 from clinical residents that left and did not die
  HIclpi1_hc=rpois(exits_hc*p_survival*zIclpi1); //entries from the hospital into Iclpi1 from clinical residents that left and did not die
  HIclpi2_hc=rpois(exits_hc*p_survival*zIclpi2); //entries from the hospital into Iclpi2 from clinical residents that left and did not die
  HIcli1_hc=rpois(exits_hc*p_survival*zIcli1); //entries from the hospital into Icli1 from clinical residents that left and did not die
  HIcli2_hc=rpois(exits_hc*p_survival*zIcli2); //entries from the hospital into Icli2 from clinical residents that left and did not die
  HIcli3_hc=rpois(exits_hc*p_survival*zIcli3); //entries from the hospital into Icli3 from clinical residents that left and did not die
  HIcl_hc=rpois(exits_hc*p_survival*zIcl); //entries from the hospital into Icl from clinical residents that left and did not die
  HR_hc=rpois(exits_hc*p_survival*zR); //entries from the hospital into R from clinical residents that left and did not die
  
  HS=HS_non_hc+HS_hc; //entries from the hospital into S
  HE=HE_non_hc+HE_hc;
  HIpcpi=HIpcpi_non_hc+HIpcpi_hc;
  HIpc=HIpc_non_hc+HIpc_hc;
  HIa=HIa_non_hc+HIa_hc;
  HIapi=HIapi_non_hc+HIapi_hc;
  HIpci=HIpci_non_hc+HIpci_hc;
  HIai=HIai_non_hc+HIai_hc;
  HIchpi1=HIchpi1_non_hc+HIchpi1_hc;
  HIchpi2=HIchpi2_non_hc+HIchpi2_hc;
  HIchpi3=HIchpi3_non_hc+HIchpi3_hc;
  HIchpi4=HIchpi4_non_hc+HIchpi4_hc;
  HIch=HIch_non_hc+HIch_hc;
  HIchi1=HIchi1_non_hc+HIchi1_hc;
  HIchi2=HIchi2_non_hc+HIchi2_hc;
  HIchi3=HIchi3_non_hc+HIchi3_hc;
  HIclpi1=HIclpi1_non_hc+HIclpi1_hc;
  HIclpi2=HIclpi2_non_hc+HIclpi2_hc;
  HIcli1=HIcli1_non_hc+HIcli1_hc;
  HIcli2=HIcli2_non_hc+HIcli2_hc;
  HIcli3=HIcli3_non_hc+HIcli3_hc;
  HIcl=HIcl_non_hc+HIcl_hc;
  HR=HR_non_hc+HR_hc;
  
  //Rprintf(\"%f is time of searching match entry exits\\n",t);

}

//entries to the LTCF from hospital (switch turns this on or off)
bS=HS*switch_h_imp; //all entries into S
bE=HE*switch_h_imp;
bIpcpi=HIpcpi*switch_h_imp;
bIpc=HIpc*switch_h_imp;
bIa=HIa*switch_h_imp;
bIapi=HIapi*switch_h_imp;
bIpci=HIpci*switch_h_imp;
bIai=HIai*switch_h_imp;
bIchpi1=HIchpi1*switch_h_imp;
bIchpi2=HIchpi2*switch_h_imp;
bIchpi3=HIchpi3*switch_h_imp;
bIchpi4=HIchpi4*switch_h_imp;
bIch=HIch*switch_h_imp;
bIchi1=HIchi1*switch_h_imp;
bIchi2=HIchi2*switch_h_imp;
bIchi3=HIchi3*switch_h_imp;
bIclpi1=HIclpi1*switch_h_imp;
bIclpi2=HIclpi2*switch_h_imp;
bIcli1=HIcli1*switch_h_imp;
bIcli2=HIcli2*switch_h_imp;
bIcli3=HIcli3*switch_h_imp;
bIcl=HIcl*switch_h_imp;
bR=HR*switch_h_imp;


//--Absent staff

//total new absent (from pool 1) and newly returning staff
absent_staff = dN[80] + dN[84] + dN[85] + dN[86];
returning_staff = dN[87];

//introduce replacement staff at the same rate as original staff become absent, at a p_replaced, and into each comparment according to aSs2...aRs2. Cap so that number of replacement staff cannot be higher than absent staff
bSs2 = rpois(absent_staff*p_replaced*aSs2)*switch_new_staff;
bEs2 = rpois(absent_staff*p_replaced*aEs2)*switch_new_staff;
bIpcpis2 = rpois(absent_staff*p_replaced*aIpcpis2)*switch_new_staff;
bIpcs2 = rpois(absent_staff*p_replaced*aIpcs2)*switch_new_staff;
bIas2 = rpois(absent_staff*p_replaced*aIas2)*switch_new_staff;
bIapis2 = rpois(absent_staff*p_replaced*aIapis2)*switch_new_staff;
bIchpi1s2 = rpois(absent_staff*p_replaced*aIchpi1s2)*switch_new_staff;
bIchpi2s2 = rpois(absent_staff*p_replaced*aIchpi2s2)*switch_new_staff;
bAs2 = rpois(absent_staff*p_replaced*aAs2)*switch_new_staff;
bRs2 = rpois(absent_staff*p_replaced*aRs2)*switch_new_staff;

while ((bSs2+bEs2+bIpcpis2+bIpcs2+bIas2+bIapis2+bIchpi1s2+bIchpi2s2+bAs2+bRs2)>absent_staff){

  bSs2 = rpois(absent_staff*p_replaced*aSs2)*switch_new_staff;
  bEs2 = rpois(absent_staff*p_replaced*aEs2)*switch_new_staff;
  bIpcpis2 = rpois(absent_staff*p_replaced*aIpcpis2)*switch_new_staff;
  bIpcs2 = rpois(absent_staff*p_replaced*aIpcs2)*switch_new_staff;
  bIas2 = rpois(absent_staff*p_replaced*aIas2)*switch_new_staff;
  bIapis2 = rpois(absent_staff*p_replaced*aIapis2)*switch_new_staff;
  bIchpi1s2 = rpois(absent_staff*p_replaced*aIchpi1s2)*switch_new_staff;
  bIchpi2s2 = rpois(absent_staff*p_replaced*aIchpi2s2)*switch_new_staff;
  bAs2 = rpois(absent_staff*p_replaced*aAs2)*switch_new_staff;
  bRs2 = rpois(absent_staff*p_replaced*aRs2)*switch_new_staff;
  
  //Rprintf(\"%f is time of searching match absent staff\\n",t);

}

//remove replacement staff at the same rate as staff become recovered, randomly from each comparment. Cap so that number of replacement staff exiting is the same as number of original staff returning, and cant be higher that what is in compartment
if(round(returning_staff*p_replaced)==0){
  exitSs2=0;
  exitEs2=0;
  exitIpcpis2=0;
  exitIpcs2=0;
  exitIas2=0;
  exitIapis2=0;
  exitIchpi1s2=0;
  exitIchpi2s2=0;
  exitAs2=0;
  exitRs2=0;
}else{
  exitSs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitSs2>(Ss2 + bSs2 - dN[88])){
  exitSs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitEs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitEs2>(Es2 + bEs2 + dN[88] - dN[89] - dN[90]  - dN[91] - dN[92])){
  exitEs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIpcpis2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIpcpis2>(Ipcpis2 + bIpcpis2 + dN[89] - dN[93] - dN[94])){
  exitIpcpis2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIpcs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIpcs2>(Ipcs2 + bIpcs2 + dN[90] - dN[95])){
  exitIpcs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIas2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIas2>(Ias2 + bIas2 + dN[91] - dN[96])){
  exitIas2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIapis2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIapis2>(Iapis2 + bIapis2 + dN[92]- dN[97])){
  exitIapis2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIchpi1s2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIchpi1s2>(Ichpi1s2 + bIchpi1s2 + dN[95] - dN[98])){
  exitIchpi1s2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitIchpi2s2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitIchpi2s2>(Ichpi2s2 + bIchpi2s2 + dN[94] - dN[99])){
  exitIchpi2s2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitAs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitAs2>(As2 + bAs2 + dN[93] + dN[97] + dN[98] + dN[99])){
  exitAs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
  exitRs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  while(exitRs2>(Rs2 + bRs2 + dN[96])){
  exitRs2 = rpois(returning_staff*p_replaced)*switch_new_staff;
  }
}


while ((exitSs2+exitEs2+exitIpcpis2+exitIpcs2+exitIas2+exitIapis2+exitIchpi1s2+exitIchpi2s2+exitAs2+exitRs2)>round(returning_staff*p_replaced)){

  int exits_to_remove;
  exits_to_remove = (exitSs2+exitEs2+exitIpcpis2+exitIpcs2+exitIas2+exitIapis2+exitIchpi1s2+exitIchpi2s2+exitAs2+exitRs2)-round(returning_staff*p_replaced);
  
  //Rprintf(\"%d exits to remove\\n", exits_to_remove);
  
  for (int i = 1; i < (exits_to_remove+1); i++){
  
  int counter = 0;
  
  // make empty vector
  double vect[9];
  //double *vect = &V1;
  int idx_ctr = 0;
  
  if(exitSs2 != 0){
  vect[idx_ctr] = 1;
  //Rprintf(\"print the element of vector corresponding to exitSs2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitEs2 != 0){
  vect[idx_ctr] = 2;
  //Rprintf(\"print the element of vector corresponding to exitEs2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIpcpis2 != 0){
  vect[idx_ctr] = 3;
  //Rprintf(\"print the element of vector corresponding to exitIpcpis2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIpcs2 != 0){
  vect[idx_ctr] = 4;
  //Rprintf(\"print the element of vector corresponding to exitIpcs2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIas2 != 0){
  vect[idx_ctr] = 5;
  //Rprintf(\"print the element of vector corresponding to exitIas2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIapis2 != 0){
  vect[idx_ctr] = 6;
  //Rprintf(\"print the element of vector corresponding to exitIapis2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIchpi1s2 != 0){
  vect[idx_ctr] = 7;
  //Rprintf(\"print the element of vector corresponding to exitIchpi1s2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitIchpi2s2 != 0){
  vect[idx_ctr] = 8;
  //Rprintf(\"print the element of vector corresponding to exitIchpi2s2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitAs2 != 0){
  vect[idx_ctr] = 9;
  //Rprintf(\"print the element of vector corresponding to exitAs2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  if(exitRs2 != 0){
  vect[idx_ctr] = 10;
  //Rprintf(\"print the element of vector corresponding to exitRs2 %f\\n", vect[idx_ctr]);
  idx_ctr += 1;
  counter += 1;
  }
  
  double where_to_put;
  int where_to_put_int;
  int indx_to_put;
  where_to_put = runif(1,counter);
  where_to_put = round(where_to_put);
  where_to_put_int = (int)where_to_put;
  indx_to_put = vect[where_to_put_int-1]; // check this, c++ indexing starts at zero (not sure if this is full on c++?!) so may need to be vect[where_to_put] instead
  
  //Rprintf(\"removing from category %d\\n", indx_to_put);
  
  vect[0] = 0;
  vect[1] = 0;
  vect[2] = 0;
  vect[3] = 0;
  vect[4] = 0;
  vect[5] = 0;
  vect[6] = 0;
  vect[7] = 0;
  vect[8] = 0;
  vect[9] = 0;
  
  //Rprintf(\"exitSs2 pre removal %f\\n", exitSs2);
  
  if (indx_to_put == 1){
    exitSs2 -= 1;
    //Rprintf(\"exitSs2 post removal %f\\n", exitSs2);
  }
  if (indx_to_put == 2){
    exitEs2 -= 1;
  }
  if (indx_to_put == 3){
    exitIpcpis2 -= 1;
  }
  if (indx_to_put == 4){
    exitIpcs2 -= 1;
  }
  if (indx_to_put == 5){
    exitIas2 -= 1;
  }
  if (indx_to_put == 6){
    exitIapis2 -= 1;
  }
  if (indx_to_put == 7){
    exitIchpi1s2 -= 1;
  }
  if (indx_to_put == 8){
    exitIchpi2s2 -= 1;
  }
  if (indx_to_put == 9){
    exitAs2 -= 1;
  }
  if (indx_to_put == 10){
    exitRs2 -= 1;
  }
  
  exits_to_remove -=1;
  //Rprintf(\"%d exits to remove\\n", exits_to_remove);
  
  }

}


//--Numbers in each compartment adjusted
// RESIDENTS
S += bS - dN[0] - dN[1] - dN[2];
E += bE - dN[3] - dN[4] - dN[5] - dN[6] - dN[7] - dN[8] + dN[2];
Ipcpi += bIpcpi - dN[9] - dN[10] - dN[11] - dN[12] - dN[13] + dN[5];
Ipc += bIpc - dN[14] - dN[15] - dN[16] - dN[17] - dN[18] + dN[6];
Ia += bIa - dN[19] - dN[20] - dN[21] + dN[7];
Iapi += bIapi - dN[22] - dN[23] - dN[24] + dN[8];
Ipci += bIpci - dN[25] - dN[26] - dN[27] + dN[11];
Iai += bIai - dN[28] - dN[29] - dN[30] + dN[24];
Ichpi1 += bIchpi1 - dN[31] - dN[32] - dN[33] + dN[17];
Ichpi2 += bIchpi2 - dN[34] - dN[35] - dN[36] + dN[18];
Ichpi3 += bIchpi3 - dN[37] - dN[38] - dN[39] + dN[12];
Ichpi4 += bIchpi4 - dN[40] - dN[41] - dN[42] + dN[13];
Ich += bIch - dN[43] - dN[44] - dN[45] + dN[16];
Ichi1 += bIchi1 - dN[46] - dN[47] - dN[48] +  dN[33];
Ichi2 += bIchi2 - dN[49] - dN[50] - dN[51] + dN[27];
Ichi3 += bIchi3 - dN[52] - dN[53] - dN[54] + dN[39];
Iclpi1 += bIclpi1 - dN[55] - dN[56] - dN[57] + dN[36];
Iclpi2 += bIclpi1 - dN[58] - dN[59] - dN[60] + dN[42];
Icli1 += bIcli1 - dN[61] - dN[62] - dN[63] + dN[48] + dN[51] + dN[54];
Icli2 += bIcli2 - dN[64] - dN[65] - dN[66] + dN[57];
Icli3 += bIcli3 - dN[67] - dN[68] - dN[69] + dN[60] ;
Icl += bIcl - dN[70] - dN[71] - dN[72] + dN[45];
R += bR - dN[73] - dN[74] + dN[21] + dN[30] + dN[63] + dN[66] + dN[69] + dN[72];

//STAFF
Ss += - dN[75];
Es += dN[75] - dN[76] - dN[77] - dN[78] - dN[79];
Ipcpis += dN[76] - dN[80] - dN[81];
Ipcs += dN[77] - dN[82];
Ias += dN[78] - dN[83];
Iapis += dN[79]- dN[84];
Ichpi1s += dN[82] - dN[85];
Ichpi2s += dN[81] - dN[86];
As += dN[80] + dN[84] + dN[85] + dN[86] - dN[87];
Rs += dN[83] + dN[87];

//REPLACEMENT STAFF
Ss2 += bSs2 - dN[88] - exitSs2;
Es2 += bEs2 + dN[88] - dN[89] - dN[90]  - dN[91] - dN[92] - exitEs2;
Ipcpis2 += bIpcpis2 + dN[89] - dN[93] - dN[94] - exitIpcpis2;
Ipcs2 += bIpcs2 + dN[90] - dN[95] - exitIpcs2;
Ias2 += bIas2 + dN[91] - dN[96] - exitIas2;
Iapis2 += bIapis2 + dN[92]- dN[97] - exitIapis2;
Ichpi1s2 += bIchpi1s2 + dN[95] - dN[98] - exitIchpi1s2;
Ichpi2s2 += bIchpi2s2 + dN[94] - dN[99] - exitIchpi2s2;
As2 += bAs2 + dN[93] + dN[97] + dN[98] + dN[99] - exitAs2;
Rs2 += bRs2 + dN[96] - exitRs2;

//number of residents isolated/staff absent
Isolated += bIpci + dN[11] + bIai + dN[24] + bIchi1 +  dN[33] + bIchi2 + dN[27] + bIchi3 + dN[39] + bIcli1 + dN[48] + dN[51] + dN[54] + bIcli2 + dN[57] + bIcli3 + dN[60] + dN[80] + dN[84] + dN[85] + dN[86] + bAs2 + dN[93] + dN[97] + dN[98] + dN[99] ;

//--Counting
TestRes += (S * p_tnc * m_tnc_period)+
(E * p_tnc * m_tnc_period)+(Ipcpi * p_tnc * m_tnc_period)+
(Ipc * p_tnc * m_tnc_period)+
(Ia * p_tnc * m_tnc_period)+
(Iapi * p_tnc * m_tnc_period)+
(Ichpi1 * p_tc * m_tc_period)+
(Ichpi2 * p_tc * m_tc_period)+
(Ichpi3 * p_tc * m_tc_period)+
(Ichpi4 * p_tc * m_tc_period)+
(Ich * p_tc * m_tc_period)+
(Iclpi1 * p_tc * m_tc_period)+
(Iclpi2 * p_tc * m_tc_period)+
(Icl * p_tc * m_tc_period)+
(R * p_tnc * m_tnc_period); //assuming nobody isolated is tested, assuming you can test Icl

TestStaff1 += (Ss * p_tncs * m_tncs_period)+
(Es * p_tncs * m_tncs_period)+
(Ipcpis * p_tncs * m_tncs_period)+
(Ipcs * p_tncs * m_tncs_period)+
(Ias * p_tncs * m_tncs_period)+
(Iapis * p_tncs * m_tncs_period)+
(Rs * p_tncs * m_tncs_period); //assuming nobody isolated is tested, those with clinical not tested

TestStaff2 += (Ss2 * p_tncs * m_tncs_period)+
(Es2 * p_tncs * m_tncs_period)+
(Ipcpis2 * p_tncs * m_tncs_period)+
(Ipcs2 * p_tncs * m_tncs_period)+
(Ias2 * p_tncs * m_tncs_period)+
(Iapis2 * p_tncs * m_tncs_period)+
(Rs2 * p_tncs * m_tncs_period); //assuming nobody isolated is tested, those with clinical not tested

NewIc += bIchpi1  + dN[17] + bIchpi2  + dN[18] +bIchpi3  + dN[12] + bIchpi4 + dN[13] + bIch + dN[16] + bIchi2 + dN[27]; //Counting new cases infectious (symptomatic) in residents, does not include Ichi1, Icli1, Icl

NewIpcIa += bIpcpi + dN[5] + bIpc + dN[6] + bIa + dN[7] + bIapi + dN[8]; //Counting new cases infectious (not symptomatic) in residents, does not include stages Ipci, Iai

NewE += bE + dN[2]; //Counting those newly exposed residents
NewR += bR + dN[21] + dN[30] + dN[63] + dN[66] + dN[69] + dN[72]; //Counting those newly recovered residents

NewAs += dN[80] + dN[84] + dN[85] + dN[86]; //Counting new absences in staff pool1
NewIpcsIas += dN[76] + dN[77] + dN[78] + dN[79]; //Counting new Ipc and Ia in staff pool1
NewEs += dN[75]; //Counting newly exposed staff pool1
NewRs += dN[83] + dN[87]; //Counting newly recovered staff pool1

NewAs2 += dN[93] + dN[97] + dN[98] + dN[99]; //Counting new absences in replacement staff
NewIpcsIas2 += dN[89] + dN[90] + dN[91] + dN[92]; //Counting new Ipc and Ia in replacement staff
NewEs2 += dN[88]; //Counting newly exposed  replacement staff
NewRs2 += dN[96]; //Counting newly recovered replacement staff

totalExits += exits; //conting total exits (deaths and hospitalisations)

totalDeaths += dN[0]+dN[3]+dN[9]+dN[14]+dN[19]+dN[22]+dN[25]+dN[28]+dN[31]+dN[34]+dN[37]+dN[40]+dN[43]+dN[46]+dN[49]+dN[52]+dN[55]+dN[58]+dN[61]+dN[64]+dN[67]+dN[70]+dN[73]; //counting total exits for death (residents)

totalDeathsClinical += dN[31]+dN[34]+dN[37]+dN[40]+dN[43]+dN[46]+dN[49]+dN[52]+dN[55]+dN[58]+dN[61]+dN[64]+dN[67]+dN[70]; // counting total deaths from residents with symptoms
SDeaths += dN[0];
EDeaths += dN[3];
IpcpiDeaths += dN[9];
IpcDeaths += dN[14];
IaDeaths += dN[19];
IapiDeaths += dN[22];
IpciDeaths += dN[25];
IaiDeaths += dN[28];
Ichpi1Deaths += dN[31];
Ichpi2Deaths += dN[34];
Ichpi3Deaths += dN[37];
Ichpi4Deaths += dN[40];
IchDeaths += dN[43];
Ichi1Deaths += dN[46];
Ichi2Deaths += dN[49];
Ichi3Deaths += dN[52];
Iclpi1Deaths += dN[55];
Iclpi2Deaths += dN[58];
Icli1Deaths += dN[61];
Icli2Deaths += dN[64];
Icli3Deaths += dN[67];
IclDeaths += dN[70];
RDeaths += dN[73];

totalHospitalExits += exits_h; //counting total exits for hospitalisation
totalHospitalExitsInfected += dN[4]+dN[10]+dN[15]+dN[20]+dN[23]+dN[26]+dN[29]+dN[32]+dN[35]+dN[38]+dN[41]+dN[44]+dN[47]+dN[50]+dN[53]+dN[56]+dN[59]+dN[62]+dN[65]+dN[68]+dN[71];
totalHospitalExitsInfectious += dN[10]+dN[15]+dN[20]+dN[23]+dN[26]+dN[29]+dN[32]+dN[35]+dN[38]+dN[41]+dN[44]+dN[47]+dN[50]+dN[53]+dN[56]+dN[59]+dN[62]+dN[65]+dN[68]+dN[71];
totalHospitalExitsClinical += dN[32]+dN[35]+dN[38]+dN[41]+dN[44]+dN[47]+dN[50]+dN[53]+dN[56]+dN[59]+dN[62]+dN[65]+dN[68]+dN[71];
SHospitalExits += dN[1];
EHospitalExits += dN[4];
IpcpiHospitalExits += dN[10];
IpcHospitalExits +=  dN[15];
IaHospitalExits += dN[20];
IapiHospitalExits +=  dN[23];
IpciHospitalExits +=  dN[26];
IaiHospitalExits +=  dN[29];
Ichpi1HospitalExits +=  dN[32];
Ichpi2HospitalExits += dN[35];
Ichpi3HospitalExits +=  dN[38];
Ichpi4HospitalExits +=  dN[41];
IchHospitalExits += dN[44];
Ichi1HospitalExits +=  dN[47];
Ichi2HospitalExits +=  dN[50];
Ichi3HospitalExits +=  dN[53];
Iclpi1HospitalExits += dN[56];
Iclpi2HospitalExits +=  dN[59];
Icli1HospitalExits +=  dN[62];
Icli2HospitalExits +=  dN[65];
Icli3HospitalExits +=  dN[68];
IclHospitalExits +=  dN[71];
RHospitalExits +=  dN[74];

totalEntries += bS+bE+bIpcpi+bIpc+bIa+bIapi+bIpci+bIai+bIchpi1+bIchpi2+bIchpi3+bIchpi4+bIch+bIchi1+bIchi2+bIchi3+bIclpi1+bIclpi2+bIcli1+bIcli2+bIcli3+bIcl+bR; //counting total entries

totalEntries_non_hc += HS_non_hc+HE_non_hc+HIpcpi_non_hc+HIpc_non_hc+HIa_non_hc+HIapi_non_hc+HIpci_non_hc+HIai_non_hc+HIchpi1_non_hc+HIchpi2_non_hc+HIchpi3_non_hc+HIchpi4_non_hc+HIch_non_hc+HIchi1_non_hc+HIchi2_non_hc+HIchi3_non_hc+HIclpi1_non_hc+HIclpi2_non_hc+HIcli1_non_hc+HIcli2_non_hc+HIcli3_non_hc+HIcl_non_hc+HR_non_hc; //total entries general admissions

totalEntries_hc += HS_hc+HE_hc+HIpcpi_hc+HIpc_hc+HIa_hc+HIapi_hc+HIpci_hc+HIai_hc+HIchpi1_hc+HIchpi2_hc+HIchpi3_hc+HIchpi4_hc+HIch_hc+HIchi1_hc+HIchi2_hc+HIchi3_hc+HIclpi1_hc+HIclpi2_hc+HIcli1_hc+HIcli2_hc+HIcli3_hc+HIcl_hc+HR_hc; //total entries readmissions after hospital COVID-19

totalEntriesInfected += bE+bIpcpi+bIpc+bIa+bIapi+bIpci+bIai+bIchpi1+bIchpi2+bIchpi3+bIchpi4+bIch+bIchi1+bIchi2+bIchi3+bIclpi1+bIclpi2+bIcli1+bIcli2+bIcli3+bIcl; //counting total entries from hospital of residents infected
totalEntriesInfectious += bIpcpi+bIpc+bIa+bIapi+bIpci+bIai+bIchpi1+bIchpi2+bIchpi3+bIchpi4+bIch+bIchi1+bIchi2+bIchi3+bIclpi1+bIclpi2+bIcli1+bIcli2+bIcli3+bIcl; //counting total entries from hospital of residents infectious
totalEntriesClinical += bIchpi1+bIchpi2+bIchpi3+bIchpi4+bIch+bIchi1+bIchi2+bIchi3+bIclpi1+bIclpi2+bIcli1+bIcli2+bIcli3+bIcl; //counting total entries from hospital of residents infectious

SEntries += bS; 
EEntries += bE;
IpcpiEntries += bIpcpi;
IpcEntries += bIpc;
IaEntries += bIa;
IapiEntries += bIapi;
IpciEntries += bIpci;
IaiEntries += bIai;
Ichpi1Entries += bIchpi1;
Ichpi2Entries += bIchpi2;
Ichpi3Entries += bIchpi3;
Ichpi4Entries += bIchpi4;
IchEntries += bIch;
Ichi1Entries += bIchi1;
Ichi2Entries += bIchi2;
Ichi3Entries += bIchi3;
Iclpi1Entries += bIclpi1;
Iclpi2Entries += bIclpi2;
Icli1Entries += bIcli1;
Icli2Entries += bIcli2;
Icli3Entries += bIcli3;
IclEntries += bIcl;
REntries += bR;

//entries and exits staff
//Ss2Entries += bSs2; 
//Es2Entries += bEs2;
//Ipcpis2Entries += bIpcpis2;
//Ipcs2Entries += bIpcs2;
//Ias2Entries += bIas2;
//Iapis2Entries += bIapis2;
//Ichpi1s2Entries += bIchpi1s2;
//As2Entries += bAs2;
//Rs2Entries += bRs2;

S2Entries += bSs2+bEs2+bIpcpis2+bIpcs2+bIas2+bIapis2+bIchpi1s2+bIchpi2s2+bAs2+bRs2;
S1Exits += NewAs;
S1Entries += NewRs;
S2Exits += exitSs2+exitEs2+exitIpcpis2+exitIpcs2+exitIas2+exitIapis2+exitIchpi1s2+exitIchpi2s2+exitAs2+exitRs2;

//Rprintf(\"%f is time of calculations for each compartment\\n",t);

//Spell it out

//if (t==7){
//Rprintf(\"%d is the value of m_tncs_period\\n",m_tncs_period);
//Rprintf(\"%f is the value of rate 8\\n",rate[8]);
//Rprintf(\"%f is the value of t\\n",t);
//}
//if (t==10){
//Rprintf(\"%d is the value of m_tncs_period\\n",m_tncs_period);
//Rprintf(\"%f is the value of rate 8\\n",rate[8]);
//Rprintf(\"%f is the value of t\\n",t);
//}
//if (t==14){
//Rprintf(\"%d is the value of m_tncs_period\\n",m_tncs_period);
//Rprintf(\"%f is the value of rate 8\\n",rate[8]);
//Rprintf(\"%f is the value of t\\n",t);
//}

//if (t==7){
//Rprintf(\"%f is the value of lambda_s2s\\n",lambda_s2s);
//Rprintf(\"%f is the value of t\\n",t);
//}
//if (t==100){
//Rprintf(\"%f is the value of lambda_s2s\\n",lambda_s2s);
//Rprintf(\"%f is the value of t\\n",t);
//Rprintf(\"%f is the value of zIcl\\n",zIcl);
//}
//if (t==300){
//Rprintf(\"%f is the value of lambda_s2s\\n",lambda_s2s);
//Rprintf(\"%f is the value of t\\n",t);
//}

//if(Ipci+Iai+Ichi2+Ichi1+Icli1+As+As2>=1){
//Rprintf(\"%f is the value of t\\n",t);
//}

if(t==1){
//Rprintf(\"%f is the value of lambda_r2r at t1\\n",lambda_r2r);
//Rprintf(\"%f is the value of gamma_pc at t1\\n",gamma_pc);
//Rprintf(\"%f is the value of tau_i at t1\\n",tau_i);
//Rprintf(\"%f is the value of phi_i_l2 at t1\\n",phi_i_l2);
}
if(t==2){
//Rprintf(\"%f is the value of lambda_r2r at t2\\n",lambda_r2r);
//Rprintf(\"%f is the value of rate[98] at t2\\n",rate[98]);
//Rprintf(\"%f is the value of rate[99] at t2\\n",rate[99]);
//Rprintf(\"%f is the value of rate[100]  at t2\\n",rate[100]);
//Rprintf(\"%f is the value of bSs2  at t2\\n",bSs2);
//Rprintf(\"%f is the value of bIchpi2s2  at t2\\n",bSs2);
//Rprintf(\"%f is the value of bAs2  at t2\\n",bAs2);
//Rprintf(\"%f is the value of gamma_pc at t2\\n",gamma_pc);
//Rprintf(\"%f is the value of tau_i at t2\\n",tau_i);
//Rprintf(\"%f is the value of phi_i_l2 at t2\\n",phi_i_l2);
}
if(t==7){
//Rprintf(\"%f is the value of rate[0] at t7\\n",rate[0]);
//Rprintf(\"%f is the value of rate[1] at t7\\n",rate[1]);
//Rprintf(\"%f is the value of rate[2] at t7\\n",rate[2]);
//Rprintf(\"%f is the value of rate[3]  at t7\\n",rate[3]);
//Rprintf(\"%f is the value of gamma_pc at t7\\n",gamma_pc);
//Rprintf(\"%f is the value of tau_i at t7\\n",tau_i);
//Rprintf(\"%f is the value of phi_i_l2 at t7\\n",phi_i_l2);
//Rprintf(\"%f is the value of l1 at t7\\n",l1);
//Rprintf(\"%f is the value of l2 at t7\\n",l2);
//Rprintf(\"%f is the value of l3 at t7\\n",l3);
//Rprintf(\"%f is the value of l4 at t7\\n",l4);
//Rprintf(\"%f is the value of l5 at t7\\n",l5);
//Rprintf(\"%f is the value of delta at t7\\n",delta);
}
//Rprintf(\"%f is the value of t \\n",t);


'

# The pomp function euler.sim uses the Euler-Maruyama approximation to the full stochastic system. This calculates the number of events happening in a given fixed time step by sampling from a multinomial distribution with the probabilities of each event given by the product of its rate and the time step. Instead of calculating the rates of transition as in the deterministic skeleton, reulermultinom draws random numbers from the compartment specified in the second argument to get the number of individuals who transition from that compartment to another one. These numbers are stored in the array N.