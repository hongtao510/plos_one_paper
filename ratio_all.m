clear all
clc
xj=50000;

Vol=5.60*5.60*2.50;
SA_floor = 5.6*5.6;
SA_w = 5.60*10;
SA_ceiling=SA_floor;
SA_nose=0.80;
filter_flow_rate = 137;
ACH=4;
Q=(Vol*ACH)/60;
SA_filter=Q/filter_flow_rate;
prop_trac=0.75;
SA_ts=SA_floor*prop_trac*0.25;                              %touched surface area
SA_h=2e-3;                                                  %hand area

Inh=repmat((0.8+rand(xj,1)*(2.0-0.8))/60,1,4);              %m3/min
e=repmat([0.098,0.49,0.74,0.88],xj,1);                      %HVAC filter eff
p=repmat(rand(xj,1),1,4);                                   %HVAC recy %

rho=1000+rand(xj,1)*2000;                                   %density of the particle
D=repmat([2.81e-11,8.48e-12,4.98e-12,2.45e-12],xj,1);       %Particle diffusivity
k_e=0.45*rand(xj,4);                                        %turbulence intensity   

%%%%%%%%%%contact freq and transfer % %%%%%%%%%%%%%%%%%%%%%%
rsh=repmat((3+rand(xj,1)*(6-3))/60,1,4);
rhs=rsh;
rhm=repmat((5+rand(xj,1)*(8-5))/60,1,4);
fsh=(0.008+rand(xj,1)*(0.658-0.008))*(SA_h/SA_ts);
fsh=repmat(fsh,1,4);
fhs=(0.010+rand(xj,1)*(0.338-0.010));
fhs=repmat(fhs,1,4);
fhm=(0.330+rand(xj,1)*(0.410-0.330));
fhm=repmat(fhm,1,4);

