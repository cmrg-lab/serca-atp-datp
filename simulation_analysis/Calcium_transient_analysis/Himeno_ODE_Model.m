%Code from Himeno et al. 2015 A Human Ventricular Myocyte Model with a
%Refined Representation of Excitation-Contraction Coupling
%The main functions are objective_function and objective_function_plot.
%objective_function returns just the value of the objective function (sum of
%squared error between model and data) for particle swarm optimization.
%objective_function_plot returns calcium transient and whatever other outputs you want 
%(e.g. SERCA flux, membrane voltage).

%the Tran model is found under SERCA near the end of the code. The
%parameters have the same names as in the Tran paper (see Fig 1 in Tran). k1_plus
%and K_dCai are the parameters changed based on the BD results.


%% digitized data from Korte et al.
Korte_ATP = [0.0398683162742719, 0.0374842695578144, 0.0400419776956071, 0.051219201900435, 0.0555643904200561, 0.0695368107845388, 0.0813911969428752, 0.0958652395629928, 0.117149241852033, 0.106466998049767, 0.146976185486712, 0.131832940330332, 0.128387263771034, 0.186533355855542, 0.172527541060571, 0.162417650472866, 0.15762148823769, 0.215225516570817, 0.202331242617138, 0.19674372390385, 0.237668276521546, 0.266340627598075, 0.252197505993853, 0.247895812923471, 0.229628924822415, 0.286729108000093, 0.275902011299317, 0.394194267801149, 0.305719548159143, 0.382014270804253, 0.331942707534958, 0.418919627806023, 0.406281335547966, 0.436661374675349, 0.450164530606395, 0.463124099967184, 0.471578613671251, 0.465836999200559, 0.455467210726048, 0.443414000553368, 0.433159756610929, 0.4234855160923, 0.413645341501925, 0.404501345650574, 0.395647204166688, 0.385548619079882, 0.375137624841664, 0.365371906479416, 0.354147711801149, 0.343094715574262, 0.33095440847746, 0.322442485021422, 0.313509938721484, 0.302785080338125, 0.292791330416734, 0.282424213371934, 0.272885038572089, 0.262199305892735, 0.251183252489569, 0.240136037257374, 0.229764590833281, 0.220610936949301, 0.21016665508575, 0.200881657293884, 0.191102379000434, 0.183808848376529, 0.173609587550823, 0.162792232732971, 0.152955698008911, 0.147710365792984, 0.143973247427134, 0.138998244927072, 0.130188794885626, 0.123746525731854, 0.117958553120305, 0.112423696394381, 0.105654530000745, 0.100575331347532, 0.0952547425140637, 0.0937652541388697, 0.090935841070599, 0.0872927957505125, 0.084441450332319, 0.0797319896240611, 0.0790959086982613, 0.0854838428428751, 0.0828923273463524, 0.0798710027180689, 0.0784126203872088, 0.0792986515024525, 0.070690790457063, 0.0717688058950018, 0.0732666437873644, 0.0650240331887615, 0.0676767784777709, 0.0673735764036011, 0.0640714509039117, 0.0668963987692329, 0.064297068561254, 0.0588206147978267, 0.059268541836138, 0.0605002320474698, 0.0632701980087863, 0.062632360384073, 0.0662535405198074, 0.0687686552056813, 0.0589010539370073, 0.0600738063801612, 0.0629916624820551, 0.0602438527558211, 0.0571834545701025, 0.0531484861765288, 0.0521176442493945, 0.0509010075164548, 0.0515326687093449, 0.0484568721221673, 0.0501133235545795, 0.0543955617042841, 0.059465655927569, 0.0611195333802854, 0.0645198969826452, 0.0618502343712823, 0.0603918520403912, 0.0642865470781743, 0.0637443819787641, 0.0565685371885441, 0.0538513969305804, 0.0578326431723996, 0.0554680296877674, 0.0533792243289039];
Korte_dATP = [0.049816375,    0.046324935,    0.048292583,    0.038665408, 0.057829298,    0.097382778    ,0.044043024    ,0.034827661,    0.073433165    ,0.084141175    ,0.127192482    ,0.114617764    ,0.107740818,    0.155342551,    0.142558959    ,0.136967839,    0.185578977,    0.17088074,    0.165344846    ,0.217098078    ,0.203172852,    0.198011541    ,0.246194487,    0.231333514    ,0.275264899    ,0.25974894    ,0.298987165,    0.2867135,    0.314793867    ,0.329421681,    0.342176687    ,0.353201623,    0.36608865    ,0.377680295,    0.387468525    ,0.399767609    ,0.41233289    ,0.423843344    ,0.433264346,    0.421446585    ,0.407416364,    0.396436088    ,0.385860771    ,0.375836065    ,0.364827608    ,0.352008944    ,0.339162621    ,0.322613768    ,0.308451477    ,0.3333666    ,0.296810613,    0.285763225    ,0.274250303,    0.263645796    ,0.253977972,    0.242407009    ,0.228667977    ,0.215132831,    0.202638059    ,0.190277511,    0.175737583    ,0.164096479    ,0.15390468    ,0.15642584    ,0.160190418,    0.150109833    ,0.140756882    ,0.129197986,    0.116755204    ,0.111839746    ,0.115795857    ,0.107593946    ,0.097866333,    0.092781839    ,0.083588323    ,0.074076609    ,0.064264921    ,0.06791727    ,0.07847834    ,0.090607835,    0.086630466    ,0.081349686,    0.083645555,    0.09023916    ,0.085997171,    0.086558599    ,0.0815004    ,0.071622044,    0.060156319    ,0.04956171    ,0.047384287    ,0.050426731    ,0.059320058    ,0.058460285    ,0.05125366    ,0.049248248    ,0.045601747    ,0.035450228    ,0.029702956    ,0.029455854    ,0.035174081    ,0.045494131    ,0.056635251    ,0.063044499,    0.067339536    ,0.068414311    ,0.059236828    ,0.06073129    ,0.06616939    ,0.077280428    ,0.077761249    ,0.077514147    ,0.076798162    ,0.073350685    ,0.063948033    ,0.055524029    ,0.051496891    ,0.047932597    ,0.055216728    ,0.063305517,    0.060134694    ,0.049289199,    0.040214562    ,0.03933759    ,0.046908442    ,0.044663847,    0.038626421    ,0.027189024,    0.018393344    ,0.016449798,    0.02101582    ,0.031151583    ,0.033739265    ,0.04028132    ,0.036678841    ,0.027274465,    0.021332974    ,0.026044496,    0.031400582,    0.027613369,    0.020866397    ,0.02350409    ,0.02650389    ,0.037678301,    0.046742098    ,0.059352607,    0.069026181    ,0.074962297,    0.070618755    ,0.060197085    ,0.045699214    ,0.055586241,    0.035742407,    0.021519532,    0.014803397,    0.01252729];
time_ATP = [3,20,37,54,78,83,85,87,89,87,92,92,87,97,96,97,92,99,99,99,103,106,104,102,102,107,107,119,112,114,115,124,124,128,132,137,147,163,173,179,187,193,201,209,216,223,226,230,237,247,255,262,272,281,290,300,308,316,324,333,344,354,364,373,382,394,407,418,431,445,461,479,494,503,521,539,550,569,580,597,615,633,653,669,689,706,724,742,761,779,794,812,829,851,875,890,911,930,948,960,978,992,1016,1034,1052,1062,1074,1102,1120,1138,1156,1174,1193,1212,1229,1245,1265,1283,1302,1320,1338,1357,1375,1393,1408,1433,1445,1469,1488,1500];
time_dATP = [6,20,37,53,67,72,66,64,70,74,78,76,76,80,79,76,84,84,83,87,86,84,92,92,96,95,101,96,104,106,108,111,115,122,130,136,142,150,162,173,177,180,184,189,192,197,203,209,212,208,217,224,229,233,231,236,239,242,244,250,255,259,270,288,302,313,318,323,332,334,355,370,380,394,400,404,412,433,447,459,476,496,514,526,544,561,579,588,593,604,623,640,652,667,678,696,714,726,744,762,781,795,809,827,844,860,863,881,900,912,931,949,967,986,998,1009,1027,1039,1053,1069,1085,1091,1100,1116,1134,1151,1156,1164,1174,1192,1209,1227,1244,1260,1273,1277,1287,1302,1322,1340,1354,1370,1389,1404,1413,1418,1424,1437,1448,1449,1458,1456,1471,1477,1490,1501]; 

%% particle swarm optimization
%currently set up for optimizing parameters in the Tran model but this is
%also what I used for the other optimizations
%uncomment either ATP or dATP data within objective_function depending on
%which one you want to optimize
%rng default
%x(1) = 2540; %original = 2540; %k2_plus
%x(2) = 3; %original = 5.35; %k3_plus
%x(3) = 0.1927; %original = 0.1927; %k1_minus
%x(4) = 25435; %original = 25435; %k2_minus
%x(5) = 149; %original = 149 %k3_minus
%fun = @(x)objective_function(x); 
%nvars = 5; %number of variables
%lb = [10 0.01 0.001 100000 1]; %lower bounds
%ub = [10000 100 10 100000 1000]; %upper bounds
%options = optimoptions('particleswarm','SwarmSize',20,'MaxIterations',1000,'Display','iter','FunctionTolerance',1E-6);
%[x,fval,exitflag,output] = particleswarm(fun,nvars,lb,ub,options); 
%[calcium_transient,membrane_voltage,SERCA_flux,SERCA_velocity,XB_Force] = objective_function_plot(47200, x(1), x(2), x(3), x(4), x(5), 0.0023, 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP)


%% Figures for paper
% Fig. 7A
%parameters: x = [k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus,K_dCai, Amp_SERCA, Amp_NaK, Amp_NCX, Amp_PMCA, f_n, time, Korte];
[Wild_type,membrane_voltage_ATP,SERCA_flux_ATP,SERCA_velocity_ATP,XB_force_ATP] = objective_function_plot(25900, 2540, 5.35, 0.1927, 25435, 149, 0.0027, 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP); %wild type
[BrownDye,membrane_voltage_dATP,SERCA_flux_dATP,SERCA_velocity_dATP,XB_force_dATP] = objective_function_plot(35172, 2540, 5.35, 0.1927, 25435, 149, 0.0027*0.7676, 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP); %change kon ATP, KdCai based on BD results
[BrownDye_opt,membrane_voltage_dATP,SERCA_flux_dATP,SERCA_velocity_dATP,XB_force_dATP] = objective_function_plot(35172, 2540, 5.35, 0.1927, 25435, 149, 0.0027*0.59, 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP); %change kon ATP based on BD results, optimized KdCai

figure
hold on
plot(time_ATP,Korte_ATP,'color',[0.2, 0.1333, 0.5333],'linestyle',':','linewidth',3)
plot(time_dATP,Korte_dATP,'color',[0.27, 0.67, 0.60],'linestyle',':','linewidth',3)
plot(time_dATP,Wild_type,'linewidth',3,'color',[0.2, 0.1333, 0.5333])
plot(time_dATP,BrownDye,'linewidth',3,'color',[0.27, 0.67, 0.60])
plot(time_dATP,BrownDye_opt,'linewidth',3,'color',[0.27, 0.67, 0.60],'linestyle','--')
xlabel('Time (ms)')
ylabel('Calcium concentration (\muM)')
legend('ATP data','dATP data','ATP model','dATP model 24% decrease K_{d,Cai}','dATP model 41% decrease K_{d,Cai}')


% Fig. 7B
percent_decrease = [0:0.01:0.9];
for j = 1:length(percent_decrease)
%parameters: x = [k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus,K_dCai, Amp_SERCA, Amp_NaK, Amp_NCX, Amp_PMCA, f_n, time, Korte];
[Wild_type,membrane_voltage_ATP,SERCA_flux_ATP,SERCA_velocity_ATP,XB_force_ATP] = objective_function_plot(25900, 2540, 5.35, 0.1927, 25435, 149, 0.0027, 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP); %wild type
[BrownDye,membrane_voltage_dATP,SERCA_flux_dATP,SERCA_velocity_dATP,XB_force_dATP] = objective_function_plot(35172, 2540, 5.35, 0.1927, 25435, 149, 0.0027*(1-percent_decrease(j)), 94.47, 17.77, 128.52, 0.19, 1.37, time_dATP, Korte_dATP); %change kon ATP, KdCai based on BD results

%calculate DT50 and DT90 
[min_Ca,idx_min] = min(BrownDye);
[max_Ca,idx_max] = max(BrownDye);
TTP = time_dATP(idx_max);
DT50 = (max(BrownDye)-min(BrownDye))*0.5 + min(BrownDye);
time_DT50 = 0;
for i = idx_max:length(BrownDye)
    if BrownDye(i) < DT50
        time_DT50 = (time_dATP(i)+time_dATP(i-1))/2;
        time_DT50 = time_DT50;
        break
    end
end

DT50_store(j) = time_DT50;

DT90 = (max(BrownDye)-min(BrownDye))*0.1 + min(BrownDye);
time_DT90 = 0;
for i = idx_max:length(BrownDye)
    if BrownDye(i) < DT90
        time_DT90 = (time_dATP(i)+time_dATP(i-1))/2;
        time_DT90 = time_DT90;
        break
    end
end

DT90_store(j) = time_DT90;

end

figure
hold on
plot(percent_decrease*100,DT50_store,'linewidth',3,'color',[0 0 0])
yline(320,'linewidth',3,'color',[0.2, 0.1333, 0.5333],'linestyle',':')
yline(240.5,'linewidth',3,'color',[0.27, 0.67, 0.60],'linestyle',':')
ylim([120 340])
xlabel('Percent decrease K_{d,Cai}')
ylabel('DT50 (ms)')
legend('ATP data','dATP data','Model')
%% function definitions
function [SSE_tot] = objective_function(x) %calculate objective function (SSE btw model and data) for given parameter value(s)
%parameters have to be reset each time the function is run
SSE_tot = 0; %initialize
Amp_PMCA = 0.19; %original 0.19
Amp_SERCA = 94.47; %original (optimized to WT ATP Korte data) 94.47
Amp_NCX = 128.52; %original (optimized to WT ATP Korte data) 128.52
Amp_NaK = 17.77; %original (optimized to WT ATP Korte data) 17.77
f_n = 1.37; %original (optimized to WT ATP Korte data) 1.37
K_dCai = 0.0023; %orig = 0.0027 Kd for Ca2+ binding to SERCA %changed based on BD results
K_dCasr = 1.378; %orig = 1.378 Kd for Ca2+ release into SR
k_on_CSQN = 100; %orig = 100 association rate calsequestrin
K_d_MgATP = 0.6; %orig = 0.6 Kd for ATP binding to NaK
K_m = 0.0005; %orig = 0.0005 used in calculating I_PMCA (Ca2+ association)
Yb = 0.1816; %orig = 0.1816 rate constant for contraction model
k1_plus = 47200; %orig = 25900 rate constant for ATP binding to SERCA %changed based on BD results
k2_plus = x(1); %orig = 2540
k3_plus = x(2); %orig = 5.35
k1_minus = x(3); %orig = 0.1927
k2_minus = x(4); %orig = 25435
k3_minus = x(5); %orig = 149

