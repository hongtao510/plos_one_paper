clear all
clc
load('new analysis')

retro_risk_rela_1(:,1)=retro_a(:,1)./retro_a(:,1);
retro_risk_rela_1(:,2)=retro_y(:,1)./retro_a(:,1);
retro_risk_rela_1(:,3)=retro_f(:,1)./retro_a(:,1);
retro_risk_rela_1(:,4)=retro_v(:,1)./retro_a(:,1);
retro_risk_rela_1(:,5)=retro_l(:,1)./retro_a(:,1);

retro_risk_rela_3(:,1)=retro_a(:,2)./retro_a(:,2);
retro_risk_rela_3(:,2)=retro_y(:,2)./retro_a(:,2);
retro_risk_rela_3(:,3)=retro_f(:,2)./retro_a(:,2);
retro_risk_rela_3(:,4)=retro_v(:,2)./retro_a(:,2);
retro_risk_rela_3(:,5)=retro_l(:,2)./retro_a(:,2);

retro_risk_rela_5(:,1)=retro_a(:,3)./retro_a(:,3);
retro_risk_rela_5(:,2)=retro_y(:,3)./retro_a(:,3);
retro_risk_rela_5(:,3)=retro_f(:,3)./retro_a(:,3);
retro_risk_rela_5(:,4)=retro_v(:,3)./retro_a(:,3);
retro_risk_rela_5(:,5)=retro_l(:,3)./retro_a(:,3);

retro_risk_rela_10(:,1)=retro_a(:,4)./retro_a(:,4);
retro_risk_rela_10(:,2)=retro_y(:,4)./retro_a(:,4);
retro_risk_rela_10(:,4)=retro_f(:,4)./retro_a(:,4);
retro_risk_rela_10(:,4)=retro_v(:,4)./retro_a(:,4);
retro_risk_rela_10(:,5)=retro_l(:,4)./retro_a(:,4);

pros_risk_rela_1(:,1)=pros_a(:,1)./pros_a(:,1);
pros_risk_rela_1(:,2)=pros_y(:,1)./pros_a(:,1);
pros_risk_rela_1(:,3)=pros_f(:,1)./pros_a(:,1);
pros_risk_rela_1(:,4)=pros_v(:,1)./pros_a(:,1);
pros_risk_rela_1(:,5)=pros_l(:,1)./pros_a(:,1);

pros_risk_rela_3(:,1)=pros_a(:,2)./pros_a(:,2);
pros_risk_rela_3(:,2)=pros_y(:,2)./pros_a(:,2);
pros_risk_rela_3(:,3)=pros_f(:,2)./pros_a(:,2);
pros_risk_rela_3(:,4)=pros_v(:,2)./pros_a(:,2);
pros_risk_rela_3(:,5)=pros_l(:,2)./pros_a(:,2);

pros_risk_rela_5(:,1)=pros_a(:,3)./pros_a(:,3);
pros_risk_rela_5(:,2)=pros_y(:,3)./pros_a(:,3);
pros_risk_rela_5(:,3)=pros_f(:,3)./pros_a(:,3);
pros_risk_rela_5(:,4)=pros_v(:,3)./pros_a(:,3);
pros_risk_rela_5(:,5)=pros_l(:,3)./pros_a(:,3);

pros_risk_rela_10(:,1)=pros_a(:,4)./pros_a(:,4);
pros_risk_rela_10(:,2)=pros_y(:,4)./pros_a(:,4);
pros_risk_rela_10(:,3)=pros_f(:,4)./pros_a(:,4);
pros_risk_rela_10(:,4)=pros_v(:,4)./pros_a(:,4);
pros_risk_rela_10(:,5)=pros_l(:,4)./pros_a(:,4);


retro_r_rela(:,1)=r(:,1)./r(:,1);
retro_r_rela(:,2)=r(:,2)./r(:,1);
retro_r_rela(:,3)=r(:,3)./r(:,1);
retro_r_rela(:,4)=r(:,4)./r(:,1);
retro_r_rela(:,5)=r(:,5)./r(:,1);

pros_rk_rela(:,1)=(r_Ia(:,1)./r_Ia(:,1))./(k_1(:,1)./k_1(:,1));
pros_rk_rela(:,2)=(r(:,2)./r_Ia(:,1))./(k_1(:,2)./k_1(:,1));
pros_rk_rela(:,3)=(r(:,3)./r_Ia(:,1))./(k_1(:,3)./k_1(:,1));
pros_rk_rela(:,4)=(r(:,4)./r_Ia(:,1))./(k_1(:,4)./k_1(:,1));
pros_rk_rela(:,5)=(r(:,5)./r_Ia(:,1))./(k_1(:,5)./k_1(:,1));


new_ratio_retro_1=retro_risk_rela_1./retro_r_rela;
new_ratio_retro_3=retro_risk_rela_3./retro_r_rela;
new_ratio_retro_5=retro_risk_rela_5./retro_r_rela;
new_ratio_retro_10=retro_risk_rela_10./retro_r_rela;

new_ratio_pros_1=pros_risk_rela_1./pros_rk_rela;
new_ratio_pros_3=pros_risk_rela_3./pros_rk_rela;
new_ratio_pros_5=pros_risk_rela_5./pros_rk_rela;
new_ratio_pros_10=pros_risk_rela_10./pros_rk_rela;





















