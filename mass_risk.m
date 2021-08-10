clear all
clc

xj=50000; % number of simulations;
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
ACH=(0+rand(xj,1)*(4));
Q=(Vol*ACH)/60;
SA_filter=Q/filter_flow_rate;
Risk_level=0.001;

RE=292;
RE1=10.^(unifrnd(-2,8,xj,1));

prop_trac=0.75;
SA_htf=SA_floor*prop_trac*0.025; %higher tracked area
SA_ltf=SA_floor*prop_trac*0.975; %lower tracker area
SA_utf=SA_floor*(1-prop_trac);  %untracked area
SA_h=2e-3;                      %finger area

rho=1000+rand(xj,1)*(3000-1000);         %density of the particle
D=[2.81e-11,8.48e-12,4.98e-12,2.45e-12]; %Particle diffusivity
k_e=rand(xj,1)*(0.45-0.026);                     %turbulence intensity   
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

e_nose(:,1)=(0.02+rand(xj,1)*(0.25-0.02));
e_nose(:,2)=(0.22+rand(xj,1)*(0.68-0.22));
e_nose(:,3)=(0.42+rand(xj,1)*(0.81-0.42));
e_nose(:,4)=(0.62+rand(xj,1)*(0.91-0.62));

resus(:,1)=(4.32*10^(-7)+rand(xj,1)*(1.19*10^(-4)-4.32*10^(-7)))/60;
resus(:,2)=(6.12*10^(-4)+rand(xj,1)*(6.12*10^(-3)-6.12*10^(-4)))/60; 
resus(:,3)=(3.96*10^(-3)+rand(xj,1)*(1.19*10^(-2)-3.96*10^(-3)))/60; 
resus(:,4)=(3.17*10^(-3)+rand(xj,1)*(3.38*10^(-2)-3.17*10^(-3)))/60;

eff=repmat([0.098, 0.49, 0.74, 0.88],xj,1);

p=rand(xj,1);
r=(0.8+rand(xj,1)*(2.0-0.8))/60;

rsh=(3+rand(xj,1)*(6-3))/60;                %surface hand touch rate per min
rhs=rsh;                                    %hand surface touch rate per min
rhm=(5+rand(xj,1)*(8-5))/60;                %hand mouth touch rate per min
fsh=(0.008+rand(xj,1)*(0.658-0.008));       %fraction surface hand rate per min
fhs=(0.010+rand(xj,1)*(0.338-0.010));       %fraction hand surface rate per min
fhm=(0.330+rand(xj,1)*(0.410-0.330));       %fraction hand mouth rate per min


%%%%%%%%%%%%%%Pathogen decay%%%%%%%%%%%%%%%%%
%%%%%%%%%%%anthrax%%%%%%%%%%%%%%%%%%%%
r11(:,:,1)=((1.11e-5)+rand(xj,1)*((1.97e-4)-(1.11e-5)))/60;  %decay rate in the air
r22(:,:,1)=((1.92e-5)+rand(xj,1)*((4.64e-5)-(1.92e-5)))/60;  %decay rate on the fomite

%%%%%%%%%%Y.P%%%%%%%%%%%%%%%%%%%%%%%%%%
r11(:,:,2)=((2.10)+rand(xj,1)*((3.49)-(2.10)))/60;  %decay rate in the air
r22(:,:,2)=((0.04)+rand(xj,1)*((1.24)-(0.04)))/60;  %decay rate on the fomite

%%%%%%%%%%%%F.tularensis%%%%%%%%%%%%%%%%
r11(:,:,3)=((0.55)+rand(xj,1)*((9.20)-(0.55)))/60;  %decay rate in the air
r22(:,:,3)=((0.01)+rand(xj,1)*((0.46)-(0.01)))/60;  %decay rate on the fomite

%%%%%%%%%%%%Variola major%%%%%%%%%%%%%%%%
r11(:,:,4)=((0.01)+rand(xj,1)*((0.13)-(0.01)))/60;  %decay rate in the air
r22(:,:,4)=((0.00545)+rand(xj,1)*((0.00995)-(0.00545)))/60;  %decay rate on the fomite

%%%%%%%%%%%%Lassa%%%%%%%%%%%%%%%%
r11(:,:,5)=((0.78)+rand(xj,1)*((4.14)-(0.78)))/60;  %decay rate in the air
r22(:,:,5)=((0.68)+rand(xj,1)*((0.92)-(0.68)))/60;  %decay rate on the fomite

%%%%%%%%%Pathogen Dose-response%%%%%%%%%%%%%%
%%%%%%%%%%%anthrax%%%%%%%%%%%%%%%%%%%%
tdr33(:,:,1)=normrnd(6.93e-6,3.89e-7,xj,4);     %air
tdr44(:,1,1)=lognrnd(-18.03,1.23,xj,1);
tdr44(:,2,1)=lognrnd(-18.82,1.04,xj,1);
tdr44(:,3,1)=lognrnd(-19.36,0.99,xj,1);
tdr44(:,4,1)=lognrnd(-20.23,0.97,xj,1);

%%%%%%%%%%Y.P%%%%%%%%%%%%%%%%%%%%%%%%%%
tdr44(:,:,2)=normrnd(1.02e-3,1.91e-5,xj,4);
tdr33(:,:,2)=tdr44(:,:,2);

%%%%%%%%%%%%F.tularensis%%%%%%%%%%%%%%%%
tdr44(:,:,3)=normrnd(5.32e-2,2.22e-4,xj,4);
tdr33(:,:,3)=tdr44(:,:,3);

%%%%%%%%%%%%Variola major%%%%%%%%%%%%%%%%
tdr44(:,:,4)=normrnd(2.65e-6,1.21e-6,xj,4);
tdr33(:,:,4)=tdr44(:,:,4);

%%%%%%%%%%%%Lassa%%%%%%%%%%%%%%%%
tdr44(:,:,5)=lognrnd(-1.69,0.80,xj,4);
tdr33(:,:,5)=tdr44(:,:,5);


SCM1_mass_risk

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
   
   
save('mass_risk_mc')





