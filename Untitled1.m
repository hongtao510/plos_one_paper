

subplot(2,2,1)
hold on

plot(Risk_Inh(:,1),'k-')
plot(Risk_Inh(:,5),'k--')
plot(Risk_Inh(:,9),'k:')
plot(Risk_Inh(:,13),'k-.')
plot(Risk_Inh(:,17),'kx')

title('1\mum')
legend('\it{ B. anthracis}','\it{ Y. Pestis}','\it{ F. tularensis}','Variola major','Lassa')
xlabel('Time (min)') %
ylabel('Risk from inhalation in retrospecive scenario')
hold off

subplot(2,2,2)
hold on

plot(Risk_Inh(:,2),'k-')
plot(Risk_Inh(:,6),'k--')
plot(Risk_Inh(:,10),'k:')
plot(Risk_Inh(:,14),'k-.')
plot(Risk_Inh(:,17),'kx')

title('3\mum')

hold off

subplot(2,2,3)
hold on

plot(Risk_Inh(:,3),'k-')
plot(Risk_Inh(:,7),'k--')
plot(Risk_Inh(:,11),'k:')
plot(Risk_Inh(:,15),'k-.')
plot(Risk_Inh(:,19),'kx')

title('5\mum')
hold off

subplot(2,2,4)
hold on

plot(Risk_Inh(:,4),'k-')
plot(Risk_Inh(:,8),'k--')
plot(Risk_Inh(:,12),'k:')
plot(Risk_Inh(:,16),'k-.')
plot(Risk_Inh(:,20),'kx')

title('10\mum')
hold off




