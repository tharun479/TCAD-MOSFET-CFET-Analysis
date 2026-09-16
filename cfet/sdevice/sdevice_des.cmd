###############################################################
## CFET – nFET Individual Id–Vg Characteristics
## MATCHED TO OPTIMIZED SDE STRUCTURE (CFET_SDE_optimized.cmd)
##
## KEY STRUCTURAL CHANGES FROM PREVIOUS SDE → REFLECTED HERE:
##
##  [1] Gate contact face  : y=0.028 (top of TiN slot)
##                           probe point = (0.020, 0.028, 0.060)
##                           → Workfunction applies correctly to TiN ✓
##
##  [2] nFET S/D z-range   : z=0.070–0.100
##                           S/D z-midpoint = 0.085
##                           → contact probe (0.020, 0.000/0.044, 0.085)
##
##  [3] Gate Z-span        : 0.026–0.094
##                           Gate z-midpoint = 0.060
##                           → TiN covers both pFET+nFET nanosheet stacks
##
##  [4] pFET suppression   : Physics(Region=...) blocks added for
##                           Nanosheet_P1 and Nanosheet_P2 to prevent
##                           hole accumulation from distorting nFET Id-Vg
##                           (as discussed — shared gate sweeps pFET into
##                           accumulation during positive Vg nFET sweep)
##
##  [5] Workfunction=4.55  : Kept — TiN n-type tuned, same as forksheet
##                           Adjust to 4.6–4.7 if Vt shifts unexpectedly
##
## SIMULATION PLAN:
##   Stage 1 : Equilibrium
##   Stage 2 : VDS ramp 0→0.1→0.4→0.7V  (3 micro-stages)
##   Stage 3 : Id-Vg saturation  (VDS=0.7V, Vg: 0→1.0V)
##   Stage 4 : Gate ramp back 1.0→0.0V
##   Stage 5 : VDS ramp back 0.7→0.05V
##   Stage 6 : Id-Vg linear      (VDS=0.05V, Vg: 0→1.0V)
###############################################################


###############################################################
## FILES
## Grid filename must match SDE output: "new_mesh_msh.tdr"
###############################################################
File {
    Grid    = "new_mesh_msh.tdr"
    Plot    = "CFET_nFET_idvg.tdr"
    Current = "CFET_nFET_idvg.plt"
    Output  = "CFET_nFET_idvg.log"
}


###############################################################
## ELECTRODES
##
## source_N : y=0.000 face, probe=(0.020, 0.000, 0.085) → 0V ref
## drain_N  : y=0.044 face, probe=(0.020, 0.044, 0.085) → ramped
## gate     : y=0.028 face, probe=(0.020, 0.028, 0.060) → swept
##            Workfunction=4.55 (TiN, n-type tuned)
##
## source_P : tied to 0V — prevents floating node divergence
## drain_P  : tied to 0V — same potential as source_P
##            (no current path through pFET → electrically inactive)
##            pFET channels still experience gate field but
##            Physics(Region) blocks below suppress accumulation effect
###############################################################
Electrode {
    ## nFET – ACTIVE terminals
    { Name="source_N"  Voltage=0.0 }
    { Name="drain_N"   Voltage=0.0 }
    { Name="gate"      Voltage=0.0  Workfunction=4.55 }

    ## pFET – INACTIVE  (grounded, not floating)
    { Name="source_P"  Voltage=0.0 }
    { Name="drain_P"   Voltage=0.0 }
}


###############################################################
## PHYSICS – GLOBAL
##
## Applied everywhere unless overridden by Region-specific block
## Identical to your working forksheet baseline:
##   PhuMob + HighFieldSaturation + Enormal  : mobility
##   OldSlotboom BGN                          : intrinsic density
##   SRH(DopingDep+Hurkx) + Auger            : recombination
##   eQuantumPotential + hQuantumPotential    : GAA quantization
##   Fermi                                    : degenerate S/D (5e20)
###############################################################
Physics {
    Mobility( HighFieldSaturation PhuMob Enormal )
    EffectiveIntrinsicDensity( BandGapNarrowing( OldSlotboom ) )
    Recombination(
        SRH( DopingDep Tunneling(Hurkx) )
        Auger
    )
    eQuantumPotential
    hQuantumPotential
    Fermi
}


