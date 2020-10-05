%% Mettez/le dans un autre fichier .m, et decommentez les lignes
nsteps_num  = [2000 4000 8000 16000];  % vous complétez ici 'a la main' 
x_vnul_x_eq = [7.75872e-7 7.76711e-7 7.7737e-7 7.78062e-7];
 lw=2; fs=16;
 figure
plot(1./nsteps_num, abs(x_vnul_x_eq-7.7863e-7), 'k+-','linewidth',lw)
 set(gca,'fontsize',fs)
 xlabel('1/N_{steps}')
 ylabel('|x(v=0)-x_eq| [m]')
 grid on

% si on a la solution analytique:
% xfin_ana = ...; % à compléter
% error_xfin = xfin_num-xfin_ana;
% figure
% plot(nsteps_num, abs(error_xfin),'k+-')
% set(gca,'fontsize',fs)
% set(gca,'xscale','log')
% set(gca,'yscale','log')
% xlabel('N_{steps}')
% ylabel('Error on x_{fin}')
% grid on