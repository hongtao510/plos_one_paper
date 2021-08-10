
for i=1:20
     i;
    lambda2 = dep_trac(i)*SA_htf/Vol;           %deposition to high tracked floor
    lambda3 = dep_trac(i)*SA_ltf/Vol;           %deposition to low tracked floor
    lambda4 = dep_untrac(i)*SA_utf/Vol;         %deposition to untracked floor
    lambda5 = dep_wall(i)*SA_ws/Vol;            %deposition to walls
    lambda6 = e_nose(i)*r/Vol;                  %deposition to nasal passages

    r1=r11(i);                                  %decay rate in the air
    r2=r22(i);                                  %decay rate  other places

    Ksh=rsh*fsh*(SA_h/SA_htf);
    Khs=rhs*fhs;
    mu2 = resus(i);                             %resuspension
    e = eff(i);                                 %filter removal efficiency
    Init = [RE(i);zeros(9,1)];          %initial condition for numbers in air 
        %Init=[0;M_Init(1,i); zeros(8,1)];  
    if mu2>0                                    %if there is resuspension, then define coefficients of matrix
        A=zeros(10,10);
        
        A(1,1)= (-1+(1-e)*p)*Q/Vol -(lambda2+lambda3+lambda4+lambda5+lambda6+r1);
        A(1,2)= mu2;
        A(1,3)= mu2;
        A(2,1)= lambda2;
        A(2,2)= -(mu2+r2+Ksh);
        A(2,9)=Khs;
        A(3,1)= lambda3;
        A(3,3)= -mu2-r2;
        A(4,1)= lambda4;
        A(4,4)= -r2;
        A(5,1)= lambda5;
        A(5,5)= -r2;
        A(6,1)= e*p*Q/Vol;
        A(6,6)= -r2;
        A(7,1)= (1-p)*Q/Vol;
        A(7,7)= -r1;
        A(8,1)= lambda6;
        A(8,8)= -r2;
        A(9,2)=Ksh;
        A(9,9)=-(r2+Khs+rhm*fhm);
        A(10,1)= r1;
        A(10,2)= r2;
        A(10,3)= r2;
        A(10,4)= r2;
        A(10,5)= r2;
        A(10,6)= r2;
        A(10,7)= r1;
        A(10,8)= r2;
        A(10,9)= r2;
        %A(11,9)=rhm*fhm;
        
        
        [V,D] = eig(A);
        %V=real(V);
        %D=real(D);
        c = V\Init; 
 
        Time = linspace(0, TMax, stp);%transpose to get a column vector
        Time2 = repmat(Time,10,1);
    
        Mass= (c(1)*repmat(V(:,1),1,stp).*exp(D(1,1)*Time2))';
    
    for k=2:10
        Mass= Mass+ (c(k)*repmat(V(:,k),1,stp).*exp(D(k,k)*Time2))';
    end
    Mass(1,:)=Init;
    Mass_air(:,i)=Mass(:,1);
    Mass_htf(:,i)=Mass(:,2);
    Mass_ltf(:,i)=Mass(:,3);
    Mass_utf(:,i)=Mass(:,4);
    Mass_w(:,i)=Mass(:,5);
    Mass_f(:,i)=Mass(:,6);
    Mass_ec(:,i)=Mass(:,7);
    Mass_nose(:,i)=Mass(:,8);
    Mass_hand(:,i)=Mass(:,9);
    Mass_decay(:,i)=Mass(:,10);
    
    %Mass_mouth(:,i)=Mass(:,11);
    %Conc_air = Mass_air/Vol;
    %Conc_tf = Mass_tf/SA_tf;
    Conc_htf = Mass_htf/SA_htf;
    %Conc_w = Mass_w/SA_ws;
    Conc_f = Mass_f/SA_filter;
    %Conc_ceiling=Mass_ceiling/SA_ceiling;
    %Conc_nose=Mass_nose/SA_nose;
    
    % Inhalation

    while(i==20)
Inhal_1(1, i)=0;
Ing_1(1,i)=0;

bg=tt*60/rat;

Ing_a_indi=repmat((rsh*fsh*TMax/stp),stp,i).*Mass_htf;      %Ingestion Bathracis
Ing_b_indi=repmat((rhm*fhm*TMax/stp),stp,i).*Mass_hand;     %Ingestion Others
Ing_a_post=sum(Ing_a_indi(bg:stp,:),1);                     %total ing dose from time bg
Ing_b_post=sum(Ing_b_indi(bg:stp,:),1);
Ing_post(tt,1:4)=Ing_a_post(:,1:4);
Ing_post(tt,5:20)=Ing_b_post(:,5:20);

Inhal_indi=repmat(((r/Vol)*TMax/stp),stp,i).*Mass_air;
Inhal_post(tt,:)=sum(Inhal_indi(bg:stp,:),1);

Ing_a_bef=sum(Ing_a_indi(1:bg,:),1);                        %total ing dose before time bg
Ing_b_bef=sum(Ing_b_indi(1:bg,:),1);

Ing_bef(tt,1:4)=Ing_a_bef(:,1:4);
Ing_bef(tt,5:20)=Ing_b_bef(:,5:20);

Inhal_bef(tt,:)=sum(Inhal_indi(1:bg,:),1);


    break

    end
    
    end
    

end

Risk_Inh_post=1-exp(-tdr33.*Inhal_post(tt,:)); 
Risk_Ing_post=1-exp(-tdr44.*Ing_post(tt,:));
Risk_t_post(tt,:)=1-(1-Risk_Inh_post).*(1-Risk_Ing_post);

Risk_Inh_bef=1-exp(-tdr33.*Inhal_bef(tt,:)); 
Risk_Ing_bef=1-exp(-tdr44.*Ing_bef(tt,:));
Risk_t_bef(tt,:)=1-(1-Risk_Inh_bef).*(1-Risk_Ing_bef);

Risk_tF(tt,:)=Risk_t_bef(tt,:); %%for figure needs