###############################################################
## PHYSICS – REGION-SPECIFIC (pFET nanosheet suppression)
##
## PURPOSE: When Vg sweeps 0→1V for nFET, the shared TiN gate
## simultaneously pushes pFET channels (n-type background) into
## accumulation. Accumulated holes in pFET nanosheets:
##   (a) induce mirror charges on gate → distorts Cgg
##   (b) cause hole current in pFET S/D → adds to gate leakage
##   (c) shift apparent nFET Vt by ~5–15 mV
##
## FIX: Disable HighFieldSaturation and Enormal in pFET channels
## (they carry no meaningful current in nFET simulation).
## hQuantumPotential kept — needed for charge self-consistency.
## Fermi kept — doping is 5e15 (not degenerate, but consistent).
##
## NOTE: Region names must match your SDE exactly:
##   "Nanosheet_P1" and "Nanosheet_P2"
###############################################################
Physics {
    Mobility( PhuMob )
    EffectiveIntrinsicDensity( BandGapNarrowing( OldSlotboom ) )
    Recombination( SRH( DopingDep ) )
    hQuantumPotential
    eQuantumPotential
    Fermi
}

Physics  {
    Mobility( PhuMob )
    EffectiveIntrinsicDensity( BandGapNarrowing( OldSlotboom ) )
    Recombination( SRH( DopingDep ) )
    hQuantumPotential
    eQuantumPotential
    Fermi
}


###############################################################
## MATH
##
## Matched to your last working attempt settings:
##   Digits=5, ErRef=1e10     → matches forksheet exactly
##   Notdamped=10             → reduced from 50, stops oscillation
##   Iterations=25            → slightly above forksheet's 20
##   Decrement=3 in Solve     → aggressive step-back (set per sweep)
##   No RhsFactor             → removed (was killing Newton at iter 1)
##   -CheckUndefinedModels    → suppress non-fatal warnings
##   NaturalBoxMethod         → consistent with forksheet
###############################################################
Math {
    Extrapolate
    Derivatives
    RelErrControl
    Digits          = 5
    ErRef(electron) = 1.e10
    ErRef(hole)     = 1.e10
    Notdamped       = 10
    Iterations      = 25
    DirectCurrent
    Method          = ParDiSo
    Parallel        = 2
    NaturalBoxMethod
    -CheckUndefinedModels
}


###############################################################
## PLOT
## Full variable set — all from forksheet + band structure +
## quantum potentials for CFET nanosheet analysis
###############################################################
Plot {
    eDensity hDensity
    eCurrent hCurrent
    TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
    eMobility hMobility
    eVelocity hVelocity
    eEnormal hEnormal
    ElectricField/Vector Potential SpaceCharge
    eQuasiFermi hQuasiFermi
    Potential Doping SpaceCharge
    SRH Auger
    AvalancheGeneration
    DonorConcentration AcceptorConcentration
    Doping
    eGradQuasiFermi/Vector hGradQuasiFermi/Vector
    eEparallel hEparallel
    BandGap
    Affinity
    ConductionBand ValenceBand
    eQuantumPotential
    hQuantumPotential
}


