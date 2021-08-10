for yy=1:5
    yy
for ff=1:1
               
    for i=1:4
    lambda2 = dep_trac(ff,i)*SA_htf/Vol;           %deposition to high tracked floor
    lambda3 = dep_trac(ff,i)*SA_ltf/Vol;           %deposition to low tracked floor
    lambda4 = dep_untrac(ff,i)*SA_utf/Vol;         %deposition to untracked floor
    lambda5 = dep_wall(ff,i)*SA_ws/Vol;            %deposition to walls
    lambda6 = e_nose(ff,i)*r(ff)/Vol;              %deposition to nasal passages
    
    r1=r11(ff,1,yy);                               %decay rate in the air
    r2=r22(ff,1,yy);                               %decay rate  other places
    
    Ksh=rsh(ff)*fsh(ff)*(SA_h/SA_htf);
    Khs=rhs(ff)*fhs(ff);
    mu2 = resus(ff,i);                             %resuspension
    e = eff(ff,i);                                 %filter removal efficiency

    
       
        A1= -((-1+(1-e)*p(ff))*Q(ff)/Vol -(lambda2+lambda3+lambda4+lambda5+lambda6+r1));    %retro
        A2= (mu2+r2+Ksh);                                                                   %pros
        A3=(r2+Khs+rhm(ff)*fhm(ff));                                                        %hand
        A31=(r2+Khs);                                                                     %hand
        
        A4=(mu2/A2)*(r(ff)/Vol)*(1/A1)/(1-(Ksh/A2)*(Khs/A3));
        A41=(mu2/A2)*(r(ff)/Vol)*(1/A1)/(1-(Ksh/A2)*(Khs/A31));
        
        A5=(Ksh/A2)*(rhm(ff)*fhm(ff)/A3)/(1-(Ksh/A2)*(Khs/A3));
        %A51=(Ksh/A2)/(1-(Ksh/A2)*(Khs/A3));
        A51=(Ksh/A2)*(1/A31)/(1-(Ksh/A2)*(Khs/A31));
                
        A6=tdr33(ff,1,yy)*A4+tdr44(ff,1,yy)*A5;
        A7=tdr33(ff,1,yy)*tdr44(ff,1,yy)*A4*A5;
        
        A61=tdr33(ff,1,yy)*A41+tdr44(ff,i,yy)*A51;
        A71=tdr33(ff,1,yy)*tdr44(ff,i,yy)*A41*A51;
        
   %risk_t_4(ff,i,yy)=1-(1-tdr33(ff,1,yy)*RE*A4)*(1-tdr44(ff,1,yy)*RE*A5);
   %risk_t_1(ff,i,yy)=1-(1-tdr33(ff,1,yy)*RE*A41)*(1-tdr44(ff,i,yy)*RE*A51);     
   
   risk_t_4(ff,i,yy)=1-(1-(1-exp(-tdr33(ff,1,yy)*RE*A4)))*(1-(1-exp(-tdr44(ff,1,yy)*RE*A5)));
   risk_t_1(ff,i,yy)=1-(1-(1-exp(-tdr33(ff,1,yy)*RE*A4)))*(1-(1-exp(-tdr44(ff,i,yy)*RE*A51)));     
   
   %mass_t_4(ff,i,yy)=(A6+sqrt(A6^2-4*A7*Risk_level))/(2*A7);
   %mass_t_1(ff,i,yy)=(A61+sqrt(A61^2-4*A71*Risk_level))/(2*A71);
   
   mass_t_4s(ff,i,yy)=(A6-sqrt(A6^2-4*A7*Risk_level))/(2*A7);
   mass_t_1s(ff,i,yy)=(A61-sqrt(A61^2-4*A71*Risk_level))/(2*A71);   
   
    end
    AA4(ff)=A4;
    AA5(ff)=A51;
    AA6(ff)=A61;
    AA7(ff)=A71;
    AA8(ff)=A61-sqrt(A6^2-4*A71*Risk_level);
end
end

   
   
   
   
   
   
   