%%%%%%%%%%%settling velocity%%%%%%%%%%%%%%%%
v_g(:,1)=9.8*((1.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,2)=9.8*((3.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,3)=9.8*((5.0e-6)^2)*(rho-1.2)/(18*1.81e-5);     %m/s
v_g(:,4)=9.8*((10.0e-6)^2)*(rho-1.2)/(18*1.81e-5);    %m/s

%%%%%%%%%%%deposition velocity%%%%%%%%%%%%%%%% 
dep_floor=(v_g./(1-exp(-1.571*v_g./(D.*k_e).^0.5)))*60;        %m/min
dep_wall=((1/1.571)*((D.*k_e).^0.5))*60; 
%dep_ceiling=(v_g./(exp(1.571*v_g./(D.*k_e).^0.5)-1))*60;

%%%%%%%%%%%nasal filter eff%%%%%%%%%%%%%%%%%%%
e_n(:,1)=0.02+rand(xj,1)*(0.25-0.02);
e_n(:,2)=0.22+rand(xj,1)*(0.68-0.22);
e_n(:,3)=0.42+rand(xj,1)*(0.81-0.42);
e_n(:,4)=0.62+rand(xj,1)*(0.91-0.62);

%%%%%%%%%%%deposition & resus &transfer rates%%%%%%%%%%%%%%%%%%%    
k_floor=(SA_floor/Vol)*dep_floor;
k_ts=(SA_ts/Vol)*dep_floor;
k_w=(SA_w/Vol)*dep_wall;
k_n=(Inh/Vol).*e_n;
k_HVAC=(1-(1-e).*p)*Q/Vol;

resus(:,1)=(4.32*10^(-7)+rand(xj,1)*(1.19*10^(-4)-4.32*10^(-7)));           
resus(:,2)=(6.12*10^(-4)+rand(xj,1)*(6.12*10^(-3)-6.12*10^(-4))); 
resus(:,3)=(3.96*10^(-3)+rand(xj,1)*(1.19*10^(-2)-3.96*10^(-3))); 
resus(:,4)=(3.17*10^(-3)+rand(xj,1)*(3.38*10^(-2)-3.17*10^(-3)));

k_sh=fsh.*rsh;
k_hs=fhs.*rhs;
k_hm=fhm.*rhm;

%%%%%%%%%%%%%%%%%%%%decay and virulence rates (min-1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_1(:,1)=(1.92*10^(-5)+rand(xj,1)*(4.64*10^(-5)-1.90*10^(-5)))/60;          %anthrax fomite     
k_2(:,1)=(1.10*10^(-5)+rand(xj,1)*(1.97*10^(-4)-1.10*10^(-5)))/60;          %anthrax air         
k_1(:,2)=(0.04+rand(xj,1)*(1.24-0.04))/60;                                  %Y.P fomite
k_2(:,2)=(2.1+rand(xj,1)*(3.49-2.1))/60;                                    %Y.P air
k_1(:,3)=(0.01+rand(xj,1)*(0.46-0.01))/60;                                  %F fomite
k_2(:,3)=(0.55+rand(xj,1)*(9.2-0.55))/60;                                   %F air
k_1(:,4)=10^(-3)*(5.45+rand(xj,1)*(9.95-5.45))/60;                          %V fomite
k_2(:,4)=(0.01+rand(xj,1)*(0.13-0.01))/60;                                  %V air
k_1(:,5)=(0.68+rand(xj,1)*(0.92-0.68))/60;                                  %Lassa fomite
k_2(:,5)=(0.78+rand(xj,1)*(4.14-0.78))/60;                                  %Lassa air

r(:,1)=normrnd(6.93e-6,3.98e-7,xj,1);                                       %anthrax
r(:,2)=normrnd(1.02e-3,1.91e-5,xj,1);                                       %Y.p 
r(:,3)=normrnd(5.32e-2,2.22e-4,xj,1);                                       %V
r(:,4)=normrnd(2.65e-6,1.21e-6,xj,1);                                       %F        
r(:,5)=lognrnd(-1.69,0.80,xj,1);                                            %L       

r_I=r;
r_Ia(:,1)=lognrnd(-18.03,1.23,xj,1);
r_Ia(:,2)=lognrnd(-18.82,1.04,xj,1);
r_Ia(:,3)=lognrnd(-19.36,0.99,xj,1);
r_Ia(:,4)=lognrnd(-20.23,0.97,xj,1);
%%%%%%%%%%%%%%%%%%%%%%%%%total decay rates%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:5
    for i=1:4
        
    k_retro(:,i,j)=k_floor(:,i)+k_w(:,i)+k_HVAC(:,i)+k_n(:,i)+k_2(:,j);
    k_pros(:,i,j)=k_1(:,j)+resus(:,i)+k_sh(:,1);
    k_hand(:,i,j)=k_hm(:,1)+k_hs(:,1)+k_1(:,j);
    k_hand_a(:,i,j)=0+k_hs(:,1)+k_1(:,j);
    end
end
    
    for j=1:5
    Inh_retro(:,:,j)=((Inh/Vol)./k_retro(:,:,j)).*(1-exp(-k_retro(:,:,j)*480));
    Ing_retro(:,:,j)=(k_ts./k_retro(:,:,j)).*(k_sh./k_pros(:,:,j)).*(k_hm./k_hand(:,:,j)).*(1-exp(-k_retro(:,:,j)*480)).*(1-exp(-k_pros(:,:,j)*480)).*(1-exp(-k_hand(:,:,j)*480));
    Ing_retro_a(:,:,j)=(k_ts./k_retro(:,:,j)).*(k_sh./k_pros(:,:,j)).*(1./k_hand_a(:,:,j)).*(1-exp(-k_retro(:,:,j)*480)).*(1-exp(-k_pros(:,:,j)*480)).*(1-exp(-k_hand_a(:,:,j)*480));
        
    Inh_pros(:,:,j)=(resus./k_pros(:,:,j)).*(Inh/Vol)./k_retro(:,:,j)./((1-(k_sh./k_pros(:,:,j)).*(k_hs./k_hand_a(:,:,j))));
    Ing_pros(:,:,j)=(k_sh./k_pros(:,:,j)).*(k_hm./k_hand(:,:,j))./((1-(k_sh./k_pros(:,:,j)).*(k_hs./k_hand(:,:,j))));
    Ing_pros_a(:,:,j)=(k_sh./k_pros(:,:,j)).*(1./k_hand_a(:,:,j))./((1-(k_sh./k_pros(:,:,j)).*(k_hs./k_hand_a(:,:,j))));
    end

retro=Inh_retro+Ing_retro;
pros=Inh_pros+Ing_pros;

%retro_a=repmat(r(:,1),1,4).*retro(:,:,1);
%retro_y=repmat(r(:,2),1,4).*retro(:,:,2);
%retro_f=repmat(r(:,3),1,4).*retro(:,:,3);
%retro_v=repmat(r(:,4),1,4).*retro(:,:,4);
%retro_l=repmat(r(:,5),1,4).*retro(:,:,5);

retro_a=1-(1-repmat(r(:,1),1,4).*Inh_retro(:,:,1)).*(1-r_Ia.*Ing_retro_a(:,:,1));
retro_y=1-(1-repmat(r(:,2),1,4).*Inh_retro(:,:,2)).*(1-repmat(r_I(:,2),1,4).*Ing_retro(:,:,2));
retro_f=1-(1-repmat(r(:,3),1,4).*Inh_retro(:,:,3)).*(1-repmat(r_I(:,3),1,4).*Ing_retro(:,:,3));
retro_v=1-(1-repmat(r(:,4),1,4).*Inh_retro(:,:,4)).*(1-repmat(r_I(:,4),1,4).*Ing_retro(:,:,4));
retro_l=1-(1-repmat(r(:,5),1,4).*Inh_retro(:,:,5)).*(1-repmat(r_I(:,5),1,4).*Ing_retro(:,:,5));

pros_a=1-(1-repmat(r(:,1),1,4).*Inh_pros(:,:,1)).*(1-r_Ia.*Ing_pros_a(:,:,1));
pros_y=1-(1-repmat(r(:,2),1,4).*Inh_pros(:,:,2)).*(1-repmat(r_I(:,2),1,4).*Ing_pros(:,:,2));
pros_f=1-(1-repmat(r(:,3),1,4).*Inh_pros(:,:,3)).*(1-repmat(r_I(:,3),1,4).*Ing_pros(:,:,3));
pros_v=1-(1-repmat(r(:,4),1,4).*Inh_pros(:,:,4)).*(1-repmat(r_I(:,4),1,4).*Ing_pros(:,:,4));
pros_l=1-(1-repmat(r(:,5),1,4).*Inh_pros(:,:,5)).*(1-repmat(r_I(:,5),1,4).*Ing_pros(:,:,5));

retro_all_1=[retro_a(:,1),retro_y(:,1),retro_f(:,1),retro_v(:,1),retro_l(:,1)];
retro_all_3=[retro_a(:,2),retro_y(:,2),retro_f(:,2),retro_v(:,2),retro_l(:,2)];
retro_all_5=[retro_a(:,3),retro_y(:,3),retro_f(:,3),retro_v(:,3),retro_l(:,3)];
retro_all_10=[retro_a(:,4),retro_y(:,4),retro_f(:,4),retro_v(:,4),retro_l(:,4)];    
  
pros_all_1=[pros_a(:,1),pros_y(:,1),pros_f(:,1),pros_v(:,1),pros_l(:,1)];
pros_all_3=[pros_a(:,2),pros_y(:,2),pros_f(:,2),pros_v(:,2),pros_l(:,2)];
pros_all_5=[pros_a(:,3),pros_y(:,3),pros_f(:,3),pros_v(:,3),pros_l(:,3)];
pros_all_10=[pros_a(:,4),pros_y(:,4),pros_f(:,4),pros_v(:,4),pros_l(:,4)]; 