%I didn't change any of these from original values in Himeno model
Vm = -91.4466885079348; %orig = -91.4466885079348 */ %membrane voltage*/
R = 8.3143; %gas constant*/
T = 310; %temperature*/
F = 96.4867; %Faraday constant*/
dCaMCadt = 0; %rate of change of Calmodulin-Ca complex*/
k_on_CaM = 34; %association rate Calmodulin*/
Ca_2_blk = 0;    %Ca concentration in bulk space*/
B_tot_CaM = 0.024; %total buffer concentration of Calmodulin*/
CaMCa = 0.000228581865602447; %concentration of Calmodulin-Ca*/
k_off_CaM = 0.238; %dissociation rate Calmodulin*/
dTnChCadt = 0; %rate of change of high affinity troponin C-Ca complex*/
k_on_TnCh = 2.37; %association rate of Ca to high affinity troponin C*/
B_tot_TnCh = 0.12; %total buffer concentration of high affinity troponin C*/
TnChCa = 0.110742559707052; %concentration of high affinity troponin C-Ca*/
k_off_TnCh = 0.000032; %dissociation rate high affinity troponin C*/
dSRCadt = 0; %rate of change of Ca buffer by SR membrane-Ca complex*/
k_on_SR = 100; %association rate SR*/
B_tot_SR = 0.0171; %total buffer concentration on SR membrane*/
SRCa = 0.00172960014640511; %concentration of Ca buffer SR membrane-Ca*/
k_off_SR = 0.06; %dissociation rate SR buffer*/
L_free_iz = 0; %free low affinity sarcolemmal Ca buffer intermediate zone*/
L_bound_iz = 0.0075621764602356; %bound low affinity sarcolemmal Ca buffer intermediate zone*/
B_tot_L_iz = 0.6078; %total low affinity sarcolemmal Ca buffer intermediate zone*/
Ca_2_iz = 0; %Ca concentration in intermediate zone*/
k_off_L_iz = 1.3; %dissociation rate low affinity sarcolemmal Ca buffer intermediate zone*/
k_on_L_iz = 100; %association rate low affinity sarcolemmal Ca buffer intermediate zone*/
K_dL_iz = 0; %Kd low affinity sarcolemmal Ca buffer intermediate zone*/
H_free_iz = 0; %free high affinity sarcolemmal Ca buffer intermediate zone*/
H_bound_iz = 0.0769149150028914; %bound high affinity sarcolemmal Ca buffer intermediate zone*/
B_tot_H_iz = 0.2178; %total high affinity sarcolemmal Ca buffer intermediate zone*/
k_off_H_iz = 0.03; %dissociation rate high affinity sarcolemmal Ca buffer intermediate zone*/
k_on_H_iz = 100; %association rate high affinity sarcolemmal Ca buffer intermediate zone*/
K_dH_iz = 0; %Kd high affinity sarcolemmal Ca buffer intermediate zone*/
Ca_2_tot_iz = 0.084640522722006; %total Ca concentration in intermediate zone*/
L_free_jnc = 0; %free low affinity sarcolemmal Ca buffer junctional space*/
B_tot_L_jnc = 1.1095; %total low affinity sarcolemmal Ca buffer junctional space*/
Ca_2_jnc = 0; %Ca concentration in junctional space*/
k_off_L_jnc = 1.3; %dissociation rate low affinity sarcolemmal Ca buffer junctional space*/
k_on_L_jnc = 100; %association rate low affinity sarcolemmal Ca buffer junctional space*/
K_dL_jnc = 0; %Kd low affinity sarcolemmal Ca buffer junctional space*/
H_free_jnc = 0; %free high affinity sarcolemmal Ca buffer junctional space*/
B_tot_H_jnc = 0.398; %total high affinity sarcolemmal Ca buffer junctional space*/
k_off_H_jnc = 0.03; %dissociation rate high affinity sarcolemmal Ca buffer junctional space*/
k_on_H_jnc = 100; %association rate rate high affinity sarcolemmal Ca buffer junctional space*/
K_dH_jnc = 0; %Kd high affinity sarcolemmal Ca buffer junctional space*/
Ca_2_tot_jnc = 0.207176351449979; %total Ca concentration in junctional space*/
B_tot_CSQN = 3; %total buffer concentration of calsequestrin*/
Ca_2_tot_SRrl = 2.21876221622152; %total Ca concentration in SRrl*/
k_off_CSQN = 65; %dissociation rate calsequestrin*/
K_d_CSQN_Ca = 0; %Kd calsequestrin*/
Ca_2_SRrl = 0; %Ca concentration in SRrl*/
J_Ca_jnciz = 0; %flux of Ca from junctional space to intermediate zone*/
G_dCa_jnciz = 3395.88; %conductance of above current*/
Sc_Cell = 1; %scaling factor (Sc_cell = Cm/Cstd (relationship btw cell volume and membrane capacitance)*/
J_Ca_izblk = 0; %flux of Ca from intermediate zone to bulk space*/
G_dCa_izblk = 3507.78; %conductance of above current*/
J_trans_SR = 0; %flux between SRup and SRrl*/
P_trans = 4.8037; %conductance of trans-SR?*/
Ca_2_SRup = 0.761077662687456; %Ca concentration in SRup*/
alpha_plus = 0; %rate constant for L type Ca channels*/
alpha_minus = 0; %rate constant for L type Ca channels*/
epsilon_plus_iz = 0; %rate constant for L type Ca channels*/
epsilon_plus_blk = 0; %rate constant for L type Ca channels*/
epsilon_plus_iz_loc = 0; %rate constant for L type Ca channels*/
epsilon_plus_blk_loc = 0; %rate constant for L type Ca channels*/
epsilon_minus = 0; %rate constant for L type Ca channels*/
Ca_2_iz_loc = 0;
Ca_2_blk_loc = 0;
T_L = 147.51; %inactivation time L type Ca channels*/
K_L = 0.0044; %conc at inactivation L type Ca channels*/
ATPfactor = 0; %part of ICaL calculation*/
ATP = 6; %ATP conc (mM)*/
p_O_LCC = 0; %probability of L type Ca channels (both Ca and Vm gated) being open*/
P_CaL_Ca = 14.21; %conversion factor for GHK*/
P_CaL_Na = 0; %conversion factor for GHK*/
P_CaL_K = 0; %conversion factor for GHK*/
GHK_Ca_LR = 0; %Goldman Hodgkin Katz Ca L type Ca channels and RyR both open*/
GHK_Ca_L0 = 0; %Goldman Hodgkin Katz Ca L type Ca channels open, RyR closed*/
GHK_Ca_iz = 0; %Goldman Hodgkin Katz Ca intermediate zone*/
GHK_Ca_blk = 0; %Goldman Hodgkin Katz Ca bulk space*/
GHK_Na = 0; %Goldman Hodgkin Katz Na*/
GHK_K = 0; %Goldman Hodgkin Katz K*/
Ca_2_nd_LR = 0; %Ca conc in nanodomain L type Ca channels and RyR both open*/
Ca_2_nd_L0 = 0; %Ca conc in nanodomain L type Ca channels open, RyR closed*/
Cao = 1.8; %extracellular Ca*/
Nao = 140; %extracellular Na*/
Ko = 4.5; %extracellular K*/
Nai = 6.66894310282034; %intracellular Na*/
Ki = 139.238265011042; %intracellular K*/
I_CaL_Ca_blk = 0; %interaction between L type Ca channel current and Ca bulk space*/
I_CaL_Ca_iz = 0; %interaction between L type Ca channel current and Ca intermediate zone*/
I_CaL_Ca_LR = 0; %interaction between L type Ca channel current and Ca nd both L type Ca channels and RyR closed*/
I_CaL_Ca_L0 = 0; %interaction between L type Ca channel current and Ca nd L type Ca channels open RyR closed*/
I_CaL_Na_blk = 0; %interaction between L type Ca channel current and Na bulk space*/
I_CaL_Na_iz = 0; %interaction between L type Ca channel current and Na intermediate zone*/
I_CaL_Na_jnc = 0; %interaction between L type Ca channel current and Ca junctional space*/
I_CaL_K_blk = 0; %interaction between L type Ca channel current and K bulk space*/
I_CaL_K_iz = 0; %interaction between L type Ca channel current and K intermediate zone*/
I_CaL_K_jnc = 0; %interaction between L type Ca channel current and Ca junctional space*/
f_CaL_blk = 0.1; %fraction of L type Ca channels in bulk space*/
f_CaL_iz = 0.15; %fraction of L type Ca channels in intermediate zone*/
f_CaL_jnc = 0.75; %fraction of L type Ca channels in junctional space*/
I_CaL = 0; %L type Ca channel current*/
I_Na = 0; %Na current*/
I_NaT = 0; %transient Na current*/
I_NaL = 0; %late Na current*/
k_OC = 0; %rate constant in Na current*/
p_O_NaT = 0.000000706725155695262; %probability of NaT being open*/
k_I2C = 0; %rate constant in Na current*/
p_I_2_NaT = 0.0117704053067285; %probability of NaT being in I2 state*/
k_Isb = 0; %rate constant in Na current*/
p_I_s_NaT = 0.304002781414015; %probability of NaT being in Is state*/
k_Isf = 0; %rate constant in Na current*/
f_C_Na = 0; %instantaneous conversion between C1 and C2 in Na current*/
k_C2O = 0; %rate constant in Na current*/
p_C_NaT = 0; %probability of NaT being in closed state*/
k_OI2 = 0; %rate constant in Na current*/
k_I2O = 0.0001312; %rate constant in Na current*/
k_C2I2 = 0; %rate constant in Na current*/
k_I1I2 = 0.00534; %rate constant in Na current*/
k_OI1 = 0; %rate constant in Na current*/
k_I1O = 0.01; %rate constant in Na current*/
k_I1C = 0; %rate constant in Na current*/
k_C2I1 = 0; %rate constant in Na current*/
f_LSM = 0.13125; %fraction of Na channels?*/
P_Na = 8.1072; %conversion factor for GHK*/
dp_O_NaTdt = 0; %rate of change of open state NaT*/
dp_I_2_NaTdt = 0; %rate of change of I2 state NaT*/
dp_I_s_NaTdt = 0; %rate of change of Is state NaT*/
p_O_NaL = 0.00000295214591324261; %rate of change of open state NaL*/
p_I_1_NaL = 0.00254273877063925; %rate of change of I1 state NaL*/
p_I_2_NaL = 0.0118261382165599; %rate of change of I2 state NaL*/
p_I_s_NaL = 0.303220346353844; %rate of change of Is state NaL*/
dp_O_NaLdt = 0; %rate of change of open state NaL*/
p_C_NaL = 0; %rate of change of closed state NaL*/
dp_I_1_NaLdt = 0; %rate of change of I1 state NaL*/
dp_I_2_NaLdt = 0; %rate of change of I2 state NaL*/
dp_I_s_NaLdt = 0; %rate of change of Is state NaL*/
alpha_Mg = 0; %reverse rate constant for Mg IK1*/
E_K = 0; %Nernst K*/
E_Ca_jnc = 0; %Nernst Ca junctional space*/
E_Ca_blk = 0; %Nernst Ca bulk space*/
E_Ca_iz = 0; %Nernst Ca intermediate zone*/
E_Na = 0; %Nernst Na*/
beta_Mg = 0; %forward rate constant for Mg IK1*/
Mg_2_cyt = 0.8; %cytosolic Mg conc*/
f_O = 0; %fraction open K1 channels*/
f_B = 0; %fraction closed K1 channels*/
po_Mg = 0; %probability of all Mg open*/
po_Mg1 = 0; %probability of Mg1 open*/
po_Mg2 = 0; %probability of Mg2 open*/
alpha_SPM = 0; %forward rate constant for spermine IK1*/
beta_SPM = 0; %reverse rate constant for spermine IK1*/
SPM = 5.0; %spermine conc*/
G_K1 = 1.353; %K1 conductance*/
f_mode1 = 0.9; %used in calculating K1 current*/
dPb_spmdt = 0; %used in calculating K1 current*/
Pb_spm = 0.594875991179992; %used in calculating K1 current*/
po_mode1 = 0; %mode 1 IK1*/
po_mode2 = 0; %mode 2 IK1*/
p_O_K1 = 0; %probability of K1 being open*/
chi_K1 = 0; %used in calculating K1 current*/
I_K1 = 0; %inward rectifier K current*/
chi_r_infinity = 0; %used in calculating delayed rectifier K current, fast*/
tau_chi_r_fast = 0; %used in calculating delayed rectifier K current, fast*/
tau_chi_r_slow = 0; %used in calculating delayed rectifier K current, fast*/
A_chi_r_fast = 0; %used in calculating delayed rectifier K current, fast*/
A_chi_r_slow = 0; %used in calculating delayed rectifier K current, fast*/
dchi_r_fastdt = 0; %used in calculating delayed rectifier K current, fast*/
chi_r_fast = 0.00000486210633393005; %used in calculating delayed rectifier K current, fast*/
dchi_r_slowdt = 0; %used in calculating delayed rectifier K current, fast*/
chi_r_slow = 0.437041249050081; %used in calculating delayed rectifier K current, fast*/
chi_r = 0; %used in calculating delayed rectifier K current, fast*/
R_Kr = 0; %used in calculating delayed rectifier K current, fast*/
p_O_Kr = 0; %probability of Kr being open*/
G_Kr = 0.0166; %Kr conductance*/
chi_Kr = 0; %used in calculating delayed rectifier K current, fast*/
I_Kr = 0; %fast K rectifier current*/
f_Ks_iz = 0.1; %fraction of slow rectifier K current in intermediate zone*/
f_Ks_blk = 0.9; %fraction of slow rectifier K current in bulk space*/
P_Ks_K = 0.002782; %conversion factor for GHK*/
P_Ks_Na = 0; %conversion factor for GHK*/
para_Xs1_infinity = 0; %used incalculating delayed rectifier K current, slow*/
tau_Xs1 = 0; %used incalculating delayed rectifier K current, slow*/
dpara_Xs1dt = 0; %used incalculating delayed rectifier K current, slow*/
para_Xs1 = 0.277482694590328; %used incalculating delayed rectifier K current, slow*/
para_Xs2_infinity = 0; %used incalculating delayed rectifier K current, slow*/
para_Xs2 = 0.000131110342877451; %used incalculating delayed rectifier K current, slow*/
tau_Xs2 = 0; %used incalculating delayed rectifier K current, slow*/
dpara_Xs2dt = 0; %used incalculating delayed rectifier K current, slow*/
para_RKs_blk = 0; %used incalculating delayed rectifier K current, slow*/
para_RKs_iz = 0; %used incalculating delayed rectifier K current, slow*/
p_O_Ks_blk = 0; %probability of Ks being open bulk space*/
p_O_Ks_iz = 0; %probability of Ks being open intermediate zone*/
I_Ks_K_blk = 0; %interaction of Ks current with K bulk space*/
I_Ks_K_iz = 0; %interaction of Ks current with K intermediate zone*/
I_Ks_Na_blk = 0; %interaction of Ks current with Na bulk space*/
I_Ks_Na_iz = 0; %interaction of Ks current with Na intermediate zone*/
I_Ks = 0; %Ks (slow rectifier K) current*/
a_infinity = 0; %used in calculating transient outward K current*/
tau_a = 0; %used in calculating transient outward K current*/
dadt = 0; %used in calculating transient outward K current*/
a = 0.000793627635934239; %used in calculating transient outward K current*/
i_infinity = 0; %used in calculating transient outward K current*/
tau_i_fast = 0; %used in calculating transient outward K current*/
tau_i_slow = 0; %used in calculating transient outward K current*/
A_i_fast = 0; %used in calculating transient outward K current*/
A_i_slow = 0; %used in calculating transient outward K current*/
di_fastdt = 0; %used in calculating transient outward K current*/
i_fast = 0.999756080468878; %used in calculating transient outward K current*/
di_slowdt = 0; %used in calculating transient outward K current*/
i_slow = 0.575995954010486; %used in calculating transient outward K current*/
i = 0; %used in calculating transient outward K current*/
p_O_Kto = 0; %probability of Kto being open*/
G_Kto = 0.0312; %conductance of Kto*/
I_Kto = 0; %transient outward K current*/
p_O_Kpl = 0; %used in calculating transient outward K current*/
chi_Kpl = 0; %used in calculating transient outward K current*/
P_Kpl = 0.0000172; %conversion factor for GHK*/
I_Kpl = 0; %vontage dependent potassium current*/
f_Cab_blk = 0.9; %background calcium current*/
P_Cab = 0.00006822; %conversion factor for GHK*/
I_Cab_blk = 0; %background Ca current bulk space*/
f_Cab_iz = 0.1; %fraction of ICab intermediate zone*/
I_Cab_iz = 0; %bacgkround Ca current intermediate zone*/
I_Cab = 0; %background Ca current*/
P_bNSC_K = 0.00014; %non-selective background cation current K conversion factor for GHK*/
I_bNSC_K = 0; %non-selective background cation current K*/
P_bNSC_Na = 0.00035; %non-selective background cation current Na conversion factor for GHK*/
I_bNSC_Na = 0; %non-selective background cation current Na*/
I_bNSC = 0; %nonselective background cation current*/
p_O_blk = 0; %probability of being open Ca activated background cation current bulk space*/
p_O_iz = 0; %probability of being open Ca activated background cation current intermediate zone*/
f_l_Ca_blk = 0.9; %fraction of Ca activated background cation current bulk space*/
P_l_Ca_Na = 0.00273; %Ca activated bacgkround cation current Na conversion factor for GHK*/
I_l_Ca_Na_blk = 0; %Ca activated background cation current Na bulk space*/
f_l_Ca_iz = 0.1; %fraction of Ca activated background cation current bulk space*/
I_l_Ca_Na_iz = 0; %Ca activated background cation current Na intermediate zone*/
P_l_Ca_K = 0; %conversion factor for GHK*/
I_l_Ca_K_blk = 0; %Ca activated background cation current K bulk space*/
I_l_Ca_K_iz = 0; %Ca activated background cation current K intermediate zone*/
I_l_Ca = 0; %Ca activated background cation current*/
ATP_cyt = 6.67701543987464; %cytosolic ATP conc*/
p_O_KATP = 0; %probability of being open ATP sensitive K current*/
chi_KATP = 0; %used in calculating KATP*/
G_KATP = 17.674; %KATP conductance*/
I_KATP = 0; %ATP sensitive K current*/
delta_Nai = -0.14; %used in calculating NaK*/
K_d_Nai_0 = 5; %used in calculating NaK*/
K_d_Nai = 0; %used in calculating NaK*/
Nai_bar = 0; %Na conc intracellular over Kd_nai*/
delta_Nao = 0.44; %used in calculating NaK*/
K_d_Nao_0 = 26.8; %used in calculating NaK*/
K_d_Nao = 0; %used in calculating NaK*/
Nao_bar = 0; %Na conc extracellular over Kd_nao*/
delta_Ki = -0.14; %used in calculating NaK*/
K_d_Ki_0 = 18.8; %used in calculating NaK*/
K_d_Ki = 0; %used in calculating NaK*/
Ki_bar = 0; %used in calculating NaK*/
delta_Ko = 0.23; %used in calculating NaK*/
K_d_Ko_0 = 0.8; %used in calculating NaK*/
K_d_Ko = 0; %used in calculating NaK*/
Ko_bar = 0; %used in calculating NaK*/
MgATP_cyt = 6.631643709767415; %concentration of MgATP in cytosol*/
MgATP_bar = 0; %MgATP conc over Kd_MgATP*/
k_1_plus = 0.72; %used in calculating NaK*/
k_1_minus = 0.08; %used in calculating NaK*/
k_2_plus = 0.08; %used in calculating NaK*/
k_2_minus = 0.008; %used in calculating NaK*/
k_3_plus = 4; %used in calculating NaK*/
k_3_minus = 8000; %used in calculating NaK*/
k_4_plus = 0.3; %used in calculating NaK*/
k_4_minus = 0.2; %used in calculating NaK*/
alpha_1_plus = 0; %used in calculating NaK*/
alpha_2_plus = 0; %used in calculating NaK*/
alpha_3_plus = 0; %used in calculating NaK*/
alpha_4_plus = 0; %used in calculating NaK*/
alpha_1_minus = 0; %used in calculating NaK*/
alpha_2_minus = 0; %used in calculating NaK*/
Pi = 0.50872066859173026; %Pi conc in cytosol*/
H = 0.0001; %H conc in cytosol*/
alpha_3_minus = 0; %used in calculating NaK*/
alpha_4_minus = 0; %used in calculating NaK*/
dP_7dt = 0; %used in calculating NaK*/
P_7 = 0.0831770174499825; %used in calculating NaK*/
P_8_13 = 0.281082409575779; %used in calculating NaK*/
P_1_6 = 0.435289193632868; %used in calculating NaK*/
P_14_15 = 0; %used in calculating NaK*/
dP_8_13dt = 0; %used in calculating NaK*/
dP_1_6dt = 0; %used in calculating NaK*/
V_step1 = 0; %used in calculating NaK*/
V_step2 = 0; %used in calculating NaK*/
V_step3 = 0; %used in calculating NaK*/
V_step4 = 0; %used in calculating NaK*/
v_cyc_NaK = 0; %turnover rate for NaK*/
I_NaK = 0; %NaK chrrent*/
Stoi_NaK_Na = 3; %used in calculating NaK*/
Stoi_NaK_K = -2; %used in calculating NaK*/
I_NaK_Na = 0; %effect of NaK current on Na*/
I_NaK_K = 0; %effect of NaK current on K*/
f_Caina_blk = 0; %used in calculating NCX*/
K_m_act = 0.004; %used in calculating NCX*/
alpha_1_on = 0.002; %used in calculating NCX*/
alpha_1_off = 0.0015; %used in calculating NCX*/
alpha_2_on = 0.00006; %used in calculating NCX*/
alpha_2_off = 0.02; %used in calculating NCX*/
beta_1_on = 0.0012; %used in calculating NCX*/
beta_1_off = 0.0000005; %used in calculating NCX*/
beta_2_on = 0.18; %used in calculating NCX*/
beta_2_off = 0.0002; %used in calculating NCX*/
K_m_Nai = 20.74854; %used in calculating NCX*/
K_m_Nao = 87.5; %used in calculating NCX*/
K_m_Cai = 0.0184; %used in calculating NCX*/
K_m_Cao = 1.38; %used in calculating NCX*/
q_blk_E_1_Na = 0; %used in calculating NCX*/
alpha_1_blk = 0; %used in calculating NCX*/
f_Caina_iz = 0; %used in calculating NCX*/
q_iz_E_1_Na = 0; %used in calculating NCX*/
alpha_1_iz = 0; %used in calculating NCX*/
beta_1_blk = 0; %used in calculating NCX*/
beta_1_iz = 0; %used in calculating NCX*/
alpha_2_blk = 0; %used in calculating NCX*/
alpha_2_iz = 0; %used in calculating NCX*/
beta_2_blk = 0; %used in calculating NCX*/
beta_2_iz = 0; %used in calculating NCX*/
k_1 = 0; %used in calculating NCX*/
k_2 = 0; %used in calculating NCX*/
k_3 = 1.0; %used in calculating NCX*/
k_4 = 1.0; %used in calculating NCX*/
q_blk_E_1_Ca = 0; %used in calculating NCX*/
q_iz_E_1_Ca = 0; %used in calculating NCX*/
q_E_2_Na = 0; %used in calculating NCX*/
q_E_2_Ca = 0; %used in calculating NCX*/
alpha_E = 0; %used in calculating NCX*/
beta_E_blk = 0; %used in calculating NCX*/
beta_E_iz = 0; %used in calculating NCX*/
p_E_1_NCX_blk = 0.111872123711613; %used in calculating NCX*/
p_I_2_NCX_blk = 0.684869019924837; %used in calculating NCX*/
p_I_1_NCX_blk = 0.203023555446362; %used in calculating NCX*/
p_E_2_NCX_blk = 0; %used in calculating NCX*/
dp_E_1_NCX_blkdt = 0; %used in calculating NCX*/
dp_I_1_NCX_blkdt = 0; %used in calculating NCX*/
dp_I_2_NCX_blkdt = 0; %used in calculating NCX*/
p_E_2_NCX_iz = 0; %used in calculating NCX*/
p_E_1_NCX_iz = 0.238718640001014; %used in calculating NCX*/
p_I_1_NCX_iz = 0.13771129457898; %used in calculating NCX*/
p_I_2_NCX_iz = 0.622892868847556; %used in calculating NCX*/
dp_E_1_NCX_izdt = 0; %used in calculating NCX*/
dp_I_1_NCX_izdt = 0; %used in calculating NCX*/
dp_I_2_NCX_izdt = 0; %used in calculating NCX*/
v_cyc_NCX_blk = 0; %turnover rate for NCX bulk space*/
v_cyc_NCX_iz = 0; %turnover rate for NCX intermediate zone*/
f_NCX_blk = 0.9; %fraction of NCX in bulk space*/
I_NCX_blk = 0; %NCX current bulk space*/
f_NCX_iz = 0.1; %fraction of NCX in intermediate zone*/
I_NCX_iz = 0; %NCX current intermediate zone*/
I_NCX = 0; %NCX current*/
I_NCX_Na_blk = 0; %interaction of NCX current with Na bulk space*/
I_NCX_Na_iz = 0; %interaction of NCX current with Na intermediate zone*/
I_NCX_Ca_blk = 0; %interaction of NCX current with Ca bulk space*/
I_NCX_Ca_iz = 0; %interaction of NCX current with Ca intermediate zone*/
f_PMCA_blk = 0.9; %fraction of PMCA in bulk space*/
f_PMCA_iz = 0.1; %fraction of PMCA in intermediate zone*/
I_PMCA_blk = 0; %PMCA current bulk space*/
I_PMCA_iz = 0; %PMCA current intermediate zone*/
I_PMCA = 0; %PMCA current*/
p_O_RyR = 0; %probability of RyR being open*/
Ca_2_nd_00 = 0; %Ca conc in nanodomain both L type Ca channels and RyR open*/
delta_RTF = 1; %width of opening potentials L type Ca current?*/
J_L = 0.000913; %permeability of LCC*/
J_R = 0.02; %permeability of RyR*/
g_D = 0.065; %Ca flux rate from nd to jnc*/
f_L = 0; %used in calculating CaLO (=J_L/g_D); conductivity ratio between influx and efflux*/
f_R = 0; %used i n calculating CaOR (=J_R/g_D); conductivity ratio between influx and efflux*/
Ca_2_nd_0R = 0; %Ca conc in nanodomain L type Ca channels closed RyR open*/
Q_10 = 3; %temperature factor*/
k_co_L0 = 0; %opening rate of RyR with LCC open, RyR closed*/
k_co_00 = 0; %opening rate of RyR with LCC and RyR closed*/
k_oc = 0; %closing rate constant of RyR*/
f_t_00 = 0; %probability of triggered state for RyR with LCC and RyR closed*/
f_t_L0 = 0; %probability of triggered state for RyR with LCC open, RyR closed*/
sloc0 = 0.1;
k_rco_0 = 0; %forward rate of regenerative step, LCC closed*/
k_rco_L = 0; %forward rate of regenerative step, LCC open*/
N_RyR = 10; %number of RyR in couplon*/
p_C_0 = 0; %probability of L type Ca channels open, RyR closed*/
p_C_L = 0; %probability of L type channels open, RyR open*/
k_roc_0 = 0; %reverse rate of regenerative step, LCC closed*/
k_roc_L = 0; %reverse rate of regenerative step, LCC open*/
k_co_0R = 0; %closing rate of RyR with LCC closed, RyR open*/
k_co_LR = 0; %closing rate of RyR with LCC and RyR open*/
epsilon_plus_00 = 0; %rate constant for couplon*/
epsilon_plus_L0 = 0; %rate constant for couplon*/
epsilon_plus_0R = 0; %rate constant for couplon*/
epsilon_plus_LR = 0; %rate constant for couplon*/
Y_ooo = 0.00000172489315884865; %probability of ooo state (L, Ca, RyR open)*/
Y_ooc = 0.00000142034754677507; %probability of ooc state (L, Ca open, RyR closed)*/
Y_occ = 0.0000000249594301562175; %probability of occ state (L open, Ca, RyR closed)*/
Y_coc = 0.992110534408681; %probability of coc state (L closed, Ca open, RyR closed)*/
Y_ccc = 0; %probability of ccc state (L, Ca, RyR closed)*/
Y_coo = 0.0000138422676498755; %probability of coo state (L closed, Ca RyR open)*/
Y_cco = 0.0000000953816272498217; %probability of cco state (L, Ca closed, RyR open)*/
Y_oco = 0.00000000000156949238162028; %probability of oco state (L open, Ca closed, RyR open)*/
dY_ooodt = 0; %rate of change of ooo state*/
dY_oocdt = 0; %rate of change of ooc state*/
dY_coodt = 0; %rate of change of coo state*/
dY_cocdt = 0; %rate of change of coc state*/
dY_ccodt = 0; %rate of change of cco state*/
dY_ocodt = 0; %rate of change of oco state*/
dY_occdt = 0; %rate of change of occ state*/
p_O_RyR_base = 0.000075; %basal RYR activity*/
p_O_RyR_t = 0; %total probability of RyR being open*/
P_RyR = 5191; %conversion factor for GHK*/
J_Ca_rel = 0; %flux of Ca being released from SR through RyR*/
alpha_1 = 0; %binding of mgATP to SERCA (forward)*/
alpha_2 = 0; %binding of 2 Ca to SERCA, ATP hydrolysis (forward)*/
alpha_3 = 0; %unbinding of 2 Ca, Pi release (forward)*/
beta_1 = 0; %reverse of alpha_1*/
MgADP_cyt = 0.025978226605534577; %concentration of MgADP in cytosol*/
beta_2 = 0; %reverse of alpha_2*/
beta_3 = 0; %reverse of alpha_3*/
v_cyc = 0; %turnover rate for SERCA*/
J_SERCA = 0; %SERCA flux*/
I_tot_Ca_jnc = 0; %total Ca current junctional space*/
I_tot_Ca_iz = 0; %total Ca current intermediate zone*/
I_tot_Ca_blk = 0; %total Ca current bulk space*/
I_tot_Ca = 0; %total Ca current*/
I_NaT_Na = 0; %effect of NaT current on Na*/
I_NaT_K = 0; %effect of NaT current on K*/
I_NaL_Na = 0; %effect of NaL current on Na*/
I_NaL_K = 0; %effect of NaL current on K*/
I_Kto_Na = 0; %effect of Kto current on Na*/
I_tot_Na = 0; %total Na current*/
I_tot_K = 0; %total K current*/
I_tot_cell = 0; %total ion current (Na, Ca, K)*/
I_app = 0; %applied current*/
dVmdt = 0; %rate of change of membrane voltage*/
Y_cc_iz = 0; %probability of being in cc state (L, Ca closed) intermediate zone*/
Y_co_iz = 0.992251726297519; %probability of being in co state (L closed, Ca open) intermediate zone*/
Y_oo_iz = 0.00000314564543512061; %probability of being in oo state (L, Ca open) intermediate zone*/
Y_oc_iz = 0.000000024556270151713; %probability of being in cc state (L open, Ca closed) intermediate zone*/
dY_co_izdt = 0; %rate of change of co state intermediate zone*/
dY_oo_izdt = 0; %rate of change of oo state intermediate zone*/
dY_oc_izdt = 0; %rate of change of oc state intermediate zone*/
Y_cc_blk = 0; %probability of being in cc state (L, Ca closed) bulk space*/
Y_co_blk = 0.992424981547859; %probability of being in co state (L closed, Ca open) bulk space*/
Y_oo_blk = 0.00000314619469048683; %probability of being in oo state (L, Ca open) bulk space*/
Y_oc_blk = 0.0000000240070147854924; %probability of being in oc state (L open, Ca closed) bulk space*/
dY_co_blkdt = 0; %rate of change of co state bulk space*/
dY_oo_blkdt = 0; %rate of change of oo state bulk space*/
dY_oc_blkdt = 0; %rate of change of oc state bulk space*/
Cm = 0; %membrane capacitance*/
V_cell = 0; %whole cell volatage*/
V_jnc = 0; %voltage junctional space*/
V_iz = 0; %voltage intermediate zone*/
V_blk = 0; %voltage bulk space*/
V_SRt = 0; %total SR voltage*/
V_SRrl = 0; %voltage SR releasing*/
V_SRup = 0; %voltage SR uptake*/
V_cyt = 0; %voltage cytosolic*/
dCa_2_tot_jncdt = 0; %total rate of change of Ca in junctional space*/
dCa_2_tot_izdt = 0; %total rate of change of Ca in intermediate zone*/
dCa_2_tot_blkdt = 0; %total rate of change of Ca in bulk space*/
dCa_2_SRupdt = 0; %total rate of change of Ca in SR uptake*/
dCa_2_tot_SRrldt = 0; %total rate of change of Ca in SR releasing*/
dNaidt = 0; %rate of change of intracellular Na*/
dKidt = 0; %rate of change of intracellular K*/
Ca_2_tot_blk = 0.11279654524634; %total conc of Ca in bulk space*/
halfSL = 0.91; %half sarcomere length*/
hp = 0.00600014761511324; %power XB length*/
TS_tot = 23; %total of 6 TS*/
propFh = 28000; %param in calculating g and gd*/
Za = 0.0023; %param in calculating g*/
Yv = 1.5; %param in calculating g*/
rate_g = 0; %rate constant for contraction model (similar to Huxley)*/
Yd = 0.0333; %param in calculating gd*/
Yc = 1; %param in calculating gd*/
Lc = 1.2; %length change?*/
Yvd = 0; %param in calculating gd*/
rate_gd = 0; %rate constant for contraction model (similar to Huxley)*/
Zb = 0.1397; %rate constant for contraction model*/
rate_f = 0.0023; %rate constant for contraction model*/
convertF = 15; %kurtosis of curve (use to convert TSCa3 to TSCa3_eff)*/
eqvhalfSL = 1.15; %optimal overlapping length where maximum CB attachment can take place (use to convert TSCa3 to TSCa3_eff*/
TS = 0; %free TS*/
dTSCa_3dt = 0; %rate of change of TS with 3 Ca bound, no XB*/
TSCa_3 = 0.00899891910620064; %TS with 3 Ca bound, no XB*/
Zp = 0.2095; %rate constant for contraction model*/
Yp = 0.1397; %rate constant for contraction model*/
dTSCa_3Wdt = 0; %rate of change of TS with 3 Ca bound, weak XB*/
TSCa_3W = 0.000369547640656701; %TS with 3 Ca bound, weak XB*/
Zr = 7.2626; %rate constant for contraction model*/
Yr = 0.1397; %rate constant for contraction model*/
dTSCa_3Sdt = 0; %rate of change of TS with 3 Ca bound, power XB*/
TSCa_3S = 0.000153834503967436; %TS with 3 Ca bound, power XB*/
Zq = 0.3724; %rate constant for contraction model*/
Yq = 0.2328; %rate constant for contraction model*/
dTS_Sdt = 0; %rate of change of TS with no Ca bound, power XB*/
TS_S = 0.000876347322180234; %TS with no Ca bound, power XB*/
hwr = 0.0001; %resting length for weak XB*/
dTS_Wdt = 0; %rate of change of TS with no Ca bound, weak XB*/
TS_W = 0.000492054058977473; %TS with no Ca bound, weak XB*/
dhwdt = 0; %rate of change of hw*/
rate_B = 0.5; %param involved in length change*/
hw = 0.000100147615113241; %weak XB length*/
hpr = 0.006; %resting length for power XB*/
dhpdt = 0; %rate of change of hp*/
dt = 0.1; %timestep*/
K_dL_iz = k_off_L_iz / k_on_L_iz;
K_dH_iz = k_off_H_iz / k_on_H_iz;
K_dL_jnc = k_off_L_jnc / k_on_L_jnc;
K_dH_jnc = k_off_H_jnc / k_on_H_jnc;
K_d_CSQN_Ca = k_off_CSQN / k_on_CSQN;
P_CaL_Na = 0.0000185 * P_CaL_Ca;
P_CaL_K = 0.000367 * P_CaL_Ca;
P_Ks_Na = 0.04 * P_Ks_K;
P_l_Ca_K = P_l_Ca_Na;
alpha_2_plus = k_2_plus;
delta_RTF = 2 * F / (R * T);
f_L = J_L / g_D;
f_R = J_R / g_D;
k_oc = Q_10 * 0.5664;
Cm = 192.46 * Sc_Cell;
V_cell = 120 * (37.62 * Sc_Cell) * 8.4;
V_jnc = 0.008 * V_cell;
V_iz = 0.035 * V_cell;
V_blk = 0.68 * V_cell;
V_SRt = 0.06 * V_cell;
V_SRrl = 0.2 * V_SRt;
V_SRup = 0.8 * V_SRt;
V_cyt = V_jnc + V_iz + V_blk;
Yvd = Yv;

%digitized data from Korte et al.
%ATP
%Korte = [0.0398683162742719, 0.0374842695578144, 0.0400419776956071, 0.051219201900435, 0.0555643904200561, 0.0695368107845388, 0.0813911969428752, 0.0958652395629928, 0.117149241852033, 0.106466998049767, 0.146976185486712, 0.131832940330332, 0.128387263771034, 0.186533355855542, 0.172527541060571, 0.162417650472866, 0.15762148823769, 0.215225516570817, 0.202331242617138, 0.19674372390385, 0.237668276521546, 0.266340627598075, 0.252197505993853, 0.247895812923471, 0.229628924822415, 0.286729108000093, 0.275902011299317, 0.394194267801149, 0.305719548159143, 0.382014270804253, 0.331942707534958, 0.418919627806023, 0.406281335547966, 0.436661374675349, 0.450164530606395, 0.463124099967184, 0.471578613671251, 0.465836999200559, 0.455467210726048, 0.443414000553368, 0.433159756610929, 0.4234855160923, 0.413645341501925, 0.404501345650574, 0.395647204166688, 0.385548619079882, 0.375137624841664, 0.365371906479416, 0.354147711801149, 0.343094715574262, 0.33095440847746, 0.322442485021422, 0.313509938721484, 0.302785080338125, 0.292791330416734, 0.282424213371934, 0.272885038572089, 0.262199305892735, 0.251183252489569, 0.240136037257374, 0.229764590833281, 0.220610936949301, 0.21016665508575, 0.200881657293884, 0.191102379000434, 0.183808848376529, 0.173609587550823, 0.162792232732971, 0.152955698008911, 0.147710365792984, 0.143973247427134, 0.138998244927072, 0.130188794885626, 0.123746525731854, 0.117958553120305, 0.112423696394381, 0.105654530000745, 0.100575331347532, 0.0952547425140637, 0.0937652541388697, 0.090935841070599, 0.0872927957505125, 0.084441450332319, 0.0797319896240611, 0.0790959086982613, 0.0854838428428751, 0.0828923273463524, 0.0798710027180689, 0.0784126203872088, 0.0792986515024525, 0.070690790457063, 0.0717688058950018, 0.0732666437873644, 0.0650240331887615, 0.0676767784777709, 0.0673735764036011, 0.0640714509039117, 0.0668963987692329, 0.064297068561254, 0.0588206147978267, 0.059268541836138, 0.0605002320474698, 0.0632701980087863, 0.062632360384073, 0.0662535405198074, 0.0687686552056813, 0.0589010539370073, 0.0600738063801612, 0.0629916624820551, 0.0602438527558211, 0.0571834545701025, 0.0531484861765288, 0.0521176442493945, 0.0509010075164548, 0.0515326687093449, 0.0484568721221673, 0.0501133235545795, 0.0543955617042841, 0.059465655927569, 0.0611195333802854, 0.0645198969826452, 0.0618502343712823, 0.0603918520403912, 0.0642865470781743, 0.0637443819787641, 0.0565685371885441, 0.0538513969305804, 0.0578326431723996, 0.0554680296877674, 0.0533792243289039];

%dATP
Korte = [0.049816375,    0.046324935,    0.048292583,    0.038665408, 0.057829298,    0.097382778    ,0.044043024    ,0.034827661,    0.073433165    ,0.084141175    ,0.127192482    ,0.114617764    ,0.107740818,    0.155342551,    0.142558959    ,0.136967839,    0.185578977,    0.17088074,    0.165344846    ,0.217098078    ,0.203172852,    0.198011541    ,0.246194487,    0.231333514    ,0.275264899    ,0.25974894    ,0.298987165,    0.2867135,    0.314793867    ,0.329421681,    0.342176687    ,0.353201623,    0.36608865    ,0.377680295,    0.387468525    ,0.399767609    ,0.41233289    ,0.423843344    ,0.433264346,    0.421446585    ,0.407416364,    0.396436088    ,0.385860771    ,0.375836065    ,0.364827608    ,0.352008944    ,0.339162621    ,0.322613768    ,0.308451477    ,0.3333666    ,0.296810613,    0.285763225    ,0.274250303,    0.263645796    ,0.253977972,    0.242407009    ,0.228667977    ,0.215132831,    0.202638059    ,0.190277511,    0.175737583    ,0.164096479    ,0.15390468    ,0.15642584    ,0.160190418,    0.150109833    ,0.140756882    ,0.129197986,    0.116755204    ,0.111839746    ,0.115795857    ,0.107593946    ,0.097866333,    0.092781839    ,0.083588323    ,0.074076609    ,0.064264921    ,0.06791727    ,0.07847834    ,0.090607835,    0.086630466    ,0.081349686,    0.083645555,    0.09023916    ,0.085997171,    0.086558599    ,0.0815004    ,0.071622044,    0.060156319    ,0.04956171    ,0.047384287    ,0.050426731    ,0.059320058    ,0.058460285    ,0.05125366    ,0.049248248    ,0.045601747    ,0.035450228    ,0.029702956    ,0.029455854    ,0.035174081    ,0.045494131    ,0.056635251    ,0.063044499,    0.067339536    ,0.068414311    ,0.059236828    ,0.06073129    ,0.06616939    ,0.077280428    ,0.077761249    ,0.077514147    ,0.076798162    ,0.073350685    ,0.063948033    ,0.055524029    ,0.051496891    ,0.047932597    ,0.055216728    ,0.063305517,    0.060134694    ,0.049289199,    0.040214562    ,0.03933759    ,0.046908442    ,0.044663847,    0.038626421    ,0.027189024,    0.018393344    ,0.016449798,    0.02101582    ,0.031151583    ,0.033739265    ,0.04028132    ,0.036678841    ,0.027274465,    0.021332974    ,0.026044496,    0.031400582,    0.027613369,    0.020866397    ,0.02350409    ,0.02650389    ,0.037678301,    0.046742098    ,0.059352607,    0.069026181    ,0.074962297,    0.070618755    ,0.060197085    ,0.045699214    ,0.055586241,    0.035742407,    0.021519532,    0.014803397,    0.01252729];

%ATP
%time = [3,20,37,54,78,83,85,87,89,87,92,92,87,97,96,97,92,99,99,99,103,106,104,102,102,107,107,119,112,114,115,124,124,128,132,137,147,163,173,179,187,193,201,209,216,223,226,230,237,247,255,262,272,281,290,300,308,316,324,333,344,354,364,373,382,394,407,418,431,445,461,479,494,503,521,539,550,569,580,597,615,633,653,669,689,706,724,742,761,779,794,812,829,851,875,890,911,930,948,960,978,992,1016,1034,1052,1062,1074,1102,1120,1138,1156,1174,1193,1212,1229,1245,1265,1283,1302,1320,1338,1357,1375,1393,1408,1433,1445,1469,1488,1500]

%dATP
time = [6,20,37,53,67,72,66,64,70,74,78,76,76,80,79,76,84,84,83,87,86,84,92,92,96,95,101,96,104,106,108,111,115,122,130,136,142,150,162,173,177,180,184,189,192,197,203,209,212,208,217,224,229,233,231,236,239,242,244,250,255,259,270,288,302,313,318,323,332,334,355,370,380,394,400,404,412,433,447,459,476,496,514,526,544,561,579,588,593,604,623,640,652,667,678,696,714,726,744,762,781,795,809,827,844,860,863,881,900,912,931,949,967,986,998,1009,1027,1039,1053,1069,1085,1091,1100,1116,1134,1151,1156,1164,1174,1192,1209,1227,1244,1260,1273,1277,1287,1302,1322,1340,1354,1370,1389,1404,1413,1418,1424,1437,1448,1449,1458,1456,1471,1477,1490,1501];
    
k = 1;
for t = 0:dt:1501 
    if(85 <= t && t < 88) %apply current
        I_app = -12;
    else
        I_app = 0;
    end
    %calculate
%bulkSpace
	[dCaMCadt, dTnChCadt, dSRCadt, Ca_2_blk] = bulkSpace(k_on_CaM, Ca_2_blk, B_tot_CaM, CaMCa, k_off_CaM, k_on_TnCh, B_tot_TnCh, TnChCa, k_off_TnCh, k_on_SR, B_tot_SR, SRCa, k_off_SR, Ca_2_tot_blk, TSCa_3, TSCa_3W, TSCa_3S);
	
%intermediateZone
    [L_free_iz, H_free_iz, L_bound_iz, H_bound_iz, Ca_2_iz] = intermediateZone(B_tot_L_iz, L_bound_iz, B_tot_H_iz, H_bound_iz, Ca_2_tot_iz, K_dL_iz, K_dH_iz);
	
%junctionalSpace
    [Ca_2_jnc, L_free_jnc, H_free_jnc] = junctionalSpace(Ca_2_tot_jnc, L_free_jnc, K_dL_jnc, H_free_jnc, K_dH_jnc, B_tot_L_jnc, B_tot_H_jnc);
	
%releaseSiteOfSR
    [Ca_2_SRrl] = releaseSiteOfSR(B_tot_CSQN, Ca_2_tot_SRrl, K_d_CSQN_Ca);
    
%boundaryDiffusion
	[J_Ca_jnciz, J_Ca_izblk, J_trans_SR] = boundaryDiffusion(G_dCa_jnciz, Ca_2_jnc, Ca_2_iz, Ca_2_blk, Sc_Cell, G_dCa_izblk, P_trans, Ca_2_SRup, Ca_2_SRrl);
    
%currentCaL
	[alpha_plus, alpha_minus, epsilon_plus_iz, epsilon_plus_blk, Ca_2_iz_loc, Ca_2_blk_loc, epsilon_plus_iz_loc, epsilon_plus_blk_loc, epsilon_minus, p_O_LCC, ATPfactor, E_Ca_jnc, E_Ca_blk, E_Ca_iz, E_K, E_Na,...
    GHK_Ca_LR, GHK_Ca_L0, GHK_Ca_iz, GHK_Ca_blk, GHK_Na, GHK_K, I_CaL_Ca_blk, I_CaL_Ca_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_CaL_Na_blk, I_CaL_Na_iz, I_CaL_Na_jnc, I_CaL_K_blk, I_CaL_K_iz, I_CaL_K_jnc, I_CaL, Y_cc_iz, dY_co_izdt,...
    dY_oo_izdt, dY_oc_izdt, Y_cc_blk, dY_co_blkdt, dY_oo_blkdt, dY_oc_blkdt] = currentCaL(Vm, Ca_2_iz, T_L, K_L, Ca_2_blk, f_L, delta_RTF, Cao, Y_ooo, Y_ooc, ATP, R, T, F, Ca_2_nd_L0, Ko, Ki, Nao, Nai, Ca_2_nd_LR, f_CaL_blk,...
    P_CaL_Ca, Y_oo_blk, f_CaL_iz, Y_oo_iz, f_CaL_jnc, P_CaL_Na, P_CaL_K, Y_co_iz, Y_oc_iz, Y_co_blk, Y_oc_blk);

%currentNa
	[f_C_Na, k_C2O, k_OC, k_OI2, k_C2I2, k_I2C, k_Isb, k_Isf, k_OI1, k_I1C, k_C2I1, p_C_NaT, dp_O_NaTdt, dp_I_2_NaTdt, dp_I_s_NaTdt,...
    p_C_NaL, dp_O_NaLdt, dp_I_1_NaLdt, dp_I_2_NaLdt, dp_I_s_NaLdt, I_NaT_Na, I_NaT_K, I_NaT, I_NaL_Na, I_NaL_K, I_NaL, I_Na] = currentNa(Vm, k_I2O, p_I_2_NaT, p_I_s_NaT, p_O_NaT, p_I_2_NaL, p_I_s_NaL,...
    p_I_1_NaL, p_O_NaL, k_I1O, k_I1I2, f_LSM, P_Na, GHK_Na, GHK_K);

%currentK1
	[alpha_Mg, beta_Mg, f_O, f_B, po_Mg, po_Mg1, po_Mg2, alpha_SPM, beta_SPM, dPb_spmdt, po_mode1, po_mode2, p_O_K1, chi_K1, I_K1] = currentK1(Vm, E_K, Mg_2_cyt, SPM, Pb_spm, f_mode1, Ko, G_K1);

%currentKr   
    [chi_r_infinity, tau_chi_r_fast, tau_chi_r_slow, A_chi_r_fast, A_chi_r_slow, dchi_r_fastdt, dchi_r_slowdt, chi_r, R_Kr, p_O_Kr, chi_Kr, I_Kr] = currentKr(Vm, chi_r_fast, chi_r_slow, Ko, G_Kr, E_K);
    
%currentKs
	[para_Xs1_infinity, tau_Xs1, dpara_Xs1dt, para_Xs2_infinity, tau_Xs2, dpara_Xs2dt, para_RKs_blk, para_RKs_iz, p_O_Ks_blk,...
    p_O_Ks_iz, I_Ks_K_blk, I_Ks_K_iz, I_Ks_Na_blk, I_Ks_Na_iz, I_Ks] = currentKs(Vm, para_Xs1, para_Xs2, Ca_2_blk, Ca_2_iz, f_Ks_blk, P_Ks_K, GHK_K, f_Ks_iz, P_Ks_Na, GHK_Na);

%currentKto
	[a_infinity, tau_a, dadt, i_infinity, tau_i_fast, tau_i_slow, A_i_fast, A_i_slow, di_fastdt, di_slowdt, i, p_O_Kto, I_Kto] = currentKto(Vm, i_fast, i_slow, a, G_Kto, E_K);
     
%currentKpl
	[p_O_Kpl, chi_Kpl, I_Kpl] = currentKpl(Vm, Ko, P_Kpl, GHK_K);
     
%currentCab
	[I_Cab_blk, I_Cab_iz, I_Cab] = currentCab(P_Cab, f_Cab_blk, GHK_Ca_blk, f_Cab_iz, GHK_Ca_iz); 
    
%currentbNSC
	[I_bNSC_K, I_bNSC_Na, I_bNSC] = currentbNSC(P_bNSC_K, GHK_K, P_bNSC_Na, GHK_Na);

%currentlCa
	[p_O_blk, p_O_iz, I_l_Ca_Na_blk, I_l_Ca_Na_iz, I_l_Ca_K_blk, I_l_Ca_K_iz, I_l_Ca] = currentlCa(Ca_2_blk, Ca_2_iz, P_l_Ca_Na, f_l_Ca_blk, f_l_Ca_iz, GHK_Na, GHK_K, P_l_Ca_K);

%currentKATP
	[p_O_KATP, chi_KATP, I_KATP] = currentKATP(ATP_cyt, Ko, G_KATP, Vm, E_K);
    
%currentNaK
	[K_d_Nai, K_d_Nao, K_d_Ki, K_d_Ko, Nai_bar, Nao_bar, Ki_bar, Ko_bar, MgATP_bar, alpha_1_plus, alpha_3_plus, alpha_4_plus,...
    alpha_1_minus, alpha_2_minus, alpha_3_minus, alpha_4_minus, P_14_15, V_step1, V_step2, V_step3, V_step4, v_cyc_NaK, dP_1_6dt,...
    dP_7dt, dP_8_13dt, I_NaK, I_NaK_Na, I_NaK_K] = currentNaK(K_d_Nai_0, delta_Nai, F, Vm, R, T, delta_Nao, K_d_Nao_0, K_d_Ki_0,...
    delta_Ki, K_d_Ko_0, delta_Ko, Nai, Nao, Ki, Ko, MgATP_cyt, K_d_MgATP, k_1_plus, k_3_plus, k_4_plus, k_1_minus, MgADP_cyt,...
    k_2_minus, k_3_minus, k_4_minus, Pi, H, P_1_6, P_7, P_8_13, alpha_2_plus, Amp_NaK, Stoi_NaK_Na, Stoi_NaK_K);
    
%currentNCX
	[f_Caina_blk, f_Caina_iz, q_blk_E_1_Na, q_iz_E_1_Na, q_blk_E_1_Ca, q_iz_E_1_Ca, q_E_2_Na, q_E_2_Ca, alpha_1_blk, alpha_1_iz, beta_1_blk, beta_1_iz,...
    alpha_2_blk, alpha_2_iz, beta_2_blk, beta_2_iz, k_1, k_2, alpha_E, beta_E_blk, beta_E_iz, p_E_2_NCX_blk, p_E_2_NCX_iz, v_cyc_NCX_iz, v_cyc_NCX_blk, dp_E_1_NCX_blkdt,...
    dp_I_1_NCX_blkdt, dp_I_2_NCX_blkdt, dp_E_1_NCX_izdt, dp_I_1_NCX_izdt, dp_I_2_NCX_izdt, I_NCX_blk, I_NCX_iz, I_NCX, I_NCX_Na_blk, I_NCX_Na_iz, I_NCX_Ca_blk, I_NCX_Ca_iz] = currentNCX(Ca_2_blk, K_m_act,...
    Ca_2_iz, K_m_Nai, Nai, K_m_Cai, K_m_Nao, Nao, Cao, K_m_Cao, alpha_1_on, alpha_1_off, beta_1_on, beta_1_off, alpha_2_on, alpha_2_off, beta_2_on, beta_2_off, Vm, F, R, T, k_4, k_3, p_E_1_NCX_blk, p_I_1_NCX_blk, p_I_2_NCX_blk,...
    p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, f_NCX_blk, Amp_NCX, f_NCX_iz);

%currentPMCA	
    [I_PMCA_blk, I_PMCA_iz, I_PMCA] = currentPMCA(f_PMCA_blk, Amp_PMCA, Ca_2_blk, K_m, Ca_2_iz, f_PMCA_iz);
   
%CaRU
    [p_O_RyR, p_O_RyR_t, J_Ca_rel, Ca_2_nd_00, Ca_2_nd_L0, Ca_2_nd_0R, Ca_2_nd_LR, epsilon_plus_00, epsilon_plus_L0, epsilon_plus_0R, epsilon_plus_LR, k_co_00, k_co_L0, k_co_0R, k_co_LR,...
    f_t_00,f_t_L0, k_rco_0, k_rco_L, p_C_0, p_C_L, k_roc_0, k_roc_L, Y_ccc, dY_ooodt, dY_oocdt, dY_coodt, dY_cocdt, dY_ccodt, dY_ocodt, dY_occdt] = CaRU(p_O_RyR_base, P_RyR, Ca_2_SRrl, Ca_2_jnc,...
    Sc_Cell, f_L, delta_RTF, Vm, Cao, f_R, alpha_plus, T_L, K_L, Q_10, k_oc, f_n, sloc0, N_RyR, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, alpha_minus, epsilon_minus);
   
%SERCA
	[alpha_1, alpha_2, alpha_3, beta_1, beta_2, beta_3, v_cyc, J_SERCA] = SERCA(MgATP_cyt, K_dCai, Ca_2_blk, Ca_2_SRup, K_dCasr, MgADP_cyt, Pi, Amp_SERCA, F, Sc_Cell, k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus);
	
%membranePotential
    [I_tot_K, I_tot_Na, I_tot_Ca_blk, I_tot_Ca_iz, I_tot_Ca_jnc, I_tot_Ca, I_tot_cell, dVmdt] = membranePotential(I_CaL_K_jnc, I_CaL_K_iz, I_CaL_K_blk, I_NaT_K, I_NaL_K, I_K1, I_Kr, I_Ks_K_iz, I_Ks_K_blk, I_Kto, I_Kpl, I_NaK_K, I_KATP, I_bNSC_K, I_l_Ca_K_iz, I_l_Ca_K_blk,...
    I_CaL_Na_jnc, I_CaL_Na_iz, I_CaL_Na_blk, I_NCX_Na_iz, I_NCX_Na_blk, I_Ks_Na_iz, I_Ks_Na_blk, I_NaT_Na, I_NaL_Na, I_NaK_Na, I_Kto_Na, I_bNSC_Na, I_l_Ca_Na_iz, I_l_Ca_Na_blk,...
    I_CaL_Ca_blk, I_PMCA_blk, I_NCX_Ca_blk, I_Cab_blk, I_CaL_Ca_iz, I_PMCA_iz, I_NCX_Ca_iz, I_Cab_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_app);
    
%contraction
	[TS, rate_g, rate_gd, dTSCa_3dt, dTSCa_3Wdt, dTSCa_3Sdt, dTS_Sdt, dTS_Wdt, dhwdt , dhpdt] = contraction(TS_tot, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, Za, Yv, propFh, hw, hwr, Yd, Yc, halfSL, Lc, Yvd, Yb, TS, Ca_2_blk,...
    Zb, rate_f, convertF, eqvhalfSL, Zp, Yp, Yr, Zr, Zq, Yq, rate_B, hp, hpr);

%ionConcentration
	[dCa_2_tot_jncdt, dCa_2_tot_izdt, dCa_2_tot_blkdt, dCa_2_SRupdt, dCa_2_tot_SRrldt, dNaidt, dKidt] = ionConcentration(I_tot_Ca_jnc, V_jnc, Cm, F, J_Ca_rel, J_Ca_jnciz, I_tot_Ca_iz, V_iz, J_Ca_izblk, I_tot_Ca_blk, V_blk, J_SERCA, V_SRup, J_trans_SR, V_SRrl, I_tot_Na, V_cyt, I_tot_K, I_app);
    
%euler
	[CaMCa, TnChCa, SRCa, p_O_NaT, p_I_2_NaT, p_I_s_NaT, p_O_NaL, p_I_1_NaL, p_I_2_NaL, p_I_s_NaL, chi_r_fast, chi_r_slow, para_Xs1, para_Xs2, i_fast, i_slow, P_7, P_8_13, P_1_6, p_E_1_NCX_blk, p_I_1_NCX_blk,...
    p_I_2_NCX_blk, p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, Vm, Y_co_iz, Y_oo_iz, Y_oc_iz, Y_co_blk, Y_oo_blk, Y_oc_blk, Ca_2_tot_jnc, Ca_2_tot_iz, Ca_2_tot_blk, Ca_2_SRup,...
    Ca_2_tot_SRrl, Nai, Ki, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, hw, hp, Pb_spm, a] = euler(CaMCa, dCaMCadt, TnChCa, dTnChCadt, SRCa, dSRCadt, p_O_NaT, dp_O_NaTdt, p_I_2_NaT, dp_I_2_NaTdt, p_I_s_NaT, dp_I_s_NaTdt, p_O_NaL, dp_O_NaLdt, p_I_1_NaL, dp_I_1_NaLdt, p_I_2_NaL, dp_I_2_NaLdt,...
    p_I_s_NaL, dp_I_s_NaLdt, chi_r_fast, dchi_r_fastdt, chi_r_slow, dchi_r_slowdt, para_Xs1, dpara_Xs1dt, para_Xs2, dpara_Xs2dt, i_fast, di_fastdt, i_slow, di_slowdt, P_7, dP_7dt, P_8_13, dP_8_13dt, P_1_6, dP_1_6dt,...
    p_E_1_NCX_blk, dp_E_1_NCX_blkdt, p_I_1_NCX_blk, dp_I_1_NCX_blkdt, p_I_2_NCX_blk, dp_I_2_NCX_blkdt, p_E_1_NCX_iz, dp_E_1_NCX_izdt, p_I_1_NCX_iz, dp_I_1_NCX_izdt, p_I_2_NCX_iz, dp_I_2_NCX_izdt, Y_ooo, dY_ooodt,...
    Y_ooc, dY_oocdt, Y_coo, dY_coodt, Y_coc, dY_cocdt, Y_cco, dY_ccodt, Y_oco, dY_ocodt, Y_occ, dY_occdt, Vm, dVmdt, Y_co_iz, dY_co_izdt, Y_oo_iz, dY_oo_izdt, Y_oc_iz, dY_oc_izdt, Y_co_blk, dY_co_blkdt,...
    Y_oo_blk, dY_oo_blkdt, Y_oc_blk, dY_oc_blkdt, Ca_2_tot_jnc, dCa_2_tot_jncdt, Ca_2_tot_iz, dCa_2_tot_izdt, Ca_2_tot_blk, dCa_2_tot_blkdt, Ca_2_SRup, dCa_2_SRupdt, Ca_2_tot_SRrl, dCa_2_tot_SRrldt, Nai, dNaidt,...
    Ki, dKidt, TSCa_3, dTSCa_3dt, TSCa_3W, dTSCa_3Wdt, TSCa_3S, dTSCa_3Sdt, TS_S, dTS_Sdt, TS_W, dTS_Wdt, hw, dhwdt, hp, dhpdt, Pb_spm, dPb_spmdt, a, dadt, dt);
%%    
calcium_transient_full(k) = Ca_2_blk*1000; %calcium concentration in cytosol (convert to uM)
k = k+1;
end
    for j = 1:1:size(time,2) %get just the values we want from full Ca transient (to match digitized data points)
        time2 = time(j)*10;
        calcium_transient(j) = calcium_transient_full(time2);
        SSE = (calcium_transient(j) - Korte(j))^2; %calculate sum of squared error between data and model
        SSE_tot = SSE_tot + SSE; %add up SSE for all data points over Ca2+ transient
    end
end

%% get the calcium transient for plotting
function [calcium_transient,membrane_voltage,SERCA_flux,SERCA_velocity,XB_Force] = objective_function_plot(k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus, K_dCai, Amp_SERCA, Amp_NaK, Amp_NCX, Amp_PMCA, f_n, time, Korte)
SSE_tot = 0; %initialize
%parameters have to be reset each time the function is run
%I didn't change any of these from original values in Himeno model
SSE_tot = 0;
K_dCasr = 1.378; %orig = 1.378 Kd for Ca2+ release into SR
k_on_CSQN = 100; %orig = 100 association rate calsequestrin
K_d_MgATP = 0.6; %orig = 0.6 Kd for ATP binding to NaK
K_m = 0.0005; %orig = 0.0005 used in calculating I_PMCA (Ca2+ association)
Yb = 0.1816; %orig = 0.1816 rate constant for contraction model
Vm = -91.4466885079348; %orig = -91.4466885079348 */ %membrane voltage*/
R = 8.3143; %gas constant*/
T = 310; %temperature*/
F = 96.4867; %Faraday constant*/
dCaMCadt = 0; %rate of change of Calmodulin-Ca complex*/
k_on_CaM = 34; %association rate Calmodulin*/
Ca_2_blk = 0;    %Ca concentration in bulk space*/
B_tot_CaM = 0.024; %total buffer concentration of Calmodulin*/
CaMCa = 0.000228581865602447; %concentration of Calmodulin-Ca*/
k_off_CaM = 0.238; %dissociation rate Calmodulin*/
dTnChCadt = 0; %rate of change of high affinity troponin C-Ca complex*/
k_on_TnCh = 2.37; %association rate of Ca to high affinity troponin C*/
B_tot_TnCh = 0.12; %total buffer concentration of high affinity troponin C*/
TnChCa = 0.110742559707052; %concentration of high affinity troponin C-Ca*/
k_off_TnCh = 0.000032; %dissociation rate high affinity troponin C*/
dSRCadt = 0; %rate of change of Ca buffer by SR membrane-Ca complex*/
k_on_SR = 100; %association rate SR*/
B_tot_SR = 0.0171; %total buffer concentration on SR membrane*/
SRCa = 0.00172960014640511; %concentration of Ca buffer SR membrane-Ca*/
k_off_SR = 0.06; %dissociation rate SR buffer*/
L_free_iz = 0; %free low affinity sarcolemmal Ca buffer intermediate zone*/
L_bound_iz = 0.0075621764602356; %bound low affinity sarcolemmal Ca buffer intermediate zone*/
B_tot_L_iz = 0.6078; %total low affinity sarcolemmal Ca buffer intermediate zone*/
Ca_2_iz = 0; %Ca concentration in intermediate zone*/
k_off_L_iz = 1.3; %dissociation rate low affinity sarcolemmal Ca buffer intermediate zone*/
k_on_L_iz = 100; %association rate low affinity sarcolemmal Ca buffer intermediate zone*/
K_dL_iz = 0; %Kd low affinity sarcolemmal Ca buffer intermediate zone*/
H_free_iz = 0; %free high affinity sarcolemmal Ca buffer intermediate zone*/
H_bound_iz = 0.0769149150028914; %bound high affinity sarcolemmal Ca buffer intermediate zone*/
B_tot_H_iz = 0.2178; %total high affinity sarcolemmal Ca buffer intermediate zone*/
k_off_H_iz = 0.03; %dissociation rate high affinity sarcolemmal Ca buffer intermediate zone*/
k_on_H_iz = 100; %association rate high affinity sarcolemmal Ca buffer intermediate zone*/
K_dH_iz = 0; %Kd high affinity sarcolemmal Ca buffer intermediate zone*/
Ca_2_tot_iz = 0.084640522722006; %total Ca concentration in intermediate zone*/
L_free_jnc = 0; %free low affinity sarcolemmal Ca buffer junctional space*/
B_tot_L_jnc = 1.1095; %total low affinity sarcolemmal Ca buffer junctional space*/
Ca_2_jnc = 0; %Ca concentration in junctional space*/
k_off_L_jnc = 1.3; %dissociation rate low affinity sarcolemmal Ca buffer junctional space*/
k_on_L_jnc = 100; %association rate low affinity sarcolemmal Ca buffer junctional space*/
K_dL_jnc = 0; %Kd low affinity sarcolemmal Ca buffer junctional space*/
H_free_jnc = 0; %free high affinity sarcolemmal Ca buffer junctional space*/
B_tot_H_jnc = 0.398; %total high affinity sarcolemmal Ca buffer junctional space*/
k_off_H_jnc = 0.03; %dissociation rate high affinity sarcolemmal Ca buffer junctional space*/
k_on_H_jnc = 100; %association rate rate high affinity sarcolemmal Ca buffer junctional space*/
K_dH_jnc = 0; %Kd high affinity sarcolemmal Ca buffer junctional space*/
Ca_2_tot_jnc = 0.207176351449979; %total Ca concentration in junctional space*/
B_tot_CSQN = 3; %total buffer concentration of calsequestrin*/
Ca_2_tot_SRrl = 2.21876221622152; %total Ca concentration in SRrl*/
k_off_CSQN = 65; %dissociation rate calsequestrin*/
K_d_CSQN_Ca = 0; %Kd calsequestrin*/
Ca_2_SRrl = 0; %Ca concentration in SRrl*/
J_Ca_jnciz = 0; %flux of Ca from junctional space to intermediate zone*/
G_dCa_jnciz = 3395.88; %conductance of above current*/
Sc_Cell = 1; %scaling factor (Sc_cell = Cm/Cstd (relationship btw cell volume and membrane capacitance)*/
J_Ca_izblk = 0; %flux of Ca from intermediate zone to bulk space*/
G_dCa_izblk = 3507.78; %conductance of above current*/
J_trans_SR = 0; %flux between SRup and SRrl*/
P_trans = 4.8037; %conductance of trans-SR?*/
Ca_2_SRup = 0.761077662687456; %Ca concentration in SRup*/
alpha_plus = 0; %rate constant for L type Ca channels*/
alpha_minus = 0; %rate constant for L type Ca channels*/
epsilon_plus_iz = 0; %rate constant for L type Ca channels*/
epsilon_plus_blk = 0; %rate constant for L type Ca channels*/
epsilon_plus_iz_loc = 0; %rate constant for L type Ca channels*/
epsilon_plus_blk_loc = 0; %rate constant for L type Ca channels*/
epsilon_minus = 0; %rate constant for L type Ca channels*/
Ca_2_iz_loc = 0;
Ca_2_blk_loc = 0;
T_L = 147.51; %inactivation time L type Ca channels*/
K_L = 0.0044; %conc at inactivation L type Ca channels*/
ATPfactor = 0; %part of ICaL calculation*/
ATP = 6; %ATP conc (mM)*/
p_O_LCC = 0; %probability of L type Ca channels (both Ca and Vm gated) being open*/
P_CaL_Ca = 14.21; %conversion factor for GHK*/
P_CaL_Na = 0; %conversion factor for GHK*/
P_CaL_K = 0; %conversion factor for GHK*/
GHK_Ca_LR = 0; %Goldman Hodgkin Katz Ca L type Ca channels and RyR both open*/
GHK_Ca_L0 = 0; %Goldman Hodgkin Katz Ca L type Ca channels open, RyR closed*/
GHK_Ca_iz = 0; %Goldman Hodgkin Katz Ca intermediate zone*/
GHK_Ca_blk = 0; %Goldman Hodgkin Katz Ca bulk space*/
GHK_Na = 0; %Goldman Hodgkin Katz Na*/
GHK_K = 0; %Goldman Hodgkin Katz K*/
Ca_2_nd_LR = 0; %Ca conc in nanodomain L type Ca channels and RyR both open*/
Ca_2_nd_L0 = 0; %Ca conc in nanodomain L type Ca channels open, RyR closed*/
Cao = 1.8; %extracellular Ca*/
Nao = 140; %extracellular Na*/
Ko = 4.5; %extracellular K*/
Nai = 6.66894310282034; %intracellular Na*/
Ki = 139.238265011042; %intracellular K*/
I_CaL_Ca_blk = 0; %interaction between L type Ca channel current and Ca bulk space*/
I_CaL_Ca_iz = 0; %interaction between L type Ca channel current and Ca intermediate zone*/
I_CaL_Ca_LR = 0; %interaction between L type Ca channel current and Ca nd both L type Ca channels and RyR closed*/
I_CaL_Ca_L0 = 0; %interaction between L type Ca channel current and Ca nd L type Ca channels open RyR closed*/
I_CaL_Na_blk = 0; %interaction between L type Ca channel current and Na bulk space*/
I_CaL_Na_iz = 0; %interaction between L type Ca channel current and Na intermediate zone*/
I_CaL_Na_jnc = 0; %interaction between L type Ca channel current and Ca junctional space*/
I_CaL_K_blk = 0; %interaction between L type Ca channel current and K bulk space*/
I_CaL_K_iz = 0; %interaction between L type Ca channel current and K intermediate zone*/
I_CaL_K_jnc = 0; %interaction between L type Ca channel current and Ca junctional space*/
f_CaL_blk = 0.1; %fraction of L type Ca channels in bulk space*/
f_CaL_iz = 0.15; %fraction of L type Ca channels in intermediate zone*/
f_CaL_jnc = 0.75; %fraction of L type Ca channels in junctional space*/
I_CaL = 0; %L type Ca channel current*/
I_Na = 0; %Na current*/
I_NaT = 0; %transient Na current*/
I_NaL = 0; %late Na current*/
k_OC = 0; %rate constant in Na current*/
p_O_NaT = 0.000000706725155695262; %probability of NaT being open*/
k_I2C = 0; %rate constant in Na current*/
p_I_2_NaT = 0.0117704053067285; %probability of NaT being in I2 state*/
k_Isb = 0; %rate constant in Na current*/
p_I_s_NaT = 0.304002781414015; %probability of NaT being in Is state*/
k_Isf = 0; %rate constant in Na current*/
f_C_Na = 0; %instantaneous conversion between C1 and C2 in Na current*/
k_C2O = 0; %rate constant in Na current*/
p_C_NaT = 0; %probability of NaT being in closed state*/
k_OI2 = 0; %rate constant in Na current*/
k_I2O = 0.0001312; %rate constant in Na current*/
k_C2I2 = 0; %rate constant in Na current*/
k_I1I2 = 0.00534; %rate constant in Na current*/
k_OI1 = 0; %rate constant in Na current*/
k_I1O = 0.01; %rate constant in Na current*/
k_I1C = 0; %rate constant in Na current*/
k_C2I1 = 0; %rate constant in Na current*/
f_LSM = 0.13125; %fraction of Na channels?*/
P_Na = 8.1072; %conversion factor for GHK*/
dp_O_NaTdt = 0; %rate of change of open state NaT*/
dp_I_2_NaTdt = 0; %rate of change of I2 state NaT*/
dp_I_s_NaTdt = 0; %rate of change of Is state NaT*/
p_O_NaL = 0.00000295214591324261; %rate of change of open state NaL*/
p_I_1_NaL = 0.00254273877063925; %rate of change of I1 state NaL*/
p_I_2_NaL = 0.0118261382165599; %rate of change of I2 state NaL*/
p_I_s_NaL = 0.303220346353844; %rate of change of Is state NaL*/
dp_O_NaLdt = 0; %rate of change of open state NaL*/
p_C_NaL = 0; %rate of change of closed state NaL*/
dp_I_1_NaLdt = 0; %rate of change of I1 state NaL*/
dp_I_2_NaLdt = 0; %rate of change of I2 state NaL*/
dp_I_s_NaLdt = 0; %rate of change of Is state NaL*/
alpha_Mg = 0; %reverse rate constant for Mg IK1*/
E_K = 0; %Nernst K*/
E_Ca_jnc = 0; %Nernst Ca junctional space*/
E_Ca_blk = 0; %Nernst Ca bulk space*/
E_Ca_iz = 0; %Nernst Ca intermediate zone*/
E_Na = 0; %Nernst Na*/
beta_Mg = 0; %forward rate constant for Mg IK1*/
Mg_2_cyt = 0.8; %cytosolic Mg conc*/
f_O = 0; %fraction open K1 channels*/
f_B = 0; %fraction closed K1 channels*/
po_Mg = 0; %probability of all Mg open*/
po_Mg1 = 0; %probability of Mg1 open*/
po_Mg2 = 0; %probability of Mg2 open*/
alpha_SPM = 0; %forward rate constant for spermine IK1*/
beta_SPM = 0; %reverse rate constant for spermine IK1*/
SPM = 5.0; %spermine conc*/
G_K1 = 1.353; %K1 conductance*/
f_mode1 = 0.9; %used in calculating K1 current*/
dPb_spmdt = 0; %used in calculating K1 current*/
Pb_spm = 0.594875991179992; %used in calculating K1 current*/
po_mode1 = 0; %mode 1 IK1*/
po_mode2 = 0; %mode 2 IK1*/
p_O_K1 = 0; %probability of K1 being open*/
chi_K1 = 0; %used in calculating K1 current*/
I_K1 = 0; %inward rectifier K current*/
chi_r_infinity = 0; %used in calculating delayed rectifier K current, fast*/
tau_chi_r_fast = 0; %used in calculating delayed rectifier K current, fast*/
tau_chi_r_slow = 0; %used in calculating delayed rectifier K current, fast*/
A_chi_r_fast = 0; %used in calculating delayed rectifier K current, fast*/
A_chi_r_slow = 0; %used in calculating delayed rectifier K current, fast*/
dchi_r_fastdt = 0; %used in calculating delayed rectifier K current, fast*/
chi_r_fast = 0.00000486210633393005; %used in calculating delayed rectifier K current, fast*/
dchi_r_slowdt = 0; %used in calculating delayed rectifier K current, fast*/
chi_r_slow = 0.437041249050081; %used in calculating delayed rectifier K current, fast*/
chi_r = 0; %used in calculating delayed rectifier K current, fast*/
R_Kr = 0; %used in calculating delayed rectifier K current, fast*/
p_O_Kr = 0; %probability of Kr being open*/
G_Kr = 0.0166; %Kr conductance*/
chi_Kr = 0; %used in calculating delayed rectifier K current, fast*/
I_Kr = 0; %fast K rectifier current*/
f_Ks_iz = 0.1; %fraction of slow rectifier K current in intermediate zone*/
f_Ks_blk = 0.9; %fraction of slow rectifier K current in bulk space*/
P_Ks_K = 0.002782; %conversion factor for GHK*/
P_Ks_Na = 0; %conversion factor for GHK*/
para_Xs1_infinity = 0; %used incalculating delayed rectifier K current, slow*/
tau_Xs1 = 0; %used incalculating delayed rectifier K current, slow*/
dpara_Xs1dt = 0; %used incalculating delayed rectifier K current, slow*/
para_Xs1 = 0.277482694590328; %used incalculating delayed rectifier K current, slow*/
para_Xs2_infinity = 0; %used incalculating delayed rectifier K current, slow*/
para_Xs2 = 0.000131110342877451; %used incalculating delayed rectifier K current, slow*/
tau_Xs2 = 0; %used incalculating delayed rectifier K current, slow*/
dpara_Xs2dt = 0; %used incalculating delayed rectifier K current, slow*/
para_RKs_blk = 0; %used incalculating delayed rectifier K current, slow*/
para_RKs_iz = 0; %used incalculating delayed rectifier K current, slow*/
p_O_Ks_blk = 0; %probability of Ks being open bulk space*/
p_O_Ks_iz = 0; %probability of Ks being open intermediate zone*/
I_Ks_K_blk = 0; %interaction of Ks current with K bulk space*/
I_Ks_K_iz = 0; %interaction of Ks current with K intermediate zone*/
I_Ks_Na_blk = 0; %interaction of Ks current with Na bulk space*/
I_Ks_Na_iz = 0; %interaction of Ks current with Na intermediate zone*/
I_Ks = 0; %Ks (slow rectifier K) current*/
a_infinity = 0; %used in calculating transient outward K current*/
tau_a = 0; %used in calculating transient outward K current*/
dadt = 0; %used in calculating transient outward K current*/
a = 0.000793627635934239; %used in calculating transient outward K current*/
i_infinity = 0; %used in calculating transient outward K current*/
tau_i_fast = 0; %used in calculating transient outward K current*/
tau_i_slow = 0; %used in calculating transient outward K current*/
A_i_fast = 0; %used in calculating transient outward K current*/
A_i_slow = 0; %used in calculating transient outward K current*/
di_fastdt = 0; %used in calculating transient outward K current*/
i_fast = 0.999756080468878; %used in calculating transient outward K current*/
di_slowdt = 0; %used in calculating transient outward K current*/
i_slow = 0.575995954010486; %used in calculating transient outward K current*/
i = 0; %used in calculating transient outward K current*/
p_O_Kto = 0; %probability of Kto being open*/
G_Kto = 0.0312; %conductance of Kto*/
I_Kto = 0; %transient outward K current*/
p_O_Kpl = 0; %used in calculating transient outward K current*/
chi_Kpl = 0; %used in calculating transient outward K current*/
P_Kpl = 0.0000172; %conversion factor for GHK*/
I_Kpl = 0; %vontage dependent potassium current*/
f_Cab_blk = 0.9; %background calcium current*/
P_Cab = 0.00006822; %conversion factor for GHK*/
I_Cab_blk = 0; %background Ca current bulk space*/
f_Cab_iz = 0.1; %fraction of ICab intermediate zone*/
I_Cab_iz = 0; %bacgkround Ca current intermediate zone*/
I_Cab = 0; %background Ca current*/
P_bNSC_K = 0.00014; %non-selective background cation current K conversion factor for GHK*/
I_bNSC_K = 0; %non-selective background cation current K*/
P_bNSC_Na = 0.00035; %non-selective background cation current Na conversion factor for GHK*/
I_bNSC_Na = 0; %non-selective background cation current Na*/
I_bNSC = 0; %nonselective background cation current*/
p_O_blk = 0; %probability of being open Ca activated background cation current bulk space*/
p_O_iz = 0; %probability of being open Ca activated background cation current intermediate zone*/
f_l_Ca_blk = 0.9; %fraction of Ca activated background cation current bulk space*/
P_l_Ca_Na = 0.00273; %Ca activated bacgkround cation current Na conversion factor for GHK*/
I_l_Ca_Na_blk = 0; %Ca activated background cation current Na bulk space*/
f_l_Ca_iz = 0.1; %fraction of Ca activated background cation current bulk space*/
I_l_Ca_Na_iz = 0; %Ca activated background cation current Na intermediate zone*/
P_l_Ca_K = 0; %conversion factor for GHK*/
I_l_Ca_K_blk = 0; %Ca activated background cation current K bulk space*/
I_l_Ca_K_iz = 0; %Ca activated background cation current K intermediate zone*/
I_l_Ca = 0; %Ca activated background cation current*/
ATP_cyt = 6.67701543987464; %cytosolic ATP conc*/
p_O_KATP = 0; %probability of being open ATP sensitive K current*/
chi_KATP = 0; %used in calculating KATP*/
G_KATP = 17.674; %KATP conductance*/
I_KATP = 0; %ATP sensitive K current*/
delta_Nai = -0.14; %used in calculating NaK*/
K_d_Nai_0 = 5; %used in calculating NaK*/
K_d_Nai = 0; %used in calculating NaK*/
Nai_bar = 0; %Na conc intracellular over Kd_nai*/
delta_Nao = 0.44; %used in calculating NaK*/
K_d_Nao_0 = 26.8; %used in calculating NaK*/
K_d_Nao = 0; %used in calculating NaK*/
Nao_bar = 0; %Na conc extracellular over Kd_nao*/
delta_Ki = -0.14; %used in calculating NaK*/
K_d_Ki_0 = 18.8; %used in calculating NaK*/
K_d_Ki = 0; %used in calculating NaK*/
Ki_bar = 0; %used in calculating NaK*/
delta_Ko = 0.23; %used in calculating NaK*/
K_d_Ko_0 = 0.8; %used in calculating NaK*/
K_d_Ko = 0; %used in calculating NaK*/
Ko_bar = 0; %used in calculating NaK*/
MgATP_cyt = 6.631643709767415; %concentration of MgATP in cytosol*/
MgATP_bar = 0; %MgATP conc over Kd_MgATP*/
k_1_plus = 0.72; %used in calculating NaK*/
k_1_minus = 0.08; %used in calculating NaK*/
k_2_plus = 0.08; %used in calculating NaK*/
k_2_minus = 0.008; %used in calculating NaK*/
k_3_plus = 4; %used in calculating NaK*/
k_3_minus = 8000; %used in calculating NaK*/
k_4_plus = 0.3; %used in calculating NaK*/
k_4_minus = 0.2; %used in calculating NaK*/
alpha_1_plus = 0; %used in calculating NaK*/
alpha_2_plus = 0; %used in calculating NaK*/
alpha_3_plus = 0; %used in calculating NaK*/
alpha_4_plus = 0; %used in calculating NaK*/
alpha_1_minus = 0; %used in calculating NaK*/
alpha_2_minus = 0; %used in calculating NaK*/
Pi = 0.50872066859173026; %Pi conc in cytosol*/
H = 0.0001; %H conc in cytosol*/
alpha_3_minus = 0; %used in calculating NaK*/
alpha_4_minus = 0; %used in calculating NaK*/
dP_7dt = 0; %used in calculating NaK*/
P_7 = 0.0831770174499825; %used in calculating NaK*/
P_8_13 = 0.281082409575779; %used in calculating NaK*/
P_1_6 = 0.435289193632868; %used in calculating NaK*/
P_14_15 = 0; %used in calculating NaK*/
dP_8_13dt = 0; %used in calculating NaK*/
dP_1_6dt = 0; %used in calculating NaK*/
V_step1 = 0; %used in calculating NaK*/
V_step2 = 0; %used in calculating NaK*/
V_step3 = 0; %used in calculating NaK*/
V_step4 = 0; %used in calculating NaK*/
v_cyc_NaK = 0; %turnover rate for NaK*/
I_NaK = 0; %NaK chrrent*/
Stoi_NaK_Na = 3; %used in calculating NaK*/
Stoi_NaK_K = -2; %used in calculating NaK*/
I_NaK_Na = 0; %effect of NaK current on Na*/
I_NaK_K = 0; %effect of NaK current on K*/
f_Caina_blk = 0; %used in calculating NCX*/
K_m_act = 0.004; %used in calculating NCX*/
alpha_1_on = 0.002; %used in calculating NCX*/
alpha_1_off = 0.0015; %used in calculating NCX*/
alpha_2_on = 0.00006; %used in calculating NCX*/
alpha_2_off = 0.02; %used in calculating NCX*/
beta_1_on = 0.0012; %used in calculating NCX*/
beta_1_off = 0.0000005; %used in calculating NCX*/
beta_2_on = 0.18; %used in calculating NCX*/
beta_2_off = 0.0002; %used in calculating NCX*/
K_m_Nai = 20.74854; %used in calculating NCX*/
K_m_Nao = 87.5; %used in calculating NCX*/
K_m_Cai = 0.0184; %used in calculating NCX*/
K_m_Cao = 1.38; %used in calculating NCX*/
q_blk_E_1_Na = 0; %used in calculating NCX*/
alpha_1_blk = 0; %used in calculating NCX*/
f_Caina_iz = 0; %used in calculating NCX*/
q_iz_E_1_Na = 0; %used in calculating NCX*/
alpha_1_iz = 0; %used in calculating NCX*/
beta_1_blk = 0; %used in calculating NCX*/
beta_1_iz = 0; %used in calculating NCX*/
alpha_2_blk = 0; %used in calculating NCX*/
alpha_2_iz = 0; %used in calculating NCX*/
beta_2_blk = 0; %used in calculating NCX*/
beta_2_iz = 0; %used in calculating NCX*/
k_1 = 0; %used in calculating NCX*/
k_2 = 0; %used in calculating NCX*/
k_3 = 1.0; %used in calculating NCX*/
k_4 = 1.0; %used in calculating NCX*/
q_blk_E_1_Ca = 0; %used in calculating NCX*/
q_iz_E_1_Ca = 0; %used in calculating NCX*/
q_E_2_Na = 0; %used in calculating NCX*/
q_E_2_Ca = 0; %used in calculating NCX*/
alpha_E = 0; %used in calculating NCX*/
beta_E_blk = 0; %used in calculating NCX*/
beta_E_iz = 0; %used in calculating NCX*/
p_E_1_NCX_blk = 0.111872123711613; %used in calculating NCX*/
p_I_2_NCX_blk = 0.684869019924837; %used in calculating NCX*/
p_I_1_NCX_blk = 0.203023555446362; %used in calculating NCX*/
p_E_2_NCX_blk = 0; %used in calculating NCX*/
dp_E_1_NCX_blkdt = 0; %used in calculating NCX*/
dp_I_1_NCX_blkdt = 0; %used in calculating NCX*/
dp_I_2_NCX_blkdt = 0; %used in calculating NCX*/
p_E_2_NCX_iz = 0; %used in calculating NCX*/
p_E_1_NCX_iz = 0.238718640001014; %used in calculating NCX*/
p_I_1_NCX_iz = 0.13771129457898; %used in calculating NCX*/
p_I_2_NCX_iz = 0.622892868847556; %used in calculating NCX*/
dp_E_1_NCX_izdt = 0; %used in calculating NCX*/
dp_I_1_NCX_izdt = 0; %used in calculating NCX*/
dp_I_2_NCX_izdt = 0; %used in calculating NCX*/
v_cyc_NCX_blk = 0; %turnover rate for NCX bulk space*/
v_cyc_NCX_iz = 0; %turnover rate for NCX intermediate zone*/
f_NCX_blk = 0.9; %fraction of NCX in bulk space*/
I_NCX_blk = 0; %NCX current bulk space*/
f_NCX_iz = 0.1; %fraction of NCX in intermediate zone*/
I_NCX_iz = 0; %NCX current intermediate zone*/
I_NCX = 0; %NCX current*/
I_NCX_Na_blk = 0; %interaction of NCX current with Na bulk space*/
I_NCX_Na_iz = 0; %interaction of NCX current with Na intermediate zone*/
I_NCX_Ca_blk = 0; %interaction of NCX current with Ca bulk space*/
I_NCX_Ca_iz = 0; %interaction of NCX current with Ca intermediate zone*/
f_PMCA_blk = 0.9; %fraction of PMCA in bulk space*/
f_PMCA_iz = 0.1; %fraction of PMCA in intermediate zone*/
I_PMCA_blk = 0; %PMCA current bulk space*/
I_PMCA_iz = 0; %PMCA current intermediate zone*/
I_PMCA = 0; %PMCA current*/
p_O_RyR = 0; %probability of RyR being open*/
Ca_2_nd_00 = 0; %Ca conc in nanodomain both L type Ca channels and RyR open*/
delta_RTF = 1; %width of opening potentials L type Ca current?*/
J_L = 0.000913; %permeability of LCC*/
J_R = 0.02; %permeability of RyR*/
g_D = 0.065; %Ca flux rate from nd to jnc*/
f_L = 0; %used in calculating CaLO (=J_L/g_D); conductivity ratio between influx and efflux*/
f_R = 0; %used i n calculating CaOR (=J_R/g_D); conductivity ratio between influx and efflux*/
Ca_2_nd_0R = 0; %Ca conc in nanodomain L type Ca channels closed RyR open*/
Q_10 = 3; %temperature factor*/
k_co_L0 = 0; %opening rate of RyR with LCC open, RyR closed*/
k_co_00 = 0; %opening rate of RyR with LCC and RyR closed*/
k_oc = 0; %closing rate constant of RyR*/
f_t_00 = 0; %probability of triggered state for RyR with LCC and RyR closed*/
f_t_L0 = 0; %probability of triggered state for RyR with LCC open, RyR closed*/
sloc0 = 0.1;
k_rco_0 = 0; %forward rate of regenerative step, LCC closed*/
k_rco_L = 0; %forward rate of regenerative step, LCC open*/
N_RyR = 10; %number of RyR in couplon*/
p_C_0 = 0; %probability of L type Ca channels open, RyR closed*/
p_C_L = 0; %probability of L type channels open, RyR open*/
k_roc_0 = 0; %reverse rate of regenerative step, LCC closed*/
k_roc_L = 0; %reverse rate of regenerative step, LCC open*/
k_co_0R = 0; %closing rate of RyR with LCC closed, RyR open*/
k_co_LR = 0; %closing rate of RyR with LCC and RyR open*/
epsilon_plus_00 = 0; %rate constant for couplon*/
epsilon_plus_L0 = 0; %rate constant for couplon*/
epsilon_plus_0R = 0; %rate constant for couplon*/
epsilon_plus_LR = 0; %rate constant for couplon*/
Y_ooo = 0.00000172489315884865; %probability of ooo state (L, Ca, RyR open)*/
Y_ooc = 0.00000142034754677507; %probability of ooc state (L, Ca open, RyR closed)*/
Y_occ = 0.0000000249594301562175; %probability of occ state (L open, Ca, RyR closed)*/
Y_coc = 0.992110534408681; %probability of coc state (L closed, Ca open, RyR closed)*/
Y_ccc = 0; %probability of ccc state (L, Ca, RyR closed)*/
Y_coo = 0.0000138422676498755; %probability of coo state (L closed, Ca RyR open)*/
Y_cco = 0.0000000953816272498217; %probability of cco state (L, Ca closed, RyR open)*/
Y_oco = 0.00000000000156949238162028; %probability of oco state (L open, Ca closed, RyR open)*/
dY_ooodt = 0; %rate of change of ooo state*/
dY_oocdt = 0; %rate of change of ooc state*/
dY_coodt = 0; %rate of change of coo state*/
dY_cocdt = 0; %rate of change of coc state*/
dY_ccodt = 0; %rate of change of cco state*/
dY_ocodt = 0; %rate of change of oco state*/
dY_occdt = 0; %rate of change of occ state*/
p_O_RyR_base = 0.000075; %basal RYR activity*/
p_O_RyR_t = 0; %total probability of RyR being open*/
P_RyR = 5191; %conversion factor for GHK*/
J_Ca_rel = 0; %flux of Ca being released from SR through RyR*/
alpha_1 = 0; %binding of mgATP to SERCA (forward)*/
alpha_2 = 0; %binding of 2 Ca to SERCA, ATP hydrolysis (forward)*/
alpha_3 = 0; %unbinding of 2 Ca, Pi release (forward)*/
beta_1 = 0; %reverse of alpha_1*/
MgADP_cyt = 0.025978226605534577; %concentration of MgADP in cytosol*/
beta_2 = 0; %reverse of alpha_2*/
beta_3 = 0; %reverse of alpha_3*/
v_cyc = 0; %turnover rate for SERCA*/
J_SERCA = 0; %SERCA flux*/
I_tot_Ca_jnc = 0; %total Ca current junctional space*/
I_tot_Ca_iz = 0; %total Ca current intermediate zone*/
I_tot_Ca_blk = 0; %total Ca current bulk space*/
I_tot_Ca = 0; %total Ca current*/
I_NaT_Na = 0; %effect of NaT current on Na*/
I_NaT_K = 0; %effect of NaT current on K*/
I_NaL_Na = 0; %effect of NaL current on Na*/
I_NaL_K = 0; %effect of NaL current on K*/
I_Kto_Na = 0; %effect of Kto current on Na*/
I_tot_Na = 0; %total Na current*/
I_tot_K = 0; %total K current*/
I_tot_cell = 0; %total ion current (Na, Ca, K)*/
I_app = 0; %applied current*/
dVmdt = 0; %rate of change of membrane voltage*/
Y_cc_iz = 0; %probability of being in cc state (L, Ca closed) intermediate zone*/
Y_co_iz = 0.992251726297519; %probability of being in co state (L closed, Ca open) intermediate zone*/
Y_oo_iz = 0.00000314564543512061; %probability of being in oo state (L, Ca open) intermediate zone*/
Y_oc_iz = 0.000000024556270151713; %probability of being in cc state (L open, Ca closed) intermediate zone*/
dY_co_izdt = 0; %rate of change of co state intermediate zone*/
dY_oo_izdt = 0; %rate of change of oo state intermediate zone*/
dY_oc_izdt = 0; %rate of change of oc state intermediate zone*/
Y_cc_blk = 0; %probability of being in cc state (L, Ca closed) bulk space*/
Y_co_blk = 0.992424981547859; %probability of being in co state (L closed, Ca open) bulk space*/
Y_oo_blk = 0.00000314619469048683; %probability of being in oo state (L, Ca open) bulk space*/
Y_oc_blk = 0.0000000240070147854924; %probability of being in oc state (L open, Ca closed) bulk space*/
dY_co_blkdt = 0; %rate of change of co state bulk space*/
dY_oo_blkdt = 0; %rate of change of oo state bulk space*/
dY_oc_blkdt = 0; %rate of change of oc state bulk space*/
Cm = 0; %membrane capacitance*/
V_cell = 0; %whole cell volatage*/
V_jnc = 0; %voltage junctional space*/
V_iz = 0; %voltage intermediate zone*/
V_blk = 0; %voltage bulk space*/
V_SRt = 0; %total SR voltage*/
V_SRrl = 0; %voltage SR releasing*/
V_SRup = 0; %voltage SR uptake*/
V_cyt = 0; %voltage cytosolic*/
dCa_2_tot_jncdt = 0; %total rate of change of Ca in junctional space*/
dCa_2_tot_izdt = 0; %total rate of change of Ca in intermediate zone*/
dCa_2_tot_blkdt = 0; %total rate of change of Ca in bulk space*/
dCa_2_SRupdt = 0; %total rate of change of Ca in SR uptake*/
dCa_2_tot_SRrldt = 0; %total rate of change of Ca in SR releasing*/
dNaidt = 0; %rate of change of intracellular Na*/
dKidt = 0; %rate of change of intracellular K*/
Ca_2_tot_blk = 0.11279654524634; %total conc of Ca in bulk space*/
halfSL = 0.91; %half sarcomere length*/
hp = 0.00600014761511324; %power XB length*/
TS_tot = 23; %total of 6 TS*/
propFh = 28000; %param in calculating g and gd*/
Za = 0.0023; %param in calculating g*/
Yv = 1.5; %param in calculating g*/
rate_g = 0; %rate constant for contraction model (similar to Huxley)*/
Yd = 0.0333; %param in calculating gd*/
Yc = 1; %param in calculating gd*/
Lc = 1.2; %length change?*/
Yvd = 0; %param in calculating gd*/
rate_gd = 0; %rate constant for contraction model (similar to Huxley)*/
Zb = 0.1397; %rate constant for contraction model*/
rate_f = 0.0023; %rate constant for contraction model*/
convertF = 15; %kurtosis of curve (use to convert TSCa3 to TSCa3_eff)*/
eqvhalfSL = 1.15; %optimal overlapping length where maximum CB attachment can take place (use to convert TSCa3 to TSCa3_eff*/
TS = 0; %free TS*/
dTSCa_3dt = 0; %rate of change of TS with 3 Ca bound, no XB*/
TSCa_3 = 0.00899891910620064; %TS with 3 Ca bound, no XB*/
Zp = 0.2095; %rate constant for contraction model*/
Yp = 0.1397; %rate constant for contraction model*/
dTSCa_3Wdt = 0; %rate of change of TS with 3 Ca bound, weak XB*/
TSCa_3W = 0.000369547640656701; %TS with 3 Ca bound, weak XB*/
Zr = 7.2626; %rate constant for contraction model*/
Yr = 0.1397; %rate constant for contraction model*/
dTSCa_3Sdt = 0; %rate of change of TS with 3 Ca bound, power XB*/
TSCa_3S = 0.000153834503967436; %TS with 3 Ca bound, power XB*/
Zq = 0.3724; %rate constant for contraction model*/
Yq = 0.2328; %rate constant for contraction model*/
dTS_Sdt = 0; %rate of change of TS with no Ca bound, power XB*/
TS_S = 0.000876347322180234; %TS with no Ca bound, power XB*/
hwr = 0.0001; %resting length for weak XB*/
dTS_Wdt = 0; %rate of change of TS with no Ca bound, weak XB*/
TS_W = 0.000492054058977473; %TS with no Ca bound, weak XB*/
dhwdt = 0; %rate of change of hw*/
rate_B = 0.5; %param involved in length change*/
hw = 0.000100147615113241; %weak XB length*/
hpr = 0.006; %resting length for power XB*/
dhpdt = 0; %rate of change of hp*/
dt = 0.1; %timestep*/
xw = halfSL - hw;
xp = halfSL - hp;
K_dL_iz = k_off_L_iz / k_on_L_iz;
K_dH_iz = k_off_H_iz / k_on_H_iz;
K_dL_jnc = k_off_L_jnc / k_on_L_jnc;
K_dH_jnc = k_off_H_jnc / k_on_H_jnc;
K_d_CSQN_Ca = k_off_CSQN / k_on_CSQN;
P_CaL_Na = 0.0000185 * P_CaL_Ca;
P_CaL_K = 0.000367 * P_CaL_Ca;
P_Ks_Na = 0.04 * P_Ks_K;
P_l_Ca_K = P_l_Ca_Na;
alpha_2_plus = k_2_plus;
delta_RTF = 2 * F / (R * T);
f_L = J_L / g_D;
f_R = J_R / g_D;
k_oc = Q_10 * 0.5664;
Cm = 192.46 * Sc_Cell;
V_cell = 120 * (37.62 * Sc_Cell) * 8.4;
V_jnc = 0.008 * V_cell;
V_iz = 0.035 * V_cell;
V_blk = 0.68 * V_cell;
V_SRt = 0.06 * V_cell;
V_SRrl = 0.2 * V_SRt;
V_SRup = 0.8 * V_SRt;
V_cyt = V_jnc + V_iz + V_blk;
Yvd = Yv; 
k = 1;

for t = 0:dt:1501
    if(85 <= t && t < 88) %apply current
        I_app = -12;
    else
        I_app = 0;
    end
    %calculate
%bulkSpace
	[dCaMCadt, dTnChCadt, dSRCadt, Ca_2_blk] = bulkSpace(k_on_CaM, Ca_2_blk, B_tot_CaM, CaMCa, k_off_CaM, k_on_TnCh, B_tot_TnCh, TnChCa, k_off_TnCh, k_on_SR, B_tot_SR, SRCa, k_off_SR, Ca_2_tot_blk, TSCa_3, TSCa_3W, TSCa_3S);
	
%intermediateZone
    [L_free_iz, H_free_iz, L_bound_iz, H_bound_iz, Ca_2_iz] = intermediateZone(B_tot_L_iz, L_bound_iz, B_tot_H_iz, H_bound_iz, Ca_2_tot_iz, K_dL_iz, K_dH_iz);
	
%junctionalSpace
    [Ca_2_jnc, L_free_jnc, H_free_jnc] = junctionalSpace(Ca_2_tot_jnc, L_free_jnc, K_dL_jnc, H_free_jnc, K_dH_jnc, B_tot_L_jnc, B_tot_H_jnc);
	
%releaseSiteOfSR
    [Ca_2_SRrl] = releaseSiteOfSR(B_tot_CSQN, Ca_2_tot_SRrl, K_d_CSQN_Ca);
    
%boundaryDiffusion
	[J_Ca_jnciz, J_Ca_izblk, J_trans_SR] = boundaryDiffusion(G_dCa_jnciz, Ca_2_jnc, Ca_2_iz, Ca_2_blk, Sc_Cell, G_dCa_izblk, P_trans, Ca_2_SRup, Ca_2_SRrl);
    
%currentCaL
	[alpha_plus, alpha_minus, epsilon_plus_iz, epsilon_plus_blk, Ca_2_iz_loc, Ca_2_blk_loc, epsilon_plus_iz_loc, epsilon_plus_blk_loc, epsilon_minus, p_O_LCC, ATPfactor, E_Ca_jnc, E_Ca_blk, E_Ca_iz, E_K, E_Na,...
    GHK_Ca_LR, GHK_Ca_L0, GHK_Ca_iz, GHK_Ca_blk, GHK_Na, GHK_K, I_CaL_Ca_blk, I_CaL_Ca_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_CaL_Na_blk, I_CaL_Na_iz, I_CaL_Na_jnc, I_CaL_K_blk, I_CaL_K_iz, I_CaL_K_jnc, I_CaL, Y_cc_iz, dY_co_izdt,...
    dY_oo_izdt, dY_oc_izdt, Y_cc_blk, dY_co_blkdt, dY_oo_blkdt, dY_oc_blkdt] = currentCaL(Vm, Ca_2_iz, T_L, K_L, Ca_2_blk, f_L, delta_RTF, Cao, Y_ooo, Y_ooc, ATP, R, T, F, Ca_2_nd_L0, Ko, Ki, Nao, Nai, Ca_2_nd_LR, f_CaL_blk,...
    P_CaL_Ca, Y_oo_blk, f_CaL_iz, Y_oo_iz, f_CaL_jnc, P_CaL_Na, P_CaL_K, Y_co_iz, Y_oc_iz, Y_co_blk, Y_oc_blk);

%currentNa
	[f_C_Na, k_C2O, k_OC, k_OI2, k_C2I2, k_I2C, k_Isb, k_Isf, k_OI1, k_I1C, k_C2I1, p_C_NaT, dp_O_NaTdt, dp_I_2_NaTdt, dp_I_s_NaTdt,...
    p_C_NaL, dp_O_NaLdt, dp_I_1_NaLdt, dp_I_2_NaLdt, dp_I_s_NaLdt, I_NaT_Na, I_NaT_K, I_NaT, I_NaL_Na, I_NaL_K, I_NaL, I_Na] = currentNa(Vm, k_I2O, p_I_2_NaT, p_I_s_NaT, p_O_NaT, p_I_2_NaL, p_I_s_NaL,...
    p_I_1_NaL, p_O_NaL, k_I1O, k_I1I2, f_LSM, P_Na, GHK_Na, GHK_K);

%currentK1
	[alpha_Mg, beta_Mg, f_O, f_B, po_Mg, po_Mg1, po_Mg2, alpha_SPM, beta_SPM, dPb_spmdt, po_mode1, po_mode2, p_O_K1, chi_K1, I_K1] = currentK1(Vm, E_K, Mg_2_cyt, SPM, Pb_spm, f_mode1, Ko, G_K1);

%currentKr   
    [chi_r_infinity, tau_chi_r_fast, tau_chi_r_slow, A_chi_r_fast, A_chi_r_slow, dchi_r_fastdt, dchi_r_slowdt, chi_r, R_Kr, p_O_Kr, chi_Kr, I_Kr] = currentKr(Vm, chi_r_fast, chi_r_slow, Ko, G_Kr, E_K);
    
%currentKs
	[para_Xs1_infinity, tau_Xs1, dpara_Xs1dt, para_Xs2_infinity, tau_Xs2, dpara_Xs2dt, para_RKs_blk, para_RKs_iz, p_O_Ks_blk,...
    p_O_Ks_iz, I_Ks_K_blk, I_Ks_K_iz, I_Ks_Na_blk, I_Ks_Na_iz, I_Ks] = currentKs(Vm, para_Xs1, para_Xs2, Ca_2_blk, Ca_2_iz, f_Ks_blk, P_Ks_K, GHK_K, f_Ks_iz, P_Ks_Na, GHK_Na);

%currentKto
	[a_infinity, tau_a, dadt, i_infinity, tau_i_fast, tau_i_slow, A_i_fast, A_i_slow, di_fastdt, di_slowdt, i, p_O_Kto, I_Kto] = currentKto(Vm, i_fast, i_slow, a, G_Kto, E_K);
     
%%currentKpl
	[p_O_Kpl, chi_Kpl, I_Kpl] = currentKpl(Vm, Ko, P_Kpl, GHK_K);
     
%currentCab
	[I_Cab_blk, I_Cab_iz, I_Cab] = currentCab(P_Cab, f_Cab_blk, GHK_Ca_blk, f_Cab_iz, GHK_Ca_iz); 
    
%currentbNSC
	[I_bNSC_K, I_bNSC_Na, I_bNSC] = currentbNSC(P_bNSC_K, GHK_K, P_bNSC_Na, GHK_Na);

%currentlCa
	[p_O_blk, p_O_iz, I_l_Ca_Na_blk, I_l_Ca_Na_iz, I_l_Ca_K_blk, I_l_Ca_K_iz, I_l_Ca] = currentlCa(Ca_2_blk, Ca_2_iz, P_l_Ca_Na, f_l_Ca_blk, f_l_Ca_iz, GHK_Na, GHK_K, P_l_Ca_K);

%currentKATP
	[p_O_KATP, chi_KATP, I_KATP] = currentKATP(ATP_cyt, Ko, G_KATP, Vm, E_K);
    
%currentNaK
	[K_d_Nai, K_d_Nao, K_d_Ki, K_d_Ko, Nai_bar, Nao_bar, Ki_bar, Ko_bar, MgATP_bar, alpha_1_plus, alpha_3_plus, alpha_4_plus,...
    alpha_1_minus, alpha_2_minus, alpha_3_minus, alpha_4_minus, P_14_15, V_step1, V_step2, V_step3, V_step4, v_cyc_NaK, dP_1_6dt,...
    dP_7dt, dP_8_13dt, I_NaK, I_NaK_Na, I_NaK_K] = currentNaK(K_d_Nai_0, delta_Nai, F, Vm, R, T, delta_Nao, K_d_Nao_0, K_d_Ki_0,...
    delta_Ki, K_d_Ko_0, delta_Ko, Nai, Nao, Ki, Ko, MgATP_cyt, K_d_MgATP, k_1_plus, k_3_plus, k_4_plus, k_1_minus, MgADP_cyt,...
    k_2_minus, k_3_minus, k_4_minus, Pi, H, P_1_6, P_7, P_8_13, alpha_2_plus, Amp_NaK, Stoi_NaK_Na, Stoi_NaK_K);
    
%currentNCX
	[f_Caina_blk, f_Caina_iz, q_blk_E_1_Na, q_iz_E_1_Na, q_blk_E_1_Ca, q_iz_E_1_Ca, q_E_2_Na, q_E_2_Ca, alpha_1_blk, alpha_1_iz, beta_1_blk, beta_1_iz,...
    alpha_2_blk, alpha_2_iz, beta_2_blk, beta_2_iz, k_1, k_2, alpha_E, beta_E_blk, beta_E_iz, p_E_2_NCX_blk, p_E_2_NCX_iz, v_cyc_NCX_iz, v_cyc_NCX_blk, dp_E_1_NCX_blkdt,...
    dp_I_1_NCX_blkdt, dp_I_2_NCX_blkdt, dp_E_1_NCX_izdt, dp_I_1_NCX_izdt, dp_I_2_NCX_izdt, I_NCX_blk, I_NCX_iz, I_NCX, I_NCX_Na_blk, I_NCX_Na_iz, I_NCX_Ca_blk, I_NCX_Ca_iz] = currentNCX(Ca_2_blk, K_m_act,...
    Ca_2_iz, K_m_Nai, Nai, K_m_Cai, K_m_Nao, Nao, Cao, K_m_Cao, alpha_1_on, alpha_1_off, beta_1_on, beta_1_off, alpha_2_on, alpha_2_off, beta_2_on, beta_2_off, Vm, F, R, T, k_4, k_3, p_E_1_NCX_blk, p_I_1_NCX_blk, p_I_2_NCX_blk,...
    p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, f_NCX_blk, Amp_NCX, f_NCX_iz);

%currentPMCA	
    [I_PMCA_blk, I_PMCA_iz, I_PMCA] = currentPMCA(f_PMCA_blk, Amp_PMCA, Ca_2_blk, K_m, Ca_2_iz, f_PMCA_iz);
   
%CaRU
    [p_O_RyR, p_O_RyR_t, J_Ca_rel, Ca_2_nd_00, Ca_2_nd_L0, Ca_2_nd_0R, Ca_2_nd_LR, epsilon_plus_00, epsilon_plus_L0, epsilon_plus_0R, epsilon_plus_LR, k_co_00, k_co_L0, k_co_0R, k_co_LR,...
    f_t_00,f_t_L0, k_rco_0, k_rco_L, p_C_0, p_C_L, k_roc_0, k_roc_L, Y_ccc, dY_ooodt, dY_oocdt, dY_coodt, dY_cocdt, dY_ccodt, dY_ocodt, dY_occdt] = CaRU(p_O_RyR_base, P_RyR, Ca_2_SRrl, Ca_2_jnc,...
    Sc_Cell, f_L, delta_RTF, Vm, Cao, f_R, alpha_plus, T_L, K_L, Q_10, k_oc, f_n, sloc0, N_RyR, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, alpha_minus, epsilon_minus);
   
%SERCA
	[alpha_1, alpha_2, alpha_3, beta_1, beta_2, beta_3, v_cyc, J_SERCA] = SERCA(MgATP_cyt, K_dCai, Ca_2_blk, Ca_2_SRup, K_dCasr, MgADP_cyt, Pi, Amp_SERCA, F, Sc_Cell, k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus);
	
%membranePotential
    [I_tot_K, I_tot_Na, I_tot_Ca_blk, I_tot_Ca_iz, I_tot_Ca_jnc, I_tot_Ca, I_tot_cell, dVmdt] = membranePotential(I_CaL_K_jnc, I_CaL_K_iz, I_CaL_K_blk, I_NaT_K, I_NaL_K, I_K1, I_Kr, I_Ks_K_iz, I_Ks_K_blk, I_Kto, I_Kpl, I_NaK_K, I_KATP, I_bNSC_K, I_l_Ca_K_iz, I_l_Ca_K_blk,...
    I_CaL_Na_jnc, I_CaL_Na_iz, I_CaL_Na_blk, I_NCX_Na_iz, I_NCX_Na_blk, I_Ks_Na_iz, I_Ks_Na_blk, I_NaT_Na, I_NaL_Na, I_NaK_Na, I_Kto_Na, I_bNSC_Na, I_l_Ca_Na_iz, I_l_Ca_Na_blk,...
    I_CaL_Ca_blk, I_PMCA_blk, I_NCX_Ca_blk, I_Cab_blk, I_CaL_Ca_iz, I_PMCA_iz, I_NCX_Ca_iz, I_Cab_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_app);
    
%contraction
%	[TS, rate_g, rate_gd, dTSCa_3dt, dTSCa_3Wdt, dTSCa_3Sdt, dTS_Sdt, dTS_Wdt, dhwdt , dhpdt,Fb,hw,hp] = contraction(TS_tot, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, Za, Yv, propFh, hw, hwr, Yd, Yc, halfSL, Lc, Yvd, Yb, TS, Ca_2_blk,...
%    Zb, rate_f, convertF, eqvhalfSL, Zp, Yp, Yr, Zr, Zq, Yq, rate_B, hp, hpr);
[TS, rate_g, rate_gd, dTSCa_3dt, dTSCa_3Wdt, dTSCa_3Sdt, dTS_Sdt, dTS_Wdt,Fb,hw,hp] = contraction(TS_tot, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, Za, Yv, propFh, hw, hwr, Yd, Yc, halfSL, Lc, Yvd, Yb, TS, Ca_2_blk,...
    Zb, rate_f, convertF, eqvhalfSL, Zp, Yp, Yr, Zr, Zq, Yq, rate_B, hp, hpr);
%ionConcentration
	[dCa_2_tot_jncdt, dCa_2_tot_izdt, dCa_2_tot_blkdt, dCa_2_SRupdt, dCa_2_tot_SRrldt, dNaidt, dKidt] = ionConcentration(I_tot_Ca_jnc, V_jnc, Cm, F, J_Ca_rel, J_Ca_jnciz, I_tot_Ca_iz, V_iz, J_Ca_izblk, I_tot_Ca_blk, V_blk, J_SERCA, V_SRup, J_trans_SR, V_SRrl, I_tot_Na, V_cyt, I_tot_K, I_app);
    
%euler
	[CaMCa, TnChCa, SRCa, p_O_NaT, p_I_2_NaT, p_I_s_NaT, p_O_NaL, p_I_1_NaL, p_I_2_NaL, p_I_s_NaL, chi_r_fast, chi_r_slow, para_Xs1, para_Xs2, i_fast, i_slow, P_7, P_8_13, P_1_6, p_E_1_NCX_blk, p_I_1_NCX_blk,...
    p_I_2_NCX_blk, p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, Vm, Y_co_iz, Y_oo_iz, Y_oc_iz, Y_co_blk, Y_oo_blk, Y_oc_blk, Ca_2_tot_jnc, Ca_2_tot_iz, Ca_2_tot_blk, Ca_2_SRup,...
    Ca_2_tot_SRrl, Nai, Ki, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, hw, hp, Pb_spm, a] = euler(CaMCa, dCaMCadt, TnChCa, dTnChCadt, SRCa, dSRCadt, p_O_NaT, dp_O_NaTdt, p_I_2_NaT, dp_I_2_NaTdt, p_I_s_NaT, dp_I_s_NaTdt, p_O_NaL, dp_O_NaLdt, p_I_1_NaL, dp_I_1_NaLdt, p_I_2_NaL, dp_I_2_NaLdt,...
    p_I_s_NaL, dp_I_s_NaLdt, chi_r_fast, dchi_r_fastdt, chi_r_slow, dchi_r_slowdt, para_Xs1, dpara_Xs1dt, para_Xs2, dpara_Xs2dt, i_fast, di_fastdt, i_slow, di_slowdt, P_7, dP_7dt, P_8_13, dP_8_13dt, P_1_6, dP_1_6dt,...
    p_E_1_NCX_blk, dp_E_1_NCX_blkdt, p_I_1_NCX_blk, dp_I_1_NCX_blkdt, p_I_2_NCX_blk, dp_I_2_NCX_blkdt, p_E_1_NCX_iz, dp_E_1_NCX_izdt, p_I_1_NCX_iz, dp_I_1_NCX_izdt, p_I_2_NCX_iz, dp_I_2_NCX_izdt, Y_ooo, dY_ooodt,...
    Y_ooc, dY_oocdt, Y_coo, dY_coodt, Y_coc, dY_cocdt, Y_cco, dY_ccodt, Y_oco, dY_ocodt, Y_occ, dY_occdt, Vm, dVmdt, Y_co_iz, dY_co_izdt, Y_oo_iz, dY_oo_izdt, Y_oc_iz, dY_oc_izdt, Y_co_blk, dY_co_blkdt,...
    Y_oo_blk, dY_oo_blkdt, Y_oc_blk, dY_oc_blkdt, Ca_2_tot_jnc, dCa_2_tot_jncdt, Ca_2_tot_iz, dCa_2_tot_izdt, Ca_2_tot_blk, dCa_2_tot_blkdt, Ca_2_SRup, dCa_2_SRupdt, Ca_2_tot_SRrl, dCa_2_tot_SRrldt, Nai, dNaidt,...
    Ki, dKidt, TSCa_3, dTSCa_3dt, TSCa_3W, dTSCa_3Wdt, TSCa_3S, dTSCa_3Sdt, TS_S, dTS_Sdt, TS_W, dTS_Wdt, hw, dhwdt, hp, dhpdt, Pb_spm, dPb_spmdt, a, dadt, dt);

%things to output
calcium_transient_full(k) = Ca_2_blk*1000; %calcium concentration in cytosol (convert to uM)
J_SERCA_full(k) = J_SERCA; %SERCA flux
V_SERCA_full(k) = v_cyc; %SERCA cycling velocity
Vm_full(k) = Vm; %membrane voltage
Fb_full(k) = Fb; %XB force
hw_full(k) = hw;
hp_full(k) = hp;
dhwdt_full(k) = dhwdt;
dhpdt_full(k) = dhpdt;
k = k+1;
end
    for j = 1:1:size(time,2) %get just the values we want from full Ca transient
        time2 = time(j)*10;
        calcium_transient(j) = calcium_transient_full(time2);
        SSE = (calcium_transient(j) - Korte(j))^2;
        SSE_tot = SSE_tot + SSE;
        membrane_voltage(j) = Vm_full(time2);
        SERCA_velocity(j) = V_SERCA_full(time2);
        SERCA_flux(j) = J_SERCA_full(time2);
        XB_Force(j) = Fb_full(time2);
        HW(j) = hw_full(time2);
        HP(j) = hp_full(time2);
        DHWDT(j) = dhwdt_full(time2);
        DHPDT(j) = dhpdt_full(time2);
    end
end


%% functions
%time-dependent variables
function [CaMCa, TnChCa, SRCa, p_O_NaT, p_I_2_NaT, p_I_s_NaT, p_O_NaL, p_I_1_NaL, p_I_2_NaL, p_I_s_NaL, chi_r_fast, chi_r_slow, para_Xs1, para_Xs2, i_fast, i_slow, P_7, P_8_13, P_1_6, p_E_1_NCX_blk, p_I_1_NCX_blk,...
p_I_2_NCX_blk, p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, Vm, Y_co_iz, Y_oo_iz, Y_oc_iz, Y_co_blk, Y_oo_blk, Y_oc_blk, Ca_2_tot_jnc, Ca_2_tot_iz, Ca_2_tot_blk, Ca_2_SRup,...
Ca_2_tot_SRrl, Nai, Ki, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, hw, hp, Pb_spm, a] = euler(CaMCa, dCaMCadt, TnChCa, dTnChCadt, SRCa, dSRCadt, p_O_NaT, dp_O_NaTdt, p_I_2_NaT, dp_I_2_NaTdt, p_I_s_NaT, dp_I_s_NaTdt, p_O_NaL, dp_O_NaLdt, p_I_1_NaL, dp_I_1_NaLdt, p_I_2_NaL, dp_I_2_NaLdt,...
p_I_s_NaL, dp_I_s_NaLdt, chi_r_fast, dchi_r_fastdt, chi_r_slow, dchi_r_slowdt, para_Xs1, dpara_Xs1dt, para_Xs2, dpara_Xs2dt, i_fast, di_fastdt, i_slow, di_slowdt, P_7, dP_7dt, P_8_13, dP_8_13dt, P_1_6, dP_1_6dt,...
p_E_1_NCX_blk, dp_E_1_NCX_blkdt, p_I_1_NCX_blk, dp_I_1_NCX_blkdt, p_I_2_NCX_blk, dp_I_2_NCX_blkdt, p_E_1_NCX_iz, dp_E_1_NCX_izdt, p_I_1_NCX_iz, dp_I_1_NCX_izdt, p_I_2_NCX_iz, dp_I_2_NCX_izdt, Y_ooo, dY_ooodt,...
Y_ooc, dY_oocdt, Y_coo, dY_coodt, Y_coc, dY_cocdt, Y_cco, dY_ccodt, Y_oco, dY_ocodt, Y_occ, dY_occdt, Vm, dVmdt, Y_co_iz, dY_co_izdt, Y_oo_iz, dY_oo_izdt, Y_oc_iz, dY_oc_izdt, Y_co_blk, dY_co_blkdt,...
Y_oo_blk, dY_oo_blkdt, Y_oc_blk, dY_oc_blkdt, Ca_2_tot_jnc, dCa_2_tot_jncdt, Ca_2_tot_iz, dCa_2_tot_izdt, Ca_2_tot_blk, dCa_2_tot_blkdt, Ca_2_SRup, dCa_2_SRupdt, Ca_2_tot_SRrl, dCa_2_tot_SRrldt, Nai, dNaidt,...
Ki, dKidt, TSCa_3, dTSCa_3dt, TSCa_3W, dTSCa_3Wdt, TSCa_3S, dTSCa_3Sdt, TS_S, dTS_Sdt, TS_W, dTS_Wdt, hw, dhwdt, hp, dhpdt, Pb_spm, dPb_spmdt, a, dadt,dt)
	CaMCa = CaMCa + dCaMCadt * dt;
	TnChCa = TnChCa + dTnChCadt * dt;
	SRCa = SRCa + dSRCadt * dt;
	p_O_NaT = p_O_NaT + dp_O_NaTdt * dt;
	p_I_2_NaT = p_I_2_NaT + dp_I_2_NaTdt * dt;
	p_I_s_NaT = p_I_s_NaT + dp_I_s_NaTdt * dt;
	p_O_NaL = p_O_NaL + dp_O_NaLdt * dt;
	p_I_1_NaL = p_I_1_NaL + dp_I_1_NaLdt * dt;
	p_I_2_NaL = p_I_2_NaL + dp_I_2_NaLdt * dt;
	p_I_s_NaL = p_I_s_NaL + dp_I_s_NaLdt * dt;
	chi_r_fast = chi_r_fast + dchi_r_fastdt * dt;
	chi_r_slow = chi_r_slow + dchi_r_slowdt * dt;
	para_Xs1 = para_Xs1 + dpara_Xs1dt * dt;
	para_Xs2 = para_Xs2 + dpara_Xs2dt * dt;
	i_fast = i_fast + di_fastdt * dt;
	i_slow = i_slow + di_slowdt * dt;
	P_7 = P_7 + dP_7dt * dt;
	P_8_13 = P_8_13 + dP_8_13dt * dt;
	P_1_6 = P_1_6 + dP_1_6dt * dt;
	p_E_1_NCX_blk = p_E_1_NCX_blk + dp_E_1_NCX_blkdt * dt;
	p_I_1_NCX_blk = p_I_1_NCX_blk + dp_I_1_NCX_blkdt * dt;
	p_I_2_NCX_blk = p_I_2_NCX_blk + dp_I_2_NCX_blkdt * dt;
	p_E_1_NCX_iz = p_E_1_NCX_iz + dp_E_1_NCX_izdt * dt;
	p_I_1_NCX_iz = p_I_1_NCX_iz + dp_I_1_NCX_izdt * dt;
	p_I_2_NCX_iz = p_I_2_NCX_iz + dp_I_2_NCX_izdt * dt;
	Y_ooo = Y_ooo + dY_ooodt * dt;
	Y_ooc = Y_ooc + dY_oocdt * dt;
	Y_coo = Y_coo + dY_coodt * dt;
	Y_coc = Y_coc + dY_cocdt * dt;
	Y_cco = Y_cco + dY_ccodt * dt;
	Y_oco = Y_oco + dY_ocodt * dt;
	Y_occ = Y_occ + dY_occdt * dt;
	Vm = Vm + dVmdt * dt;
	Y_co_iz = Y_co_iz + dY_co_izdt * dt;
	Y_oo_iz = Y_oo_iz + dY_oo_izdt * dt;
	Y_oc_iz = Y_oc_iz + dY_oc_izdt * dt;
	Y_co_blk = Y_co_blk + dY_co_blkdt * dt;
	Y_oo_blk = Y_oo_blk + dY_oo_blkdt * dt;
	Y_oc_blk = Y_oc_blk + dY_oc_blkdt * dt;
	Ca_2_tot_jnc = Ca_2_tot_jnc + dCa_2_tot_jncdt * dt;
	Ca_2_tot_iz = Ca_2_tot_iz + dCa_2_tot_izdt * dt;
	Ca_2_tot_blk = Ca_2_tot_blk + dCa_2_tot_blkdt * dt;
	Ca_2_SRup = Ca_2_SRup + dCa_2_SRupdt * dt;
	Ca_2_tot_SRrl = Ca_2_tot_SRrl + dCa_2_tot_SRrldt * dt;
	Nai = Nai + dNaidt * dt;
	Ki = Ki + dKidt * dt;
	TSCa_3 = TSCa_3 + dTSCa_3dt * dt;
	TSCa_3W = TSCa_3W + dTSCa_3Wdt * dt;
	TSCa_3S = TSCa_3S + dTSCa_3Sdt * dt;
	TS_S = TS_S + dTS_Sdt * dt;
	TS_W = TS_W + dTS_Wdt * dt;
	%hw = hw + dhwdt * dt;
	%hp = hp + dhpdt * dt;
	Pb_spm = Pb_spm + dPb_spmdt * dt;
	a = a + dadt * dt;
   % xw = xw + dxwdt*dt;
   % xp = xp + dxpdt*dt;
end

%contraction
function [TS, rate_g, rate_gd, dTSCa_3dt, dTSCa_3Wdt, dTSCa_3Sdt, dTS_Sdt, dTS_Wdt,Fb,hw,hp] = contraction(TS_tot, TSCa_3, TSCa_3W, TSCa_3S, TS_S, TS_W, Za, Yv, propFh, hw, hwr, Yd, Yc, halfSL, Lc, Yvd, Yb, TS, Ca_2_blk,...
    Zb, rate_f, convertF, eqvhalfSL, Zp, Yp, Yr, Zr, Zq, Yq, rate_B, hp, hpr) %Negroni and Lascano 2008 
	TS = TS_tot - TSCa_3 - TSCa_3W - TSCa_3S - TS_S - TS_W;
	rate_g = Za + Yv * (1 - exp(-propFh * (hw-hwr)^2));
	rate_gd = Yd + Yc * ((halfSL - Lc)^2) + Yvd * (1 - exp(-propFh * (hw-hwr)^2));
	dTSCa_3dt = Yb * TS * ((Ca_2_blk * 1000)^3) - Zb * TSCa_3 + rate_g * TSCa_3W - rate_f * exp(-convertF * (halfSL - eqvhalfSL)^2) * TSCa_3;
	dTSCa_3Wdt = rate_f * exp(-convertF * ((halfSL - eqvhalfSL)^2)) * TSCa_3 - rate_g * TSCa_3W + Zp * TSCa_3S - Yp * TSCa_3W;
	dTSCa_3Sdt = Yp * TSCa_3W - Zp * TSCa_3S + Zr * TS_S * ((Ca_2_blk * 1000)^3) - Yr * TSCa_3S;
    dTS_Sdt = Yr * TSCa_3S - Zr * TS_S * ((Ca_2_blk * 1000)^3) + Zq * TS_W - Yq * TS_S;
	dTS_Wdt = Yq * TS_S - Zq * TS_W - rate_gd * TS_W;
    dhwdt = -rate_B * (hw - hwr); %dh/dt + B(h-hr) = dL/dt
	dhpdt = -rate_B * (hp - hpr);
    Fb = 540*(TSCa_3+TS_W)*hw+2700*(TSCa_3S+TS_S)*hp;
end

%ion concentration
function [dCa_2_tot_jncdt, dCa_2_tot_izdt, dCa_2_tot_blkdt, dCa_2_SRupdt, dCa_2_tot_SRrldt, dNaidt, dKidt] = ionConcentration(I_tot_Ca_jnc, V_jnc, Cm, F, J_Ca_rel, J_Ca_jnciz, I_tot_Ca_iz, V_iz, J_Ca_izblk, I_tot_Ca_blk, V_blk, J_SERCA, V_SRup, J_trans_SR, V_SRrl, I_tot_Na, V_cyt, I_tot_K, I_app) %overall Ca, Na, K ion concentrations
	dCa_2_tot_jncdt = -I_tot_Ca_jnc * Cm / (V_jnc * 2 * F) + J_Ca_rel / V_jnc - J_Ca_jnciz / V_jnc;
	dCa_2_tot_izdt = -I_tot_Ca_iz * Cm / (V_iz * 2 * F) + J_Ca_jnciz / V_iz - J_Ca_izblk / V_iz;
	dCa_2_tot_blkdt = -I_tot_Ca_blk * Cm / (V_blk * 2 * F) - J_SERCA / V_blk + J_Ca_izblk / V_blk;
	dCa_2_SRupdt = J_SERCA / V_SRup - J_trans_SR / V_SRup;
	dCa_2_tot_SRrldt = J_trans_SR / V_SRrl - J_Ca_rel / V_SRrl;
	dNaidt = -I_tot_Na * Cm / (V_cyt * F);
	dKidt = -(I_tot_K + I_app) * Cm / (V_cyt * F);
end

%membrane potential
function [I_tot_K, I_tot_Na, I_tot_Ca_blk, I_tot_Ca_iz, I_tot_Ca_jnc, I_tot_Ca, I_tot_cell, dVmdt] = membranePotential(I_CaL_K_jnc, I_CaL_K_iz, I_CaL_K_blk, I_NaT_K, I_NaL_K, I_K1, I_Kr, I_Ks_K_iz, I_Ks_K_blk, I_Kto, I_Kpl, I_NaK_K, I_KATP, I_bNSC_K, I_l_Ca_K_iz, I_l_Ca_K_blk,...
    I_CaL_Na_jnc, I_CaL_Na_iz, I_CaL_Na_blk, I_NCX_Na_iz, I_NCX_Na_blk, I_Ks_Na_iz, I_Ks_Na_blk, I_NaT_Na, I_NaL_Na, I_NaK_Na, I_Kto_Na, I_bNSC_Na, I_l_Ca_Na_iz, I_l_Ca_Na_blk,...
    I_CaL_Ca_blk, I_PMCA_blk, I_NCX_Ca_blk, I_Cab_blk, I_CaL_Ca_iz, I_PMCA_iz, I_NCX_Ca_iz, I_Cab_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_app) %overall membrane potential
	I_tot_K = (I_CaL_K_jnc + I_CaL_K_iz + I_CaL_K_blk) + I_NaT_K + I_NaL_K + I_K1 + I_Kr + (I_Ks_K_iz + I_Ks_K_blk) + I_Kto + I_Kpl + I_NaK_K + I_KATP + I_bNSC_K + (I_l_Ca_K_iz + I_l_Ca_K_blk);
	I_tot_Na = (I_CaL_Na_jnc + I_CaL_Na_iz + I_CaL_Na_blk) + (I_NCX_Na_iz + I_NCX_Na_blk) + (I_Ks_Na_iz + I_Ks_Na_blk) + I_NaT_Na + I_NaL_Na + I_NaK_Na + I_Kto_Na + I_bNSC_Na + (I_l_Ca_Na_iz + I_l_Ca_Na_blk);
	I_tot_Ca_blk = I_CaL_Ca_blk + I_PMCA_blk + I_NCX_Ca_blk + I_Cab_blk;
	I_tot_Ca_iz = I_CaL_Ca_iz + I_PMCA_iz + I_NCX_Ca_iz + I_Cab_iz;
	I_tot_Ca_jnc = I_CaL_Ca_LR + I_CaL_Ca_L0;
	I_tot_Ca = I_tot_Ca_jnc + I_tot_Ca_iz + I_tot_Ca_blk;
	I_tot_cell = I_tot_Na + I_tot_Ca + I_tot_K;
	dVmdt = -(I_tot_cell + I_app);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SERCA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [alpha_1, alpha_2, alpha_3, beta_1, beta_2, beta_3, v_cyc, J_SERCA] = SERCA(MgATP_cyt, K_dCai, Ca_2_blk, Ca_2_SRup, K_dCasr, MgADP_cyt, Pi, Amp_SERCA, F, Sc_Cell, k1_plus, k2_plus, k3_plus, k1_minus, k2_minus, k3_minus);
    alpha_1 = k1_plus * MgATP_cyt;
    alpha_2 = k2_plus / (1 + (K_dCai / Ca_2_blk)^1.7);
    alpha_3 = k3_plus / (1 + (Ca_2_SRup / K_dCasr)^1.7);
    beta_1 = k1_minus / (1 + (Ca_2_blk / K_dCai)^1.7);
    beta_2 = k2_minus * MgADP_cyt / (1 + (K_dCasr / Ca_2_SRup)^1.7);
    beta_3 = k3_minus * Pi;
	v_cyc = 6.86 * (alpha_1 * alpha_2 * alpha_3 - beta_1 * beta_2 * beta_3) / (alpha_2 * alpha_3 + beta_1 * alpha_3 + beta_1 * beta_2 + alpha_1 * alpha_3 + beta_2 * alpha_1 + beta_2 * beta_3 + alpha_1 * alpha_2 + beta_3 * beta_1 + beta_3 * alpha_2);
	J_SERCA = Amp_SERCA * v_cyc / (2 * F) * Sc_Cell;
end

%CaRU
function [p_O_RyR, p_O_RyR_t, J_Ca_rel, Ca_2_nd_00, Ca_2_nd_L0, Ca_2_nd_0R, Ca_2_nd_LR, epsilon_plus_00, epsilon_plus_L0, epsilon_plus_0R, epsilon_plus_LR, k_co_00, k_co_L0, k_co_0R, k_co_LR,...
    f_t_00,f_t_L0, k_rco_0, k_rco_L, p_C_0, p_C_L, k_roc_0, k_roc_L, Y_ccc, dY_ooodt, dY_oocdt, dY_coodt, dY_cocdt, dY_ccodt, dY_ocodt, dY_occdt] = CaRU(p_O_RyR_base, P_RyR, Ca_2_SRrl, Ca_2_jnc,...
    Sc_Cell, f_L, delta_RTF, Vm, Cao, f_R, alpha_plus, T_L, K_L, Q_10, k_oc, f_n, sloc0, N_RyR, Y_ooo, Y_ooc, Y_coo, Y_coc, Y_cco, Y_oco, Y_occ, alpha_minus, epsilon_minus)

%Ca releasing unit (8 state model)
	p_O_RyR = Y_ooo + Y_coo + Y_cco + Y_oco;
	p_O_RyR_t = p_O_RyR + p_O_RyR_base;
    
	J_Ca_rel = P_RyR * p_O_RyR_t * (Ca_2_SRrl - Ca_2_jnc) * Sc_Cell;
    
	Ca_2_nd_00 = Ca_2_jnc;
	Ca_2_nd_L0 = (Ca_2_nd_00 + f_L * delta_RTF * Vm * exp(-delta_RTF * Vm) / (1 - exp(-delta_RTF * Vm)) * Cao) / (1 + f_L * delta_RTF * Vm / (1 - exp(-delta_RTF * Vm)));
	Ca_2_nd_0R = (Ca_2_nd_00 + f_R * Ca_2_SRrl) / (1 + f_R);
	Ca_2_nd_LR = (Ca_2_nd_00 + f_R * Ca_2_SRrl + f_L * delta_RTF * Vm * exp(-delta_RTF * Vm) / (1 - exp(-delta_RTF * Vm)) * Cao) / (1 + f_R + f_L * delta_RTF * Vm / (1 - exp(-delta_RTF * Vm)));
    
	epsilon_plus_00 = (Ca_2_nd_00 * alpha_plus) / (T_L * K_L);
	epsilon_plus_L0 = (Ca_2_nd_L0 * alpha_plus) / (T_L * K_L);
	epsilon_plus_0R = (Ca_2_nd_0R * alpha_plus) / (T_L * K_L);
	epsilon_plus_LR = (Ca_2_nd_LR * alpha_plus) / (T_L * K_L);
    
	k_co_00 = Q_10 * 0.4 / (1 + (0.025 / Ca_2_nd_00)^2.7);
	k_co_L0 = Q_10 * 0.4 / (1 + (0.025 / Ca_2_nd_L0)^2.7);
	k_co_0R = Q_10 * 0.4 / (1 + (0.025 / Ca_2_nd_0R)^2.7);
	k_co_LR = Q_10 * 0.4 / (1 + (0.025 / Ca_2_nd_LR)^2.7);
	f_t_00 = k_co_00 / (k_co_00 + k_oc);
	f_t_L0 = k_co_L0 / (k_co_L0 + k_oc);
	k_rco_0 = f_n * f_t_00 * k_co_0R * (sloc0 + Ca_2_SRrl);
	k_rco_L = f_n * f_t_L0 * k_co_LR * (sloc0 + Ca_2_SRrl);
	p_C_0 = k_oc / (k_oc + f_t_00 * (k_rco_0 / (f_n * f_t_00)));
	p_C_L = k_oc / (k_oc + f_t_00 * (k_rco_L / (f_n * f_t_L0)));
	k_roc_0 = k_oc * p_C_0^((N_RyR - 1)*0.74);
	k_roc_L = k_oc * p_C_L^((N_RyR - 1)*0.74);
    
	Y_ccc = 1 - (Y_ooo + Y_ooc + Y_coo + Y_coc + Y_cco + Y_oco + Y_occ);
	dY_ooodt = k_rco_L * Y_ooc + alpha_plus * Y_coo + epsilon_minus * Y_oco - (k_roc_L + alpha_minus + epsilon_plus_LR) * Y_ooo;
	dY_oocdt = alpha_plus * Y_coc + k_roc_L * Y_ooo + epsilon_minus * Y_occ - (alpha_minus + k_rco_L + epsilon_plus_L0) * Y_ooc;
	dY_coodt = k_rco_0 * Y_coc + alpha_minus * Y_ooo + epsilon_minus * Y_cco - (k_roc_0 + alpha_plus + epsilon_plus_0R) * Y_coo;
	dY_cocdt = k_roc_0 * Y_coo + alpha_minus * Y_ooc + epsilon_minus * Y_ccc - (k_rco_0 + alpha_plus + epsilon_plus_00) * Y_coc;
	dY_ccodt = k_rco_0 * Y_ccc + alpha_minus * Y_oco + epsilon_plus_0R * Y_coo - (k_roc_0 + alpha_plus + epsilon_minus) * Y_cco;
	dY_ocodt = k_rco_0 * Y_occ + alpha_plus * Y_cco + epsilon_plus_LR * Y_ooo - (k_roc_0 + alpha_minus + epsilon_minus) * Y_oco;
	dY_occdt = alpha_plus * Y_ccc + k_roc_0 * Y_oco + epsilon_plus_L0 * Y_ooc - (alpha_minus + k_rco_0 + epsilon_minus) * Y_occ;
end

%PMCA
function [I_PMCA_blk, I_PMCA_iz, I_PMCA] = currentPMCA(f_PMCA_blk, Amp_PMCA, Ca_2_blk, K_m, Ca_2_iz, f_PMCA_iz) %Plasma membrane Ca ATP ase (pumps ATP out of cell using ATP), ignore H+ transport
	I_PMCA_blk = f_PMCA_blk * Amp_PMCA * (Ca_2_blk^1.6) / ((K_m^1.6) + (Ca_2_blk^1.6));
	I_PMCA_iz = f_PMCA_iz * Amp_PMCA * (Ca_2_iz^1.6) / ((K_m^1.6) + (Ca_2_iz^1.6));
	I_PMCA = I_PMCA_iz + I_PMCA_blk;
end

%NCX
function [f_Caina_blk, f_Caina_iz, q_blk_E_1_Na, q_iz_E_1_Na, q_blk_E_1_Ca, q_iz_E_1_Ca, q_E_2_Na, q_E_2_Ca, alpha_1_blk, alpha_1_iz, beta_1_blk, beta_1_iz,...
    alpha_2_blk, alpha_2_iz, beta_2_blk, beta_2_iz, k_1, k_2, alpha_E, beta_E_blk, beta_E_iz, p_E_2_NCX_blk, p_E_2_NCX_iz, v_cyc_NCX_iz, v_cyc_NCX_blk, dp_E_1_NCX_blkdt,...
    dp_I_1_NCX_blkdt, dp_I_2_NCX_blkdt, dp_E_1_NCX_izdt, dp_I_1_NCX_izdt, dp_I_2_NCX_izdt, I_NCX_blk, I_NCX_iz, I_NCX, I_NCX_Na_blk, I_NCX_Na_iz, I_NCX_Ca_blk, I_NCX_Ca_iz] = currentNCX(Ca_2_blk, K_m_act,...
    Ca_2_iz, K_m_Nai, Nai, K_m_Cai, K_m_Nao, Nao, Cao, K_m_Cao, alpha_1_on, alpha_1_off, beta_1_on, beta_1_off, alpha_2_on, alpha_2_off, beta_2_on, beta_2_off, Vm, F, R, T, k_4, k_3, p_E_1_NCX_blk, p_I_1_NCX_blk, p_I_2_NCX_blk,...
    p_E_1_NCX_iz, p_I_1_NCX_iz, p_I_2_NCX_iz, f_NCX_blk, Amp_NCX, f_NCX_iz) %NCX transporter (pumps Ca2+ out and Na+ in)
	f_Caina_blk = Ca_2_blk / (Ca_2_blk + K_m_act);
	f_Caina_iz = Ca_2_iz / (Ca_2_iz + K_m_act);
	q_blk_E_1_Na = 1.0 / (1.0 + ((K_m_Nai / Nai)^3) * (1.0 + Ca_2_blk / K_m_Cai));
	q_iz_E_1_Na = 1.0 / (1.0 + ((K_m_Nai / Nai)^3) * (1.0 + Ca_2_iz / K_m_Cai));
	q_blk_E_1_Ca = 1.0 / (1.0 + K_m_Cai / Ca_2_blk * (1.0 + ((Nai / K_m_Nai)^3)));
	q_iz_E_1_Ca = 1.0 / (1.0 + K_m_Cai / Ca_2_iz * (1.0 + ((Nai / K_m_Nai)^3)));
	q_E_2_Na = 1.0 / (1.0 + ((K_m_Nao / Nao)^3) * (1.0 + Cao / K_m_Cao));
	q_E_2_Ca = 1.0 / (1.0 + K_m_Cao / Cao * (1.0 + ((Nao / K_m_Nao)^3)));
	alpha_1_blk = q_blk_E_1_Na * (f_Caina_blk * alpha_1_on + (1 - f_Caina_blk) * alpha_1_off);
	alpha_1_iz = q_iz_E_1_Na * (f_Caina_iz * alpha_1_on + (1 - f_Caina_iz) * alpha_1_off);
	beta_1_blk = f_Caina_blk * beta_1_on + (1 - f_Caina_blk) * beta_1_off;
	beta_1_iz = f_Caina_iz * beta_1_on + (1 - f_Caina_iz) * beta_1_off;
	alpha_2_blk = f_Caina_blk * alpha_2_on + (1 - f_Caina_blk) * alpha_2_off;
	alpha_2_iz = f_Caina_iz * alpha_2_on + (1 - f_Caina_iz) * alpha_2_off;
	beta_2_blk = f_Caina_blk * beta_2_on + (1 - f_Caina_blk) * beta_2_off;
	beta_2_iz = f_Caina_iz * beta_2_on + (1 - f_Caina_iz) * beta_2_off;
	k_1 = exp((0.32 * F * Vm) / (R * T));
	k_2 = exp(((0.32 - 1) * F * Vm) / (R * T));
	alpha_E = k_2 * q_E_2_Na + k_4 * q_E_2_Ca;
	beta_E_blk = k_1 * q_blk_E_1_Na + k_3 * q_blk_E_1_Ca;
	beta_E_iz = k_1 * q_iz_E_1_Na + k_3 * q_iz_E_1_Ca;
	p_E_2_NCX_blk = 1 - p_E_1_NCX_blk - p_I_1_NCX_blk - p_I_2_NCX_blk;
	p_E_2_NCX_iz = 1 - p_E_1_NCX_iz - p_I_1_NCX_iz - p_I_2_NCX_iz;
	v_cyc_NCX_blk = k_1 * q_blk_E_1_Na * p_E_1_NCX_blk - k_2 * q_E_2_Na * p_E_2_NCX_blk;
	v_cyc_NCX_iz = k_1 * q_iz_E_1_Na * p_E_1_NCX_iz - k_2 * q_E_2_Na * p_E_2_NCX_iz;
	dp_E_1_NCX_blkdt = p_E_2_NCX_blk * alpha_E + p_I_1_NCX_blk * beta_1_blk + p_I_2_NCX_blk * beta_2_blk - p_E_1_NCX_blk * (beta_E_blk + alpha_1_blk + alpha_2_blk);
	dp_I_1_NCX_blkdt = p_E_1_NCX_blk * alpha_1_blk - p_I_1_NCX_blk * beta_1_blk;
	dp_I_2_NCX_blkdt = p_E_1_NCX_blk * alpha_2_blk - p_I_2_NCX_blk * beta_2_blk;
	dp_E_1_NCX_izdt = p_E_2_NCX_iz * alpha_E + p_I_1_NCX_iz * beta_1_iz + p_I_2_NCX_iz * beta_2_iz - p_E_1_NCX_iz * (beta_E_iz + alpha_1_iz + alpha_2_iz);
	dp_I_1_NCX_izdt = p_E_1_NCX_iz * alpha_1_iz - p_I_1_NCX_iz * beta_1_iz;
	dp_I_2_NCX_izdt = p_E_1_NCX_iz * alpha_2_iz - p_I_2_NCX_iz * beta_2_iz;
	I_NCX_blk = f_NCX_blk * Amp_NCX * v_cyc_NCX_blk;
	I_NCX_iz = f_NCX_iz * Amp_NCX * v_cyc_NCX_iz;
	I_NCX = I_NCX_iz + I_NCX_blk;
	I_NCX_Na_blk = 3 * I_NCX_blk;
	I_NCX_Na_iz = 3 * I_NCX_iz;
	I_NCX_Ca_blk = -2 * I_NCX_blk;
	I_NCX_Ca_iz = -2 * I_NCX_iz;
end

%NaK
function [K_d_Nai, K_d_Nao, K_d_Ki, K_d_Ko, Nai_bar, Nao_bar, Ki_bar, Ko_bar, MgATP_bar, alpha_1_plus, alpha_3_plus, alpha_4_plus,...
    alpha_1_minus, alpha_2_minus, alpha_3_minus, alpha_4_minus, P_14_15, V_step1, V_step2, V_step3, V_step4, v_cyc_NaK, dP_1_6dt,...
    dP_7dt, dP_8_13dt, I_NaK, I_NaK_Na, I_NaK_K] = currentNaK(K_d_Nai_0, delta_Nai, F, Vm, R, T, delta_Nao, K_d_Nao_0, K_d_Ki_0,...
    delta_Ki, K_d_Ko_0, delta_Ko, Nai, Nao, Ki, Ko, MgATP_cyt, K_d_MgATP, k_1_plus, k_3_plus, k_4_plus, k_1_minus, MgADP_cyt,...
    k_2_minus, k_3_minus, k_4_minus, Pi, H, P_1_6, P_7, P_8_13, alpha_2_plus, Amp_NaK, Stoi_NaK_Na, Stoi_NaK_K) %NaK (pumps Na+ out, K+ in); Oka et al. model
	K_d_Nai = K_d_Nai_0 * exp((delta_Nai * F * Vm) / (R * T));
	K_d_Nao = K_d_Nao_0 * exp((delta_Nao * F * Vm) / (R * T));
	K_d_Ki = K_d_Ki_0 * exp((delta_Ki * F * Vm) / (R * T));
	K_d_Ko = K_d_Ko_0 * exp((delta_Ko * F * Vm) / (R * T));
	Nai_bar = Nai / K_d_Nai;
	Nao_bar = Nao / K_d_Nao;
	Ki_bar = Ki / K_d_Ki;
	Ko_bar = Ko / K_d_Ko;
	MgATP_bar = MgATP_cyt / K_d_MgATP;
	alpha_1_plus = k_1_plus * (Nai_bar^3) / (((1 + Nai_bar)^3) + ((1 + Ki_bar)^2) - 1);
	alpha_3_plus = k_3_plus * (Ko_bar^2) / (((1 + Nao_bar)^3) + ((1 + Ko_bar)^2) - 1);
	alpha_4_plus = k_4_plus * MgATP_bar / (1 + MgATP_bar);
	alpha_1_minus = k_1_minus * MgADP_cyt;
	alpha_2_minus = k_2_minus * (Nao_bar^3) / (((1 + Nao_bar)^3) + ((1 + Ko_bar)^2) - 1);
	alpha_3_minus = k_3_minus * Pi * H / (1 + MgATP_bar);
	alpha_4_minus = k_4_minus * (Ki_bar^2) / (((1 + Nai_bar)^3) + ((1 + Ki_bar)^2) - 1);
	P_14_15 = 1 - P_1_6 - P_7 - P_8_13;
	V_step1 = alpha_1_plus * P_1_6 - alpha_1_minus * P_7;
	V_step2 = alpha_2_plus * P_7 - alpha_2_minus * P_8_13;
	V_step3 = alpha_3_plus * P_8_13 - alpha_3_minus * P_14_15;
	V_step4 = alpha_4_plus * P_14_15 - alpha_4_minus * P_1_6;
	v_cyc_NaK = V_step2;
	dP_1_6dt = -alpha_1_plus * P_1_6 + alpha_1_minus * P_7 + alpha_4_plus * P_14_15 - alpha_4_minus * P_1_6;
	dP_7dt = -alpha_2_plus * P_7 + alpha_2_minus * P_8_13 + alpha_1_plus * P_1_6 - alpha_1_minus * P_7;
	dP_8_13dt = -alpha_3_plus * P_8_13 + alpha_3_minus * P_14_15 + alpha_2_plus * P_7 - alpha_2_minus * P_8_13;
	I_NaK = Amp_NaK * v_cyc_NaK;
	I_NaK_Na = Stoi_NaK_Na * I_NaK;
	I_NaK_K = Stoi_NaK_K * I_NaK;
end

%KATP
function [p_O_KATP, chi_KATP, I_KATP] = currentKATP(ATP_cyt, Ko, G_KATP, Vm, E_K) %ATP sensitive potassium current
	p_O_KATP = 0.8 / (1.0 + ((ATP_cyt / 0.1)^2));
	chi_KATP = 0.0236 * (Ko^0.24);
	I_KATP = G_KATP * (Vm - E_K) * p_O_KATP * chi_KATP;
end

%lCA
function [p_O_blk, p_O_iz, I_l_Ca_Na_blk, I_l_Ca_Na_iz, I_l_Ca_K_blk, I_l_Ca_K_iz, I_l_Ca] = currentlCa(Ca_2_blk, Ca_2_iz, P_l_Ca_Na, f_l_Ca_blk, f_l_Ca_iz, GHK_Na, GHK_K, P_l_Ca_K) %calcium activated background cation current
	p_O_blk = 1.0 / (1.0 + ((0.0012 / Ca_2_blk)^3));
	p_O_iz = 1.0 / (1.0 + ((0.0012 / Ca_2_iz)^3));
	I_l_Ca_Na_blk = P_l_Ca_Na * f_l_Ca_blk * GHK_Na * p_O_blk;
	I_l_Ca_Na_iz = P_l_Ca_Na * f_l_Ca_iz * GHK_Na * p_O_iz;
	I_l_Ca_K_blk = P_l_Ca_K * f_l_Ca_blk * GHK_K * p_O_blk;
	I_l_Ca_K_iz = P_l_Ca_K * f_l_Ca_iz * GHK_K * p_O_iz;
	I_l_Ca = I_l_Ca_Na_iz + I_l_Ca_K_iz + I_l_Ca_Na_blk + I_l_Ca_K_blk;
end

%bNSC
function [I_bNSC_K, I_bNSC_Na, I_bNSC] = currentbNSC(P_bNSC_K, GHK_K, P_bNSC_Na, GHK_Na) %background nonselective current
	I_bNSC_K = P_bNSC_K * GHK_K;
	I_bNSC_Na = P_bNSC_Na * GHK_Na;
	I_bNSC = I_bNSC_K + I_bNSC_Na;
end

%Cab
function [I_Cab_blk, I_Cab_iz, I_Cab] = currentCab(P_Cab, f_Cab_blk, GHK_Ca_blk, f_Cab_iz, GHK_Ca_iz) %background current
	I_Cab_blk = P_Cab * f_Cab_blk * GHK_Ca_blk;
	I_Cab_iz = P_Cab * f_Cab_iz * GHK_Ca_iz;
	I_Cab = I_Cab_iz + I_Cab_blk;
end

%Kpl
function [p_O_Kpl, chi_Kpl, I_Kpl] = currentKpl(Vm, Ko, P_Kpl, GHK_K) %voltage dependent potassium current (plateau current)
	p_O_Kpl = Vm / (1 - exp(-Vm / 13.0));
	chi_Kpl = (Ko / 5.4)^0.16;
	I_Kpl = P_Kpl * chi_Kpl * p_O_Kpl * GHK_K;
end

%Kto
function [a_infinity, tau_a, dadt, i_infinity, tau_i_fast, tau_i_slow, A_i_fast, A_i_slow, di_fastdt, di_slowdt, i, p_O_Kto, I_Kto] = currentKto(Vm, i_fast, i_slow, a, G_Kto, E_K) %transient outward K current
	a_infinity = 1 / (1 + exp(-(Vm - 14.34) / 14.82));
	tau_a = 1.0515 / (1 / (1.2089 * (1 + exp(-(Vm - 18.41) / 29.38))) + 3.5 / (1 + exp((Vm + 100) / 29.38)));
	dadt = (a_infinity - a) / tau_a;
	i_infinity = 1 / (1 + exp((Vm + 43.94) / 5.711));
	tau_i_fast = 4.562 + 1 / (0.3933 * exp(-(Vm + 100) / 100) + 0.08004 * exp((Vm + 50) / 16.59));
	tau_i_slow = 23.62 + 1 / (0.001416 * exp(-(Vm + 96.52) / 59.05) + 0.000000017808 * exp((Vm + 114.1) / 8.079));
	A_i_fast = 1 / (1 + exp((Vm - 213.6) / 151.2));
	A_i_slow = 1 - A_i_fast;
	di_fastdt = (i_infinity - i_fast) / tau_i_fast;
	di_slowdt = (i_infinity - i_slow) / tau_i_slow;
	i = A_i_fast * i_fast + A_i_slow * i_slow;
	p_O_Kto = a * i;
	I_Kto = G_Kto * p_O_Kto * (Vm - E_K);
end

%Ks
function [para_Xs1_infinity, tau_Xs1, dpara_Xs1dt, para_Xs2_infinity, tau_Xs2, dpara_Xs2dt, para_RKs_blk, para_RKs_iz, p_O_Ks_blk,...
    p_O_Ks_iz, I_Ks_K_blk, I_Ks_K_iz, I_Ks_Na_blk, I_Ks_Na_iz, I_Ks] = currentKs(Vm, para_Xs1, para_Xs2, Ca_2_blk, Ca_2_iz, f_Ks_blk, P_Ks_K, GHK_K, f_Ks_iz, P_Ks_Na, GHK_Na) %delayed rectifier K+ current, slow component
	para_Xs1_infinity = 1 / (1 + exp(-(Vm + 11.60) / 8.932));
	tau_Xs1 = 817.3 + 1 / (0.0002326 * exp((Vm + 48.28) / 17.80) + 0.001292 * exp(-(Vm + 210.0) / 230.0));
	dpara_Xs1dt = (para_Xs1_infinity - para_Xs1) / tau_Xs1;
	para_Xs2_infinity = para_Xs1_infinity;
	tau_Xs2 = 1 / (0.01 * exp((Vm - 50) / 20) + 0.0193 * exp(-(Vm + 66.54) / 31));
	dpara_Xs2dt = (para_Xs2_infinity - para_Xs2) / tau_Xs2;
	para_RKs_blk = 1 + 0.6 / (1 + ((0.000038 / Ca_2_blk)^1.4));
	para_RKs_iz = 1 + 0.6 / (1 + ((0.000038 / Ca_2_iz)^1.4));
	p_O_Ks_blk = para_Xs1 * para_Xs2 * para_RKs_blk;
	p_O_Ks_iz = para_Xs1 * para_Xs2 * para_RKs_iz;
	I_Ks_K_blk = f_Ks_blk * P_Ks_K * GHK_K * p_O_Ks_blk;
	I_Ks_K_iz = f_Ks_iz * P_Ks_K * GHK_K * p_O_Ks_iz;
	I_Ks_Na_blk = f_Ks_blk * P_Ks_Na * GHK_Na * p_O_Ks_blk;
	I_Ks_Na_iz = f_Ks_iz * P_Ks_Na * GHK_Na * p_O_Ks_iz;
	I_Ks = I_Ks_K_blk + I_Ks_K_iz + I_Ks_Na_blk + I_Ks_Na_iz;
end

%Kr
function [chi_r_infinity, tau_chi_r_fast, tau_chi_r_slow, A_chi_r_fast, A_chi_r_slow, dchi_r_fastdt, dchi_r_slowdt, chi_r, R_Kr, p_O_Kr, chi_Kr, I_Kr] = currentKr(Vm, chi_r_fast, chi_r_slow, Ko, G_Kr, E_K) %delayed rectifier K+ current, fast component
	chi_r_infinity = 1 / (1 + exp(-(Vm + 8.337) / 6.789));
	tau_chi_r_fast = 12.98 + 1 / (0.3652 * exp((Vm - 31.66) / 3.869) + 0.00004123 * exp(-(Vm - 47.78) / 20.38));
	tau_chi_r_slow = 1.865 + 1 / (0.06629 * exp((Vm - 34.70) / 7.355) + 0.00001128 * exp(-(Vm - 19.74) / 25.94));
	A_chi_r_fast = 1 / (1 + exp((Vm + 4.81) / 38.21));
	A_chi_r_slow = 1 - A_chi_r_fast;
	dchi_r_fastdt = (chi_r_infinity - chi_r_fast) / tau_chi_r_fast;
	dchi_r_slowdt = (chi_r_infinity - chi_r_slow) / tau_chi_r_slow;
	chi_r = A_chi_r_fast * chi_r_fast + A_chi_r_slow * chi_r_slow;
	R_Kr = 1 / ((1 + exp((Vm + 55) / 75)) * (1 + exp((Vm - 10) / 30)));
	p_O_Kr = chi_r * R_Kr;
	chi_Kr = sqrt(Ko / 4.5);
	I_Kr = G_Kr * chi_Kr * (Vm - E_K) * p_O_Kr;
end

%K1
function [alpha_Mg, beta_Mg, f_O, f_B, po_Mg, po_Mg1, po_Mg2, alpha_SPM, beta_SPM, dPb_spmdt, po_mode1, po_mode2, p_O_K1, chi_K1, I_K1] = currentK1(Vm, E_K, Mg_2_cyt, SPM, Pb_spm, f_mode1, Ko, G_K1) %inward rectifier potassium current (Yan and Ishihara 2005)
	alpha_Mg = 12.0 * exp(-0.025 * (Vm - E_K)); %reverse rate constant Mg
	beta_Mg = 28 * Mg_2_cyt * exp(0.025 * (Vm - E_K)); %reverse rate constant Mg
	f_O = alpha_Mg / (alpha_Mg + beta_Mg);
	f_B = beta_Mg / (alpha_Mg + beta_Mg);
	po_Mg = f_O * f_O * f_O; %probability of all Mg being open*/
	po_Mg1 = 3.0 * f_O * f_O * f_B; %probability of Mg1 being open*/
	po_Mg2 = 3.0 * f_O * f_B * f_B; %probability of Mg2 being open*/
	alpha_SPM = 0.17 * exp(-0.07 * (Vm - E_K + 8 * Mg_2_cyt)) / (1.0 + 0.01 * exp(0.12 * (Vm - E_K + 8 * Mg_2_cyt))); %forward rate constant spermine
	beta_SPM = 0.28 * SPM * exp(0.15 * (Vm - E_K + 8 * Mg_2_cyt)) / (1.0 + 0.01 * exp(0.13 * (Vm - E_K + 8 * Mg_2_cyt))); %reverse rate constant spermine
    
	dPb_spmdt = beta_SPM * po_Mg * (1 - Pb_spm) - alpha_SPM * Pb_spm;
    po_mode1 = f_mode1 * (1 - Pb_spm) * (po_Mg + (2.0 / 3.0) * po_Mg1 + (1.0 / 3.0) * po_Mg2); %mode 1: spermidine and Mg compete for channel
    po_mode2 = (1 - f_mode1) / (1.0 + SPM / (40.0 * exp(-(Vm - E_K) / 9.1))); %mode 2: spermine instantaneously blocks channel (Vm dependent)
	p_O_K1 = po_mode1 + po_mode2;
	chi_K1 = ((Ko / 4.5)^0.4) / (1.0 + exp(-(Ko - 2.2) / 0.6));
	I_K1 = G_K1 * chi_K1 * (Vm - E_K) * p_O_K1;
end

%Na
function [f_C_Na, k_C2O, k_OC, k_OI2, k_C2I2, k_I2C, k_Isb, k_Isf, k_OI1, k_I1C, k_C2I1, p_C_NaT, dp_O_NaTdt, dp_I_2_NaTdt, dp_I_s_NaTdt,...
    p_C_NaL, dp_O_NaLdt, dp_I_1_NaLdt, dp_I_2_NaLdt, dp_I_s_NaLdt, I_NaT_Na, I_NaT_K, I_NaT, I_NaL_Na, I_NaL_K, I_NaL, I_Na] = currentNa(Vm, k_I2O, p_I_2_NaT, p_I_s_NaT, p_O_NaT, p_I_2_NaL, p_I_s_NaL,...
    p_I_1_NaL, p_O_NaL, k_I1O, k_I1I2, f_LSM, P_Na, GHK_Na, GHK_K) %Na current
	f_C_Na = 1 / (1 + exp(-(Vm + 48) / 7)); %instantaneous distribution between C1 and C2 states
	k_C2O = 1 / (0.0025 * exp(Vm / -8.0) + 0.15 * exp(Vm / -100.0)); %C2 to O transient and late
	k_OC = 1 / (30 * exp(Vm / 12.0) + 0.53 * exp(Vm / 50.0)); %O to C2 transient and late
	k_OI2 = 1 / (0.0433 * exp(Vm / -27.0) + 0.34 * exp(Vm / -2000.0)); %O to I2 transient
	k_C2I2 = 0.5 / (1.0 + (k_I2O * k_OC) / (k_OI2 * k_C2O)); %C2 to I2 transient and late
	k_I2C = 0.5 - k_C2I2; %I2 to C2 transient and late
	k_Isb = 1 / (300000.0 * exp(Vm / 10.0) + 50000 * exp(Vm / 16.0)); %Is to C1 transient and late
	k_Isf = 1 / (0.016 * exp(Vm / -9.9) + 8.0 * exp(Vm / -45.0)); %C1 to Is transient and late
	k_OI1 = k_OI2; %O to I1 late
	k_I1C = k_I2C; %I1 to C late%
	k_C2I1 = k_C2I2; %C2 to I1 late
	p_C_NaT = 1.0 - p_I_2_NaT - p_I_s_NaT - p_O_NaT; %probability of closed state transient%
	dp_O_NaTdt = k_I2O * p_I_2_NaT + f_C_Na * k_C2O * p_C_NaT - (k_OC + k_OI2) * p_O_NaT; %rate of change of open state transient%
	dp_I_2_NaTdt = f_C_Na * k_C2I2 * p_C_NaT + k_OI2 * p_O_NaT + k_Isb * p_I_s_NaT - (k_I2C + k_I2O + k_Isf) * p_I_2_NaT; %rate of change of I2 state transient%
	dp_I_s_NaTdt = k_Isf * p_I_2_NaT + k_Isf * p_C_NaT - 2 * k_Isb * p_I_s_NaT; %rate of change of Is state transient%
	p_C_NaL = 1.0 - p_I_2_NaL - p_I_s_NaL - p_I_1_NaL - p_O_NaL; %probability of closed state late
	dp_O_NaLdt = k_I1O * p_I_1_NaL + f_C_Na * k_C2O * p_C_NaL - (k_OC + k_OI1) * p_O_NaL; %rate of change of closed state late
	dp_I_1_NaLdt = k_OI1 * p_O_NaL + f_C_Na * k_C2I1 * p_C_NaL - (k_I1O + k_I1C + k_I1I2) * p_I_1_NaL; %rate of change of I1 state late
	dp_I_2_NaLdt = f_C_Na * k_C2I2 * p_C_NaL + k_I1I2 * p_I_1_NaL + k_Isb * p_I_s_NaL - (k_I2C + k_Isf) * p_I_2_NaL; %rate of change of I2 state late
	dp_I_s_NaLdt = k_Isf * p_I_2_NaL + k_Isf * p_C_NaL - 2 * k_Isb * p_I_s_NaL; %rate of change of Is state late
    
	I_NaT_Na = (1 - f_LSM) * P_Na * GHK_Na * p_O_NaT;
	I_NaT_K = (1 - f_LSM) * P_Na * 0.1 * GHK_K * p_O_NaT;
	I_NaT = I_NaT_Na + I_NaT_K;
	I_NaL_Na = f_LSM * P_Na * GHK_Na * p_O_NaL;
	I_NaL_K = f_LSM * P_Na * 0.1 * GHK_K * p_O_NaL;
	I_NaL = I_NaL_Na + I_NaL_K;
	I_Na = I_NaT + I_NaL;
end

%CaL
function [alpha_plus, alpha_minus, epsilon_plus_iz, epsilon_plus_blk, Ca_2_iz_loc, Ca_2_blk_loc, epsilon_plus_iz_loc, epsilon_plus_blk_loc, epsilon_minus, p_O_LCC, ATPfactor, E_Ca_jnc, E_Ca_blk, E_Ca_iz, E_K, E_Na,...
    GHK_Ca_LR, GHK_Ca_L0, GHK_Ca_iz, GHK_Ca_blk, GHK_Na, GHK_K, I_CaL_Ca_blk, I_CaL_Ca_iz, I_CaL_Ca_LR, I_CaL_Ca_L0, I_CaL_Na_blk, I_CaL_Na_iz, I_CaL_Na_jnc, I_CaL_K_blk, I_CaL_K_iz, I_CaL_K_jnc, I_CaL, Y_cc_iz, dY_co_izdt,...
    dY_oo_izdt, dY_oc_izdt, Y_cc_blk, dY_co_blkdt, dY_oo_blkdt, dY_oc_blkdt] = currentCaL(Vm, Ca_2_iz, T_L, K_L, Ca_2_blk, f_L, delta_RTF, Cao, Y_ooo, Y_ooc, ATP, R, T, F, Ca_2_nd_L0, Ko, Ki, Nao, Nai, Ca_2_nd_LR, f_CaL_blk,...
    P_CaL_Ca, Y_oo_blk, f_CaL_iz, Y_oo_iz, f_CaL_jnc, P_CaL_Na, P_CaL_K, Y_co_iz, Y_oc_iz, Y_co_blk, Y_oc_blk) %L-type Ca channel current; Shirokov et al, Ferriera et al.
	alpha_plus = 1 / (3.734 * exp(-Vm / 8.5) + 0.35 * exp(-Vm / 3500)); %Ycc to Yoc and Yco to Yoo (1st letter voltage gate, 2nd letter Ca gate)
	alpha_minus = 1 / (4.65 * exp(Vm / 15) + 1.363 * exp(Vm / 100)); %Yoc to Ycc and Yoo to Yco
    
	epsilon_plus_iz = (Ca_2_iz * alpha_plus) / (T_L * K_L); %Yoo to Yoc and Yco to Ycc
	epsilon_plus_blk = (Ca_2_blk * alpha_plus) / (T_L * K_L);
	Ca_2_iz_loc = (Ca_2_iz + f_L * delta_RTF * Vm * exp(-delta_RTF * Vm) / (1 - exp(-delta_RTF * Vm)) * Cao) / (1 + f_L * delta_RTF * Vm / (1 - exp(-delta_RTF * Vm)));
	Ca_2_blk_loc = (Ca_2_blk + f_L * (delta_RTF * Vm * exp(-delta_RTF * Vm)) / (1 - exp(-delta_RTF * Vm)) * Cao) / (1 + f_L * delta_RTF * Vm / (1 - exp(-delta_RTF * Vm)));
	epsilon_plus_iz_loc = (Ca_2_iz_loc * alpha_plus) / (T_L * K_L);
	epsilon_plus_blk_loc = (Ca_2_blk_loc * alpha_plus) / (T_L * K_L);
	epsilon_minus = 1 / (8084 * exp(Vm / 10) + 158 * exp(Vm / 1000)) + 1 / (134736 * exp(-Vm / 5) + 337 * exp(-Vm / 2000)); %Yoc to Yoo and Ycc to Yco
    
	p_O_LCC = Y_ooo + Y_ooc; %both voltage gate and Ca gate are open
    
	ATPfactor = 1 / (1 + ((1.4 / ATP)^3));
    
	E_Ca_jnc = (R * T / F) / 2 * log(Cao / Ca_2_nd_L0); %Nernst
	E_Ca_blk = (R * T / F) / 2 * log(Cao / Ca_2_blk);
	E_Ca_iz = (R * T / F) / 2 * log(Cao / Ca_2_iz);
	E_K = (R * T / F) / 1 * log(Ko / Ki);
	E_Na = (R * T / F) / 1 * log(Nao / Nai);
    
	GHK_Ca_LR = 2 * Vm / (R * T / F) * (Ca_2_nd_LR - Cao * exp(-2 * Vm / (R * T / F))) / (1 - exp(-2 * Vm / (R * T / F))); %Goldman Hodgkin Katz equation
	GHK_Ca_L0 = 2 * Vm / (R * T / F) * (Ca_2_nd_L0 - Cao * exp(-2 * Vm / (R * T / F))) / (1 - exp(-2 * Vm / (R * T / F)));
	GHK_Ca_iz = 2 * Vm / (R * T / F) * (Ca_2_iz - Cao * exp(-2 * Vm / (R * T / F))) / (1 - exp(-2 * Vm / (R * T / F)));
	GHK_Ca_blk = 2 * Vm / (R * T / F) * (Ca_2_blk - Cao * exp(-2 * Vm / (R * T / F))) / (1 - exp(-2 * Vm / (R * T / F)));
	GHK_Na = 1 * Vm / (R * T / F) * (Nai - Nao * exp(-1 * Vm / (R * T / F))) / (1 - exp(-1 * Vm / (R * T / F)));
	GHK_K = 1 * Vm / (R * T / F) * (Ki - Ko * exp(-1 * Vm / (R * T / F))) / (1 - exp(-1 * Vm / (R * T / F)));
    
	I_CaL_Ca_blk = f_CaL_blk * P_CaL_Ca * GHK_Ca_blk * Y_oo_blk * ATPfactor;
	I_CaL_Ca_iz = f_CaL_iz * P_CaL_Ca * GHK_Ca_iz * Y_oo_iz * ATPfactor;
	I_CaL_Ca_LR = f_CaL_jnc * P_CaL_Ca * GHK_Ca_LR * Y_ooo * ATPfactor;
	I_CaL_Ca_L0 = f_CaL_jnc * P_CaL_Ca * GHK_Ca_L0 * Y_ooc * ATPfactor;
	I_CaL_Na_blk = f_CaL_blk * P_CaL_Na * GHK_Na * Y_oo_blk * ATPfactor;
	I_CaL_Na_iz = f_CaL_iz * P_CaL_Na * GHK_Na * Y_oo_iz * ATPfactor;
	I_CaL_Na_jnc = f_CaL_jnc * P_CaL_Na * GHK_Na * p_O_LCC * ATPfactor;
	I_CaL_K_blk = f_CaL_blk * P_CaL_K * GHK_K * Y_oo_blk * ATPfactor;
	I_CaL_K_iz = f_CaL_iz * P_CaL_K * GHK_K * Y_oo_iz * ATPfactor;
	I_CaL_K_jnc = f_CaL_jnc * P_CaL_K * GHK_K * p_O_LCC * ATPfactor;
    
	I_CaL = (I_CaL_Ca_LR + I_CaL_Ca_L0 + I_CaL_Na_jnc + I_CaL_K_jnc) + (I_CaL_Ca_iz + I_CaL_Na_iz + I_CaL_K_iz) + (I_CaL_Ca_blk + I_CaL_Na_blk + I_CaL_K_blk);
    
	Y_cc_iz = 1 - (Y_co_iz + Y_oo_iz + Y_oc_iz);
	dY_co_izdt = epsilon_minus * Y_cc_iz + alpha_minus * Y_oo_iz - (epsilon_plus_iz + alpha_plus) * Y_co_iz;
	dY_oo_izdt = alpha_plus * Y_co_iz + epsilon_minus * Y_oc_iz - (alpha_minus + epsilon_plus_iz_loc) * Y_oo_iz;
	dY_oc_izdt = epsilon_plus_iz_loc * Y_oo_iz + alpha_plus * Y_cc_iz - (epsilon_minus + alpha_minus) * Y_oc_iz;
    
	Y_cc_blk = 1 - (Y_co_blk + Y_oo_blk + Y_oc_blk);
	dY_co_blkdt = epsilon_minus * Y_cc_blk + alpha_minus * Y_oo_blk - (epsilon_plus_blk + alpha_plus) * Y_co_blk;
	dY_oo_blkdt = alpha_plus * Y_co_blk + epsilon_minus * Y_oc_blk - (alpha_minus + epsilon_plus_blk_loc) * Y_oo_blk;
	dY_oc_blkdt = epsilon_plus_blk_loc * Y_oo_blk + alpha_plus * Y_cc_blk - (epsilon_minus + alpha_minus) * Y_oc_blk;
end

%boundary diffusion
function [J_Ca_jnciz, J_Ca_izblk, J_trans_SR] = boundaryDiffusion(G_dCa_jnciz, Ca_2_jnc, Ca_2_iz, Ca_2_blk, Sc_Cell, G_dCa_izblk, P_trans, Ca_2_SRup, Ca_2_SRrl) %diffusion at boundaries between junctional space, intermediate zone, bulk space, SRrl and SRup
	J_Ca_jnciz = G_dCa_jnciz * (Ca_2_jnc - Ca_2_iz) * Sc_Cell; %flux of Ca from junctional space to intermediate zone
	J_Ca_izblk = G_dCa_izblk * (Ca_2_iz - Ca_2_blk) * Sc_Cell; %flux of Ca from intermediate zone to bulk space
	J_trans_SR = P_trans * (Ca_2_SRup - Ca_2_SRrl) * Sc_Cell; %flux of Ca from SRup to SRrl
end

%bulk space
function [dCaMCadt, dTnChCadt, dSRCadt, Ca_2_blk] = bulkSpace(k_on_CaM, Ca_2_blk, B_tot_CaM, CaMCa, k_off_CaM, k_on_TnCh, B_tot_TnCh, TnChCa, k_off_TnCh, k_on_SR, B_tot_SR, SRCa, k_off_SR, Ca_2_tot_blk, TSCa_3, TSCa_3W, TSCa_3S) %Ca buffering in bulk space (Calmodulin, Troponin C, SR membrane); GPB  
    dCaMCadt = k_on_CaM * Ca_2_blk * (B_tot_CaM - CaMCa) - k_off_CaM * CaMCa;
    dTnChCadt = k_on_TnCh * Ca_2_blk * (B_tot_TnCh - TnChCa) - k_off_TnCh * TnChCa;
	dSRCadt = k_on_SR * Ca_2_blk * (B_tot_SR - SRCa) - k_off_SR * SRCa;
	Ca_2_blk = Ca_2_tot_blk - (CaMCa + TnChCa + SRCa + 3 * (TSCa_3 + TSCa_3W + TSCa_3S) / 1000);
end

%intermediate zone
function [L_free_iz, H_free_iz, L_bound_iz, H_bound_iz, Ca_2_iz] = intermediateZone(B_tot_L_iz, L_bound_iz, B_tot_H_iz, H_bound_iz, Ca_2_tot_iz, K_dL_iz, K_dH_iz) %Ca buffering in intermediate zone (high and low affinity sarcolemmal Ca buffer);
    L_free_iz = B_tot_L_iz - L_bound_iz;
    H_free_iz = B_tot_H_iz - H_bound_iz;
    n = 1;
	for n = 1:10
		Ca_2_iz = Ca_2_tot_iz / (1 + L_free_iz / K_dL_iz + H_free_iz / K_dH_iz);
		L_free_iz = B_tot_L_iz / (1 + Ca_2_iz / K_dL_iz);
		H_free_iz = B_tot_H_iz / (1 + Ca_2_iz / K_dH_iz);
        n = n+1;
    end
    L_bound_iz = B_tot_L_iz - L_free_iz;
    H_bound_iz = B_tot_H_iz - H_free_iz;
end

%junctional space
function [Ca_2_jnc, L_free_jnc, H_free_jnc] = junctionalSpace(Ca_2_tot_jnc, L_free_jnc, K_dL_jnc, H_free_jnc, K_dH_jnc, B_tot_L_jnc, B_tot_H_jnc) %Ca buffering in junctional space (high and low affinity sarcolemmal Ca buffer);
n = 1;	
    for n = 1:10
		Ca_2_jnc = Ca_2_tot_jnc / (1 + L_free_jnc / K_dL_jnc + H_free_jnc / K_dH_jnc);
		L_free_jnc = B_tot_L_jnc / (1 + Ca_2_jnc / K_dL_jnc);
		H_free_jnc = B_tot_H_jnc / (1 + Ca_2_jnc / K_dH_jnc);
        n = n+1;
    end
end

%release site of SR
function [Ca_2_SRrl] = releaseSiteOfSR(B_tot_CSQN, Ca_2_tot_SRrl, K_d_CSQN_Ca) %Ca buffering by calsequestrin; GPB
	a = 1;
	b = B_tot_CSQN - Ca_2_tot_SRrl + K_d_CSQN_Ca;
	c = -K_d_CSQN_Ca * Ca_2_tot_SRrl;
	Ca_2_SRrl = (-b + sqrt((b^2) - 4 * a * c)) / (2 * a);
end
    