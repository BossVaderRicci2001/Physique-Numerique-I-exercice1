#include <iostream>
#include <fstream>
#include <cmath>
#include <iomanip>
#include "ConfigFile.h" // Fichier .tpp car inclut un template

using namespace std;

class Engine
{

private:
  // definition des constantes
  const double pi=3.1415926535897932384626433832795028841971e0;
  const double epsilon0=8.854187812813e-12; // Vacuum permittivity [F/m]
  // definition des variables
  double t,tfin,dt; //<- temps final et pas de temps
  double mass_e; //mass de l electron
  double charge_e,charge_t,charge_c; //charge de l electron, charge de l ion 1, charge de l ion 2
  double x_t,x_c; //position de l ion 1, position de l ion 2
  double x,v;
  double x_0,v_0; // position and vitesse initiales de l electrone
  double alpha,v_bar; // coefficient de friction et vitesse de baseline 
  double k = 1.0/(4.0*pi*epsilon0);
  unsigned long long int nsteps; // Nombre d'iterations
  unsigned int deltaF; // friction due aux collisions, =0: sans, =1: avec 
  unsigned int sampling; // Nombre de pas de temps entre chaque ecriture des diagnostics
  unsigned int last; // Nombre de pas de temps depuis la derniere ecriture des diagnostics
  ofstream *outputFile; // Pointeur vers le fichier de sortie

  // Ecriture des diagnostics
  // inputs:
  //   write: (bool) ecriture des donnees si vrai
  void printOut(bool write)
  {
    // Ecriture tous les [sampling] pas de temps, sauf si force est vrai
    // sequence des sorties: 1) temps, 2) position (m) 3) vitesse (m/s)
    // 4) puissance force de friction (W)
    if((!write && last>=sampling) || (write && last!=1))
    {
      *outputFile << t << " " << x << " " << v << \
      " " << " " << puissanceCollisions(v) \
      << " " << energy(x,v) << endl;
      last = 1;
    }
    else
    {
      last++;
    }
  }

  // TODO: calculer l'acceleration
  // inputs:
  //   xLocal: (double) position de la particule
  //   vLocal: (double) vitesse de la particule
  // outputs:
  //   acceleration: (double) acceleration de la particule [m/s^2]
  double acceleration(double xLocal,double vLocal){
    // caculer l'acceleration
		double c(1.0);
		if(vLocal < 0){
			c=-1.0; //pour éviter v/abs(v) dans la force de friction
		}
		double a((1.0/mass_e)*(k*charge_e*(charge_t/pow(xLocal,2)-charge_c/pow(x_c-xLocal,2)) - c*(alpha/(pow(vLocal,2) + pow(v_bar,2)))));  
		return a;
	} 

  // TODO: calculer de la puissance de la force de friction due aux collisions
  // inputs:
  //   vLocal: (double) vitesse de la particule
  // outputs:
  //   puissanceCollisions: (double) puissance de la force de friction  [kg*m^2/s^2]
	double puissanceCollisions(double vLocal){
		if (vLocal > 0){
			return -alpha*vLocal/(pow(vLocal,2)+ pow(v_bar,2));
		}else{
			return alpha*vLocal/(pow(vLocal,2)+ pow(v_bar,2));
			}	
	}

  // TODO: calculer l'energie mecanique
  // inputs:
  //   xLocal: (double) position de la particule
  //   vLocal: (double) vitesse de la particule
  // outputs:
  //   energie: (double) energie mecanique de la particule [J]
  double energy(double xLocal, double vLocal){
      double ecin ((0.5)*mass_e*pow(vLocal,2));
      double epot (k*charge_e*((charge_t)/(xLocal) +(charge_c)/(x_c-xLocal)));
	  return (epot+ecin);
  }


  // Iteration temporelle
  void step()
  {
		double x_0(x);
		/*/
		double v_0(v);
		/*/
		// TODO: Mettre a jour x, v avec le schema d'Euler
		// f(x+dt) = f(x) + f'(x)dt + O(dt^2)
		x= x+v*dt;
		v = v + acceleration(x_0,v)*dt;
		// pour obtenier x(v=0) 1.3.b
		
		/*/if (v*v_0 < 0){
			cout << x << endl; 
		}/*/
  }

	
public:

  // Constructeur
  Engine(int argc, char* argv[]) {

    string inputPath("configuration.in"); // Fichier d'input par defaut
    if(argc>1) // Fichier d'input specifie par l'utilisateur ("./Exercice1 config_perso.in")
      inputPath = argv[1];

    ConfigFile configFile(inputPath); // Les parametres sont lus et stockes dans une "map" de strings.

    for(int i(2); i<argc; ++i) // Input complementaires ("./Exercice1 config_perso.in input_scan=[valeur]")
      configFile.process(argv[i]);

    // Stockage des parametres de simulation dans les attributs de la classe
    tfin     = configFile.get<double>("tfin");                   // lire temps final
    nsteps   = configFile.get<unsigned long long int>("nsteps"); // lire nombre pas de temps
    dt       = tfin / (double(nsteps)); 	                 // calculer pas de temps
    mass_e   = configFile.get<double>("mass_e");	         // lire la mass electron
    charge_e = configFile.get<double>("charge_e");	         // lire la charge electron
    charge_t = configFile.get<double>("charge_t");	         // lire la charge ion t
    charge_c = configFile.get<double>("charge_c");	         // lire la charge ion c
    x_t      = configFile.get<double>("x_t");	                 // lire la position ion t
    x_c      = configFile.get<double>("x_c");	                 // lire la position ion c
    x_0      = configFile.get<double>("x_0");	                 // lire position initiale
    v_0      = configFile.get<double>("v_0");	                 // lire vitesse initiale
    v_bar    = configFile.get<double>("v_bar");                  // lire vitesse de baseline
    alpha    = configFile.get<double>("alpha");	                 // lire coefficient friction
    deltaF   = configFile.get<unsigned int>("deltaF");           // lire modele
    sampling = configFile.get<unsigned int>("sampling");         // lire sampling

    // Ouverture du fichier de sortie
    outputFile = new ofstream(configFile.get<string>("output").c_str());
    outputFile->precision(15); // Les nombres seront ecrits avec 15 decimales
  };

  // Destructeur
  ~Engine()
  {
    outputFile->close(); // fermer le ficher des sorties
    delete outputFile;   // touer la class outputFile
  };

  // Simulation complete
  void run()
  {
    unsigned long long int i=0; // declare and initialise the index
    t = 0.e0; // initialiser temps
    x = x_0;   // initialiser position
    v = v_0;   // initialiser vitesse
    last = 0; // initialise ecriture
    printOut(true); // ecrire donnees initialies
    // boucle sur les pas de temps
    while(i<nsteps && x>x_t && x<x_c){
      step();  // integrer la dynamique
      t += dt; // mettre a jour le temps
      printOut(false); // false pour imprimer a chaque pas de temps
      i += 1; // increase the index 
    }  
    printOut(true); // imprimer le dernier pas de temps
    cout << x << endl;
    cout << v << endl;
  };

};

// programme
int main(int argc, char* argv[])
{
  Engine engine(argc, argv); // construire la class engine
  engine.run(); // executer la simulation
  cout << "Fin de la simulation." << endl;
  return 0;
}



