/**
* Name: Parameters (BASELINE scenario)
* Parameters for the model
* Author: jpablo91
* Tags: 
*/

// ===========| BASELINE |=================
model Parameters
global{
	/*======| Scenarios: |==========
	 * 0 = Baseline
	 * 1 = Vaccine effect according to @B202
	 * 2 = Vaccine effect according to @Polack202
	 */
	 string S <- "GSA";
	 // ===========| Disease Parameters |=========
//	 float GlobalShedding_p <- one_of(0.35); // Baseline 0.5(0.3, 0.7)
	 float GlobalShedding_p <- one_of(0.38, 0.38*0.8, 0.38*1.2); // Baseline 0.5(0.3, 0.7)
	 float GlobalInfection_p <- GlobalShedding_p; // Baseline 0.5(0.3, 0.7)
	 float Asymptomatic_p <- 0.4; // Basleine 0.25
	 float Introduction_p <- 0.05;
//	 float Introduction_p <- one_of(0.01, 0.05, 0.1); // Baseline 0.01(0.05, 0.1)
	 float Res_Hospitalization <- 0.23/(24*5); // 
	 float BaseMortality <- 0.118;
//	 float AsymptTransmission <- 0.42;
	 float AsymptTransmission <- one_of(0.42, 0.34, 0.99);
	 float SR_OR <- one_of(0.5, 0.7, 1.0);
	 
	 // ~~~~~~~~~~~~~~~~~~~ || INTERVENTIONS || ~~~~~~~~~~~~~~~~~~~~	
//	 int TestingFreq <- one_of(5); // 7(3, 5)
	 int TestingFreq <- one_of(3, 5, 7); // 7(3, 5)
	 float Test_sensitivity <- one_of(0.8); // Detection probability 0.75(0.85, 0.95)
//	 float Test_sensitivity <- one_of(0.8, 0.8*0.8); // Detection probability 0.75(0.85, 0.95)
	 // ~~~~~~PPE USE~~~~~~~
//	 float PPE_OR <- one_of(0.0722); // Odds ratio for the use of PPE  0.1467(0.0722, 0.3408)
	 float PPE_OR <- one_of(0.0722, 0.1467, 0.3408); // Odds ratio for the use of PPE  0.1467(0.0722, 0.3408)
	 float p_PPE_res <- 0.75;
	 float p_PPE_staff <- 0.9;
	 // ~~~~~~Vaccination~~~~~
	 string VaccineEff <- one_of('Equal', 'A', 'B');
//	 float vaccination_dist <- one_of(0.0);
	 float vaccination_dist <- one_of(0.0, 0.3, 0.5, 0.7); // 0.0 = no vaccination (0.3, 0.5, 0.7) proportion of doses for staff (for residents is 1 - p)
	 int Vaccination_decay <- 120*24;
	 float First_dose_effect <- 0.6; // the first dose effect will be scaled by this constant.
	 
	 float p1;
	 float p2;
}