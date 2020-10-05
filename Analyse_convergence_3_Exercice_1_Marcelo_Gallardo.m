%% Voici un exemple de script pour les etudes de convergence:
%% Mettez/le dans un autre fichier .m, et decommentez les lignes
 nsteps_num  = [10 20 40 80 160 320 640 1280 2560 5120] ; % vous complÃ©tez ici 'a la main' 
 xfin_num = [5.87263e-007 5.84177e-007 5.82552e-007 5.81705e-007 5.81269e-007 5.81048e-007 5.80936e-007 5.8088e-007 5.80852e-007 5.80838e-007]; % vous complÃ©tez ici 'a la main' 
 vfin_num = [8478.2 7087.34 5899.77 5074.76 4577.68 4303.62 4159.66 4085.88 4048.54 4029.75];
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
 xlabel('1/N_{steps} ')
 ylabel('v_{final} [m/s]')
 grid on