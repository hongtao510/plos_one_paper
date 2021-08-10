clear all
clc

xj=1; % number of simulations;
xj

Lon=5.6;    %16
Wid=5.6;    %7
Hei=2.5;    %4

Vol=Lon*Wid*Hei;
SA_floor =Lon*Wid;  
SA_ws = Hei*(Lon+Wid)*2;
SA_ceiling=SA_floor;
SA_nose=0.80;
filter_flow_rate = 137;
ACH=4;
Q=(Vol*ACH)/60;
SA_filter=Q/filter_flow_rate;
Risk_level=0.001;

RE=100;
RE1=10.^(unifrnd(-2,8,xj,1));

prop_trac=0.75;
SA_htf=SA_floor*prop_trac*0.025;            %higher tracked area
SA_ltf=SA_floor*prop_trac*0.975;            %lower tracker area
SA_utf=SA_floor*(1-prop_trac);              %untracked area
SA_h=2e-3;                                  %finger area

rho=1000;                                   %density of the particle
D=[2.81e-11,8.48e-12,4.98e-12,2.45e-12];    %Particle diffusivity
k_e=0.24;                                   %turbulence intensity   
%%%%%%%%%%%settling velocity%%%%%%%%%%%%%%%%
v_g(:,1)=9.8*((1.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,2)=9.8*((3.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,3)=9.8*((5.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,4)=9.8*((10.0e-6)^2)*(rho-1.2)/(18*1.81e-5);    %m/s

%%%%%%%%%%%deposition velocity%%%%%%%%%%%%%%%%
for i=1:4
    for ss=1:xj
dep_trac(ss,i)=(v_g(ss,i)/(1-exp(-1.571*v_g(ss,i)/(D(i)*k_e(1))^0.5)))*60;
dep_wall(ss,i)=((1/1.571)*((D(i)*k_e(1))^0.5))*60; 
dep_ceiling(ss,i)=(v_g(ss,i)/(exp(1.571*v_g(ss,i)/(D(i)*k_e(1))^0.5)-1))*60;
    end
end

dep_untrac=dep_trac;

e_nose(:,1)=0.14;
e_nose(:,2)=0.45;
e_nose(:,3)=0.62;
e_nose(:,4)=0.77;

resus(:,1)=2.00e-6;
resus(:,2)=3.17e-5; 
resus(:,3)=6.33e-5; 
resus(:,4)=5.67e-4;

eff=repmat([0.098, 0.49, 0.74, 0.88],xj,1);

p=0.75;
r=1.02/60;

rsh=6/60;                                   %surface hand touch rate per min
rhs=rsh;                                    %hand surface touch rate per min
rhm=8/60;                                   %hand mouth touch rate per min
fsh=0.333;                      %fraction surface hand rate per min
fhs=0.174;                      %fraction hand surface rate per min
fhm=0.350;                      %fraction hand mouth rate per min


%%%%%%%%%%%%%%Pathogen decay%%%%%%%%%%%%%%%%%
%%%%%%%%%%%anthrax%%%%%%%%%%%%%%%%%%%%
r11(:,:,1)=8.16e-5/60;  %decay rate in the air
r22(:,:,1)=3.36e-5/60;  %decay rate on the fomite

%%%%%%%%%%Y.P%%%%%%%%%%%%%%%%%%%%%%%%%%
r11(:,:,2)=2.75/60;  %decay rate in the air
r22(:,:,2)=0.455/60;  %decay rate on the fomite

%%%%%%%%%%%%F.tularensis%%%%%%%%%%%%%%%%
r11(:,:,3)=3.27/60;  %decay rate in the air
r22(:,:,3)=0.239/60;  %decay rate on the fomite

%%%%%%%%%%%%Variola major%%%%%%%%%%%%%%%%
r11(:,:,4)=0.0455/60;  %decay rate in the air
r22(:,:,4)=0.00689/60;  %decay rate on the fomite

%%%%%%%%%%%%Lassa%%%%%%%%%%%%%%%%
r11(:,:,5)=2.6/60;  %decay rate in the air
r22(:,:,5)=0.767/60;  %decay rate on the fomite

%%%%%%%%%Pathogen Dose-response%%%%%%%%%%%%%%
%%%%%%%%%%%anthrax%%%%%%%%%%%%%%%%%%%%
tdr33(:,:,1)=7.15e-6;     %air
tdr44(:,1,1)=3.14e-8;
tdr44(:,2,1)=1.15e-8;
tdr44(:,3,1)=6.36e-9;
tdr44(:,4,1)=2.61e-9;

%%%%%%%%%%Y.P%%%%%%%%%%%%%%%%%%%%%%%%%%
tdr44(:,:,2)=1.02e-3;
tdr33(:,:,2)=1.02e-3;

%%%%%%%%%%%%F.tularensis%%%%%%%%%%%%%%%%
tdr44(:,:,3)=5.32e-2;
tdr33(:,:,3)=5.32e-2;

%%%%%%%%%%%%Variola major%%%%%%%%%%%%%%%%
tdr44(:,:,4)=2.31e-6;
tdr33(:,:,4)=2.31e-6;

%%%%%%%%%%%%Lassa%%%%%%%%%%%%%%%%
tdr44(:,:,5)=3.58e-2;
tdr33(:,:,5)=3.58e-2;


SCM1_mass_risk_norminal

   Risk_Ba=risk_t_1(:,:,1);
   Risk_Yp=risk_t_4(:,:,2); 
   Risk_Ft=risk_t_4(:,:,3);    
   Risk_Vm=risk_t_4(:,:,4);  
   Risk_La=risk_t_4(:,:,5);  
   
   %Conc_Ba=mass_t_1(:,:,1)/SA_htf;
   %Conc_Yp=mass_t_4(:,:,2)/SA_htf; 
   %Conc_Ft=mass_t_4(:,:,3)/SA_htf;    
   %Conc_Vm=mass_t_4(:,:,4)/SA_htf;  
   %Conc_La=mass_t_4(:,:,5)/SA_htf; 
   
   Conc_Ba_s=mass_t_1s(:,:,1)/SA_htf;
   Conc_Yp_s=mass_t_4s(:,:,2)/SA_htf; 
   Conc_Ft_s=mass_t_4s(:,:,3)/SA_htf;    
   Conc_Vm_s=mass_t_4s(:,:,4)/SA_htf;  
   Conc_La_s=mass_t_4s(:,:,5)/SA_htf;
   
   
%save('mass_risk_mc_norminal')





