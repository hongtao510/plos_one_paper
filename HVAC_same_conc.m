clear all
clc

Vol=5.60*5.60*2.50;
SA_floor = 5.6*5.6;
SA_ws = 5.60*10;
SA_ceiling=SA_floor;
SA_nose=0.80;
filter_flow_rate = 137;
ACH=4;
Q=(Vol*ACH)/60;
SA_filter=Q/filter_flow_rate;

prop_trac=0.75;
SA_htf=SA_floor*prop_trac*0.25; %higher tracked area
SA_ltf=SA_floor*prop_trac*0.75; %lower tracker area
SA_utf=SA_floor*(1-prop_trac);  %untracked area
SA_h=2e-3;                      %hand area

rho=1000;                                %density of the particle
D=[2.81e-11,8.48e-12,4.98e-12,2.45e-12]; %Particle diffusivity
k_e=(0.45+0.0)/2;                        %turbulence intensity   
%%%%%%%%%%%settling velocity%%%%%%%%%%%%%%%%
v_g(:,1)=9.8*((1.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,2)=9.8*((3.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,3)=9.8*((5.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,4)=9.8*((10.0e-6)^2)*(rho-1.2)/(18*1.81e-5);    %m/s

%%%%%%%%%%%deposition velocity%%%%%%%%%%%%%%%%
for i=1:20
    ii=mod(i,4);
    if ii==0;
        iii=4;
    else iii=ii;
    end
dep_trac(i)=(v_g(iii)/(1-exp(-1.571*v_g(iii)/(D(iii)*k_e(1))^0.5)))*60;
dep_wall(i)=((1/1.571)*((D(iii)*k_e(1))^0.5))*60; 
dep_ceiling(i)=(v_g(iii)/(exp(1.571*v_g(iii)/(D(iii)*k_e(1))^0.5)-1))*60;
    end
dep_untrac=dep_trac;

e_nose=[0.14,0.45,0.62,0.77];
e_nose=repmat(e_nose,1,5);
resus=[1.2 * 10^(-4)/60, 1.9*10^(-3)/60, 3.8*10^(-3)/60, 3.4*10^(-2)/60];
resus=repmat(resus,1,5);
eff=[0.098, 0.49, 0.74, 0.88];
eff=repmat(eff,1,5);

p=.8;
rsh=6/60;       %surface hand touch rate per min
rhs=6/60;       %hand surface touch rate per min
rhm=8/60;       %hand mouth touch rate per min
fsh=0.333;      %fraction surface hand 
fhs=0.174;      %fraction hand surface 
fhm=0.350;      %fraction hand mouth 
r11=[1.4e-6,1.4e-6,1.4e-6,1.4e-6,4.6e-2,4.6e-2,4.6e-2,4.6e-2,5.0e-2,5.0e-2,5.0e-2,5.0e-2,7.6e-4,7.6e-4,7.6e-4,7.6e-4,4.3e-2,4.3e-2,4.3e-2,4.3e-2];  %decay in the air
r22=[5.6e-7,5.6e-7,5.6e-7,5.6e-7,7.5e-3,7.5e-3,7.5e-3,7.5e-3,4.0e-3,4.0e-3,4.0e-3,4.0e-3,1.2e-4,1.2e-4,1.2e-4,1.2e-4,1.3e-2,1.3e-2,1.3e-2,1.3e-2];  %decay at other places
tdr33=[7.15*10^-6,7.15*10^-6,7.15*10^-6,7.15*10^-6,1.0*10^-3,1.0*10^-3,1.0*10^-3,1.0*10^-3,5.3*10^-2,5.3*10^-2,5.3*10^-2,5.3*10^-2,2.3*10^-6,2.3*10^-6,2.3*10^-6,2.3*10^-6,3.6*10^-2,3.6*10^-2,3.6*10^-2,3.6*10^-2];
tdr44=[3.14*10^-8,1.15*10^-8,6.36*10^-9,2.61*10^-9,1.0*10^-3,1.0*10^-3,1.0*10^-3,1.0*10^-3,5.3*10^-2,5.3*10^-2,5.3*10^-2,5.3*10^-2,2.3*10^-6,2.3*10^-6,2.3*10^-6,2.3*10^-6,3.6*10^-2,3.6*10^-2,3.6*10^-2,3.6*10^-2];
r=1.02/60;


%M_Init=[1.30e4,2.98e4,4.40e4,7.00e4,3.00e2,4.10e2,5.10e2,7.10e2,6.00,8.10,9.74,13.50,4.00e4,9.10e4,1.35e5,2.00e5,8.00e0,1.11e1,1.39e1,2.00e1];  %air release

for ttt=1:48
    ttt
TMax =60*1*ttt;
stp=TMax;

kk=1;
RE=repmat(1e2,1,20);
NN=0;
Compu_HVAC_same_conc


for i=1:20
   i;
    NN=0;
    while (NN==0)

if Conc_f(stp,i)<=9.995
    RE(1,i)=RE(1,i)*1.1;
    
    NN=0;
   
    Compu_HVAC_same_conc


else if Conc_f(stp,i)>=10.005
    RE(1,i)=RE(1,i)*0.9;
    
    Compu_HVAC_same_conc


    else
        kk=kk+1;
        NN=1;
    break
    end
end
    end
end
clear Mass Mass_air Mass_htf Mass_ltf Mass_utf Mass_w Mass_f Mass_ec Mass_nose Mass_hand Mass_decay Ing Ing_a Ing_b Inhal 
RE_F(ttt,:)=RE;
end
    





