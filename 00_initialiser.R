### INITIALISER
# number of residents taken from mean number of residents THF report for nursing LTCFs and residental LTCFs
# number of staff per resident taken from Easter 6: between 1.2-2.4, not obvious difference by nursing vs residential but none were purely residential, so assuming 2 per resident in NH and 1 per resident in RES.



rinit <- "
S = N_S; //how many people to put in this model?
E = N_E;
Ipcpi = 0; 
Ipc = 0; 
Ia = 0; 
Iapi = 0; 
Ipci = 0; 
Iai = 0; 
Ichpi1 = 0; 
Ichpi2 = 0; 
Ichpi3 = 0; 
Ichpi4 = 0; 
Ich = 0;
Ichi1 = 0;
Ichi2 = 0;
Ichi3 = 0;
Iclpi1 = 0; 
Iclpi2 = 0; 
Icli1 = 0; 
Icli2 = 0; 
Icli3 = 0; 
Icl = 0; 
R = N_R;

Ss = N_Ss;
Es = 0; 
Ipcpis = 0; 
Ipcs = 0; 
Ias = 0; 
Iapis = 0; 
Ichpi1s = 0;
Ichpi2s = 0; 
As = 0; 
Rs = N_Rs;

Ss2 = 0;
Es2 = 0; 
Ipcpis2 = 0; 
Ipcs2 = 0; 
Ias2 = 0; 
Iapis2 = 0; 
Ichpi1s2 = 0;
Ichpi2s2 = 0; 
As2 = 0; 
Rs2 = 0;

NewIc = 0;
NewIpcIa = 0; 
NewE = 0; 
NewR = 0; 
totalExits = 0; 

NewAs = 0; 
NewIpcsIas = 0; 
NewEs = 0; 
NewRs = 0;

NewAs2 = 0; 
NewIpcsIas2 = 0; 
NewEs2 = 0; 
NewRs2 = 0;

totalExits = 0; 
totalDeaths = 0; totalDeathsClinical = 0;
SDeaths = 0; EDeaths = 0; IpcpiDeaths = 0; IpcDeaths = 0; IaDeaths = 0; IapiDeaths = 0; IpciDeaths = 0; IaiDeaths = 0; 
Ichpi1Deaths = 0; Ichpi2Deaths = 0; Ichpi3Deaths = 0; Ichpi4Deaths = 0;
IchDeaths = 0;Ichi1Deaths = 0; Ichi2Deaths = 0; Ichi3Deaths = 0;
Iclpi1Deaths = 0;Iclpi2Deaths = 0;Icli1Deaths = 0;Icli2Deaths = 0;Icli3Deaths = 0;IclDeaths = 0;
RDeaths = 0;

totalHospitalExits = 0; totalHospitalExitsInfected = 0;
totalHospitalExitsInfectious = 0;totalHospitalExitsClinical = 0;
SHospitalExits = 0; EHospitalExits = 0;  
IpcpiHospitalExits = 0; IpcHospitalExits = 0; IaHospitalExits = 0; IapiHospitalExits = 0; 
IpciHospitalExits = 0; IaiHospitalExits = 0; 
Ichpi1HospitalExits = 0; Ichpi2HospitalExits = 0; Ichpi3HospitalExits = 0; Ichpi4HospitalExits = 0;
IchHospitalExits = 0;Ichi1HospitalExits = 0; Ichi2HospitalExits = 0; Ichi3HospitalExits = 0;
Iclpi1HospitalExits = 0;Iclpi2HospitalExits = 0;Icli1HospitalExits = 0;Icli2HospitalExits = 0;Icli3HospitalExits = 0;
IclHospitalExits = 0;
RHospitalExits = 0;

totalEntries = 0;
totalEntries_non_hc = 0;
totalEntries_hc = 0;
totalEntriesInfected = 0; totalEntriesInfectious = 0;totalEntriesClinical = 0;

SEntries = 0; EEntries = 0; IpcpiEntries = 0; IpcEntries = 0; IaEntries = 0; IapiEntries = 0; 
IpciEntries = 0; IaiEntries = 0; 
Ichpi1Entries = 0; Ichpi2Entries = 0; Ichpi3Entries = 0; Ichpi4Entries = 0;
IchEntries = 0;Ichi1Entries = 0; Ichi2Entries = 0; Ichi3Entries = 0;
Iclpi1Entries = 0;Iclpi2Entries = 0;Icli1Entries = 0;Icli2Entries = 0;Icli3Entries = 0;IclEntries = 0;
REntries = 0;
S2Entries = 0; S1Exits = 0; 
S1Entries =0; S2Exits = 0;
TestRes = 0;TestStaff1 = 0;TestStaff2 = 0;
Isolated=0;

"