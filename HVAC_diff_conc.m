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
%risk_coeff=[7.2*10^(-6),7.2*10^(-6),7.2*10^(-6),8.2*10^(-7),8.2e-5,8.2e-5,8.2e-5,8.2e-5,4.7e-2,4.7e-2,4.7e-2,4.7e-2];

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
    
TMax =60*24*2;
rat=1;
stp=TMax/rat;

RE1=logspace(2,4,30);

for jj=1:30
    jj

    
Compu_HVAC_diff_conc

Conc_f1(jj,:)=Conc_f(1*60,:);
Conc_f4(jj,:)=Conc_f(4*60,:);
Conc_f8(jj,:)=Conc_f(8*60,:);
Conc_f12(jj,:)=Conc_f(12*60,:);
Conc_f24(jj,:)=Conc_f(24*60,:);
Conc_f48(jj,:)=Conc_f(48*60,:);


Risk_f1(jj,:)=Risk_t_bef(1,:);
Risk_f4(jj,:)=Risk_t_bef(4,:);
Risk_f8(jj,:)=Risk_t_bef(8,:);
Risk_f12(jj,:)=Risk_t_bef(12,:);
Risk_f24(jj,:)=Risk_t_bef(24,:);  
Risk_f48(jj,:)=Risk_t_bef(48,:); 

end   

%Conc_fF(:,:,jj)=Conc_f;





  
    
    
    
    
    
    
    
    
    
    
    
    

