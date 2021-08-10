
    lambda2 = dep_trac(i)*SA_htf/Vol;           %deposition to high tracked floor
    lambda3 = dep_trac(i)*SA_ltf/Vol;           %deposition to low tracked floor
    lambda4 = dep_untrac(i)*SA_utf/Vol;         %deposition to untracked floor
    lambda5 = dep_wall(i)*SA_ws/Vol;            %deposition to walls
    lambda6 = 0;                                %deposition to nasal passages

    r1=r11(i);                                  %decay rate in the air
    r2=r22(i);                                  %decay rate  other places
    tdr3=tdr33(i);                              %TDS coeff3
    tdr4=tdr44(i);                              %TDS coeff3
    Ksh=0;
    Khs=0;
    mu2 = 0;                             %resuspension
    e = eff(i);                                 %filter removal efficiency
    Init_1 = [0;RE(i);zeros(8,1)];          %initial condition for numbers in air 

                                      %if there is resuspension, then define coefficients of matrix
        A=zeros(10,10);
        
        A(1,1)= (-1+(1-e)*p)*0/Vol -(lambda2+lambda3+lambda4+lambda5+lambda6+r1);
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
        A(6,1)= e*p*0/Vol;
        A(6,6)= -r2;
        A(7,1)= (1-p)*0/Vol;
        A(7,7)= -r1;
        A(8,1)= lambda6;
        A(8,8)= -r2;
        A(9,2)=Ksh;
        A(9,9)=-(0+Khs+0);
        A(10,1)= r1;
        A(10,2)= r2;
        A(10,3)= r2;
        A(10,4)= r2;
        A(10,5)= r2;
        A(10,6)= r2;
        A(10,7)= r1;
        A(10,8)= r2;
        A(10,9)= 0;
        %A(11,9)=rhm*fhm;
        
        
        [V_1,D_1] = eig(A);
        c_1 = V_1\Init_1; 
 
        Time_1 = linspace(0, TMax_1, stp_1);%transpose to get a column vector
        Time2_1 = repmat(Time_1,10,1);
    
        Mass_1= (c_1(1)*repmat(V_1(:,1),1,stp_1).*exp(D_1(1,1)*Time2_1))';
    
    for k=2:10
        Mass_1= Mass_1+ (c_1(k)*repmat(V_1(:,k),1,stp_1).*exp(D_1(k,k)*Time2_1))';
    end
    Mass_1(1,:)=Init_1;

    Mass_air_1(:,i)=Mass_1(:,1);
    Mass_htf_1(:,i)=Mass_1(:,2);
    Mass_ltf_1(:,i)=Mass_1(:,3);
    Mass_utf_1(:,i)=Mass_1(:,4);
    Mass_w_1(:,i)=Mass_1(:,5);
    Mass_f_1(:,i)=Mass_1(:,6);
    Mass_ec_1(:,i)=Mass_1(:,7);
    Mass_nose_1(:,i)=Mass_1(:,8);
    Mass_hand_1(:,i)=Mass_1(:,9);
    Mass_decay_1(:,i)=Mass_1(:,10);
    
    Mass_end_1=Mass_1(TMax_1,:);



    
    
    
    
    
    





