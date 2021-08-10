

subplot(2,2,1)
hold on
i1=1;
plot(Conc_f1(:,i1),Risk_f1(:,i1),'k+')
plot(Conc_f4(:,i1),Risk_f4(:,i1),'ko')
plot(Conc_f8(:,i1),Risk_f8(:,i1),'k*')
plot(Conc_f12(:,i1),Risk_f12(:,i1),'kx')
plot(Conc_f24(:,i1),Risk_f24(:,i1),'k^')
plot(Conc_f48(:,i1),Risk_f48(:,i1),'k.')
title('1\mum')
legend('1 hour','4 hours','8 hours','12 hours','1 day','2 days')
xlabel('Concentrations of \it{ B. anthracis} on HVAC filter') %\it{ F. tularensis}
ylabel({'Accumulative risk assocaited with different concentrations of \it{ B. anthracis}', 'detected on HVAC filter from aerosol releases with different elapsed time'})
hold off

subplot(2,2,2)
hold on
i2=2;
plot(Conc_f1(:,i2),Risk_f1(:,i2),'k+')
plot(Conc_f4(:,i2),Risk_f4(:,i2),'ko')
plot(Conc_f8(:,i2),Risk_f8(:,i2),'k*')
plot(Conc_f12(:,i2),Risk_f12(:,i2),'kx')
plot(Conc_f24(:,i2),Risk_f24(:,i2),'k^')
plot(Conc_f48(:,i2),Risk_f48(:,i2),'k.')
title('3\mum')
hold off

subplot(2,2,3)
hold on
i3=3;
plot(Conc_f1(:,i3),Risk_f1(:,i3),'k+')
plot(Conc_f4(:,i3),Risk_f4(:,i3),'ko')
plot(Conc_f8(:,i3),Risk_f8(:,i3),'k*')
plot(Conc_f12(:,i3),Risk_f12(:,i3),'kx')
plot(Conc_f24(:,i3),Risk_f24(:,i3),'k^')
plot(Conc_f48(:,i3),Risk_f48(:,i3),'k.')
title('5\mum')
hold off

subplot(2,2,4)
hold on
i4=4;
plot(Conc_f1(:,i4),Risk_f1(:,i4),'k+')
plot(Conc_f4(:,i4),Risk_f4(:,i4),'ko')
plot(Conc_f8(:,i4),Risk_f8(:,i4),'k*')
plot(Conc_f12(:,i4),Risk_f12(:,i4),'kx')
plot(Conc_f24(:,i4),Risk_f24(:,i4),'k^')
plot(Conc_f48(:,i4),Risk_f48(:,i4),'k.')
title('10\mum')
hold off




