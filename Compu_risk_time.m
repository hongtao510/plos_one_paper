
for i=1:N_pat
     i       
    lambda2 = dep_trac(i)*SA_htf/Vol;           %deposition to high tracked floor
    lambda3 = dep_trac(i)*SA_ltf/Vol;           %deposition to low tracked floor
    lambda4 = dep_untrac(i)*SA_utf/Vol;         %deposition to untracked floor
    lambda5 = dep_wall(i)*SA_ws/Vol;            %deposition to walls
    lambda6 = e_nose(i)*r/Vol;                  %deposition to nasal passages
    r1=r11(i);                                  %decay rate in the air
    r2=r22(i);                                  %decay rate  other places
    tdr3=tdr33(i);                              %TDS coeff3
    tdr4=tdr44(i);                              %TDS coeff3
    Ksh=rsh*fsh*(SA_h/SA_htf);
    Khs=rhs*fhs;
    mu2 = resus(i);                             %resuspension
    e = eff(i);                                 %filter removal efficiency
    
        
    %Init = [M_Init(1,i);zeros(9,1)];          %initial condition for numbers in air 
    Init=[0;M_Init(1,i); zeros(8,1)];  
    
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
        A(9,9)=-(r2+Khs);
        A(10,1)= r1;
        A(10,2)= r2;
        A(10,3)= r2;
        A(10,4)= r2;
        A(10,5)= r2;
        A(10,6)= r2;
        A(10,7)= r1;
        A(10,8)= r2;
        A(10,9)= r2;
        
        
        [V,D] = eig(A);
        %V=real(V);
        %D=real(D);
        c = V\Init; 
   A_temp(:,:,i)=A;  

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

    %Conc_air = Mass_air/Vol;
    %Conc_tf = Mass_tf/SA_tf;
    Conc_utf = Mass_utf/SA_utf;
    %Conc_w = Mass_w/SA_ws;
    %Conc_f = Mass_f/SA_filter;
    %Conc_ceiling=Mass_ceiling/SA_ceiling;
    %Conc_nose=Mass_nose/SA_nose;
    
    % Inhalation

%Inhal_1(1, i)=0;
%Ing_1(1,i)=0;

Inhal_1(:,i)=(r*TMax/stp)*Mass_air(:, i)/Vol;

        if i<=4
        Ing_1(:, i) = rsh*fsh*Mass_htf(:,i);
        else
        Ing_1(:, i) = rhm*fhm*Mass_hand(:,i);
        end
        
        
    end
Inhal=cumsum(Inhal_1);
Ing = cumsum(Ing_1);
         
Risk_Inh =1-exp(-repmat(tdr33,stp,1).*Inhal); 
Risk_Ing =1-exp(-repmat(tdr44,stp,1).*Ing);
Risk_t =1-(1-Risk_Inh).*(1-Risk_Ing);









