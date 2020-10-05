%% Mettez/le dans un autre fichier .m, et decommentez les lignes
nsteps_num  = [10 20 40 80 160 320 640 1280 2560 5120];  % vous complétez ici 'a la main' 
xfin_num = [4.27492e-007 3.84365e-007 3.56625e-007 3.40425e-007 3.3157e-007 3.26923e-007 3.24539e-007 3.23332e-007 3.22725e-007 3.2242e-007 ]; % vous complÃ©tez ici 'a la main' 
vfin_num = [-158992 -181571 -198603 -209622 -216021 -219495 -221308 -222235 -222703 -222939 ];

 lw=2; fs=16;
 figure
 plot(1./nsteps_num, xfin_num, 'k+-','linewidth',lw)
 set(gca,'fontsize',fs)
 xlabel('1/N_{steps} ')
 ylabel('x_{final} [m]')
 grid on
 
 figure
 plot(1./nsteps_num, vfin_num, 'k+-','linewidth',lw)
 set(gca,'fontsize',fs)
 xlabel('1/N_{steps} [m]')
 ylabel('v_{final} [m/s]')
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