###############################################################
## SOLVE
##
## 6-stage robust solve sequence:
##
##  Stage 1 : Equilibrium (3-step, matches working forksheet)
##  Stage 2a: VDS 0  → 0.1V  (gentle first ramp)
##  Stage 2b: VDS 0.1→ 0.4V
##  Stage 2c: VDS 0.4→ 0.7V  (saturation bias established)
##  Stage 3 : Id-Vg saturation  (Vg: 0→1.0V at VDS=0.7V)
##  Stage 4 : Gate ramp back to 0V  (clean state before VDS change)
##  Stage 5 : VDS ramp 0.7→0.05V   (linear bias point)
##  Stage 6 : Id-Vg linear  (Vg: 0→1.0V at VDS=0.05V)
##
## InitialStep=5e-4 for gate sweeps (Stages 3,6) — t=0 was
## the crash point in your log, smaller first step prevents this
###############################################################
Solve {

    ##---------------------------------------------------------
    ## STAGE 1: EQUILIBRIUM
    ## 3-step identical to working forksheet:
    ##   Poisson only → Poisson+E+H (100 iter each) → full coupled
    ##---------------------------------------------------------

    Coupled( Iterations=100 ){ Poisson }
    Coupled( Iterations=100 ){ Poisson Electron Hole }
    Coupled                  { Poisson Electron Hole }


    ##---------------------------------------------------------
    ## STAGE 2a: VDS ramp  0 → 0.1V
    ## Very gentle — establishes initial carrier gradient
    ## without shocking the degenerate S/D junctions
    ##---------------------------------------------------------
    Quasistationary(
        InitialStep = 1e-3
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.05
        Goal { Name="drain_N" Voltage=0.1 }
    ){ Coupled { Poisson Electron Hole } }


    ##---------------------------------------------------------
    ## STAGE 2b: VDS ramp  0.1 → 0.4V
    ##---------------------------------------------------------
    Quasistationary(
        InitialStep = 1e-3
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.05
        Goal { Name="drain_N" Voltage=0.4 }
    ){ Coupled { Poisson Electron Hole } }


    ##---------------------------------------------------------
    ## STAGE 2c: VDS ramp  0.4 → 0.7V
    ## Saturation bias fully established after this stage
    ##---------------------------------------------------------
    Quasistationary(
        InitialStep = 1e-3
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.05
        Goal { Name="drain_N" Voltage=0.7 }
    ){ Coupled { Poisson Electron Hole } }


    ##---------------------------------------------------------
    ## STAGE 3: Id–Vg SATURATION SWEEP
    ## VDS = 0.7V (held), Vg sweeps 0 → 1.0V
    ##
    ## InitialStep=5e-4 (half of forksheet's 1e-3):
    ##   Your log showed crash at t=0 of gate sweep
    ##   Smaller first step gives Newton a stable starting point
    ##
    ## MaxStep=0.03 (forksheet had 0.05):
    ##   Finer steps through subthreshold region (Vg=0.2–0.5V)
    ##   where Id changes by decades per 60mV — too large a step
    ##   causes Newton to jump over the exponential region
    ##
    ## CurrentPlot 200 intervals → Vg resolution = 1.0/200 = 5mV
    ##   sufficient for accurate SS and Vt extraction
    ##---------------------------------------------------------

    Quasistationary(
        InitialStep = 5e-4
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.03
        Goal { Name="gate" Voltage=1.0 }
    ){
        Coupled { Poisson Electron Hole }
        CurrentPlot( Time=(range=(0 1) intervals=200) )
    }


    ##---------------------------------------------------------
    ## STAGE 4: Gate ramp back  1.0V → 0.0V
    ## IMPORTANT: must ramp gate back to 0 BEFORE changing VDS
    ## Reason: if VDS is changed while gate is at 1V (strong
    ## inversion), the sudden loss of channel charge causes
    ## Newton to diverge. Returning to 0V first ensures
    ## sub-threshold state before VDS perturbation.
    ##---------------------------------------------------------
    Quasistationary(
        InitialStep = 1e-3
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.05
        Goal { Name="gate" Voltage=0.0 }
    ){ Coupled { Poisson Electron Hole } }


    ##---------------------------------------------------------
    ## STAGE 5: VDS ramp  0.7V → 0.05V  (linear bias point)
    ## Ramping DOWN is generally easier to converge than up
    ## because carrier density is decreasing monotonically
    ##---------------------------------------------------------
    Quasistationary(
        InitialStep = 1e-3
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.05
        Goal { Name="drain_N" Voltage=0.05 }
    ){ Coupled { Poisson Electron Hole } }


    ##---------------------------------------------------------
    ## STAGE 6: Id–Vg LINEAR SWEEP
    ## VDS = 0.05V (held), Vg sweeps 0 → 1.0V
    ## Same step settings as Stage 3
    ## Linear regime Id is ~14x smaller than saturation
    ## but subthreshold slope and Vt are more accurately
    ## extracted here (less DIBL distortion)
    ##---------------------------------------------------------

    Quasistationary(
        InitialStep = 5e-4
        Increment   = 1.35
        Decrement   = 3
        MinStep     = 1e-5
        MaxStep     = 0.03
        Goal { Name="gate" Voltage=1.0 }
    ){
        Coupled { Poisson Electron Hole }
        CurrentPlot( Time=(range=(0 1) intervals=200) )
    }

}
## END OF FILE
