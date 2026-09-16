Electrode {
 { Name="source"     Voltage=0 }
 { Name="drain"      Voltage=0 }
 { Name="bodytie"    Voltage=0 }
 { Name="gate"       Voltage=0 }
 { Name="substrate"  Voltage=0 }
}

File {
 Grid    = "final_structure_msh.tdr"
 Plot    = "@tdrdat@"
 Parameter="@parameter@"
 Current = "@plot@"
 Output  = "@log@"
}

Physics{
Temperature=300
Mobility(DopingDep Enormal HighfieldSaturation)

}

Math {
   Digits=5
   Avalderivatives
   Iterations= 20
   Notdamped= 100
   Method= Blocked
   SubMethod= Pardiso
   ErRef(Electron)=1e8
   ErRef(Hole)=1e8
   Transient= BE
   RefDens_eGradQuasiFermi_ElectricField= 1e16
   RefDens_hGradQuasiFermi_ElectricField= 1e16
   BreakCriteria{ Current(Contact="drain" AbsVal=1e-3) } 
   -PlotLoadable 
}


Plot{
  *--Density and Currents, etc
  eDensity hDensity
  TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
  eMobility/Element hMobility/Element
  eVelocity hVelocity
  eQuasiFermi hQuasiFermi
  
  *--Temperature 
  eTemperature hTemperature Temperature
  
  *--Fields and charges
  ElectricField/Vector Potential SpaceCharge
  
  *--Doping Profiles
  Doping DonorConcentration AcceptorConcentration
  
  *--Generation/Recombination
  SRH Band2Band Auger
  ImpactIonization eImpactIonization hImpactIonization
  
  *--Driving forces
  eGradQuasiFermi/Vector hGradQuasiFermi/Vector
  eEparallel hEparallel eENormal hENormal
  
  *--Band structure/Composition
  BandGap 
  BandGapNarrowing
  Affinity
  ConductionBand ValenceBand
  eQuantumPotential hQuantumPotential
}



Solve {

 Coupled(Iterations=100) {
  Poisson
 }

 Coupled(Iterations=100) {
  Poisson Electron Hole
 }

 Quasistationary(
  InitialStep=0.01
  MinStep=1e-5
  MaxStep=1
  Increment=2
  Decrement=2
  Goal { Name="drain" Voltage=0.1 }
 ) {
  Coupled { Poisson Electron Hole }
 }

 Transient(
  InitialStep=0.01
  MinStep=1e-5
  InitialTime=0
  FinalTime=2
  MaxStep=0.05
  Goal { Name="gate" Voltage=1 }
 ) {
  Coupled { Poisson Electron Hole }
 }

}

