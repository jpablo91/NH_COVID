/**
* Name: ImmuneResponse
* Model to test the immune response equation
* Author: jpablo91
* Tags: 
*/


model ImmuneResponse

global {
	float Vi_first_dose <- 0.6 parameter: "First Dose Immunity";
	float Vi_second_dose <- 0.9 parameter: "Second Dose Immunity";
	int Immunity_decay_t <- 110 parameter: "Time to vaccination decay";
	int Revaccination_t <- 21 parameter: "Time to revaccination (second dose)";
	float G_Rise <- 0.4 parameter: "Rate of Immunity rise";
	float G_Decay <- 0.001 parameter: "Rate of Immunity Decay";
	float Step_Size <- 0.1 parameter:"Step Size";
	init {
		create Population_sp number: 1;
	}
	
	reflex EndSim when: cycle = 250{
		do pause;
	}
}

//Species which represent the Ordinary Differential Equations System 
species Population_sp {
	float t; //Variable to represent the discrete time for integration
   	float MVi <- Vi_first_dose; //Max Effect
	float Vi <- 0.01; //initial Immune response
	float dVi <- MVi - Vi; // Immunity to Max
	
  	float vi_rise <- G_Rise; //Rate of rise
   	float vi_decay <- G_Decay; //Rate of decay
   		
   	float h <- Step_Size;
   	string mm <- "Euler";

	// Parameters must follow exact order S, I, R, t  and N,beta,gamma	
	equation eqSIR{ 
    diff(dVi,t) = (- vi_rise * dVi * Vi / MVi);
    diff(Vi,t) = (vi_rise * dVi * Vi / MVi) - (vi_decay * Vi);
    }

	reflex solving {
		solve eqSIR method: mm step_size:h;
	}
	
	reflex Revaccination{
		if(cycle = Revaccination_t){
			MVi <- Vi_second_dose;
			dVi <- MVi -Vi;
		}
		if(cycle = Immunity_decay_t){
			vi_decay <- 0.05;
		}
	}
}


experiment mysimulation type: gui {
	output {	
		display display_charts {
			species Population_sp;
			chart 'SIR_agent' type: series background: #white {
//				data "S" value: first(predefined_ODE_SIR_agent).S color: #green;
				data "I" value: first(Population_sp).Vi color: #red;
//				data "R" value: first(predefined_ODE_SIR_agent).R color: #blue;
			}
		}
	}
}