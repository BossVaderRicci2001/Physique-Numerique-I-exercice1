% Nom du fichier d'output a analyser (modifiez selon vos besoins)
filename = 'output.out'; 

% Chargement des donnees
data = load(filename);

% Extraction des quantites d'interet
% (Le code c++ ecrit t, x(t), v(t), P_f(t), E_mec(t)  ligne par ligne, 
%  une ligne par pas de temps)
t = data(:,1); 
x = data(:,2);
v = data(:,3);
Pf = data(:,4);
Emec = data(:,5);


% nombre de pas de temps effectués:
nsteps = length(t)
% longueur du pas de temps:
dt = t(2)-t(1)

% Figures
% line width and font size (utile pour la lisibilité des figures dans le
% rapport)
lw=2; fs=16; 
figure('Name', [filename ': x(t)'])
plot(t, x, '-','linewidth',lw)
set(gca,'fontsize',fs)
xlabel('t [s]')
ylabel('x [m]')
grid on

figure('Name', [filename ': v(t)'])
plot(t, v, '-','linewidth',lw)
set(gca,'fontsize',fs)
xlabel('t [s]')
ylabel('v [m/s]')
grid on

figure('Name', [filename ': (x,v)'])
plot(x, v, '-','linewidth',lw)
set(gca,'fontsize',fs)
xlabel('x [m]')
ylabel('v [m/s]')
grid on

figure('Name', [filename ': Pf(t)'])
plot(t, Pf, '-','linewidth',lw)
set(gca,'fontsize',fs)
xlabel('t [s]')
ylabel('P_f [W]')
grid on
figure('Name', [filename ': Emec(t)'])
plot(t, Emec, '-','linewidth',lw)
set(gca,'fontsize',fs)
xlabel('t [s]')
ylabel('Emec [J]')
grid on

% Fonction pour graphique la dérivée de l'énergie mécanique 
% dt = mean(diff(t));                                 % Find Mean Differece In ‘x’ Values
% dEmec = gradient(Emec,dt);                                % Calculate Slope Of Data
% tq = find((t >= 0.275) & (t <= 0.325));             % Index Of Area Of Interest ‘x’ Values
% slope_t = t(tq);                                    % ‘Slope’ ‘x’ Values Of Interest
% slope_Emec = dEmec(tq);                                   % ‘Slope’ ‘y’ Values Of Interest
% figure(2)
% plot(t, dEmec, '-g')
% hold on
% plot(slope_t, slope_Emec, '-r', 'LineWidth',2)
% hold off
% grid
% xlabel('t [s]')
% ylabel('dEmec [J]')
% grid on
% legend('Total energy derivative', 'Slope Of Data In Region Of Interest', 'Location','W')


%% Voici un exemple de script pour les etudes de convergence:
%% Mettez/le dans un autre fichier .m, et decommentez les lignes
% nsteps_num  = [... ... ... ... ...]; % vous complétez ici 'a la main' 
% xfin_num = [... ... ... ... ...]; % vous complétez ici 'a la main' 
% lw=2; fs=16;
% figure
% plot(1./nsteps_num, xfin_num, 'k+-','linewidth',lw)
% set(gca,'fontsize',fs)
% xlabel('1/N_{steps}')
% ylabel('x_{final}')
% grid on
%
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


