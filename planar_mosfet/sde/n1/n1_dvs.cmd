;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTO REGION NAMING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:set-auto-region-naming ON)
(sdegeo:set-default-boolean "ABA")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GEOMETRY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:create-rectangle
 (position -0.5 0 0) (position 0.5 1 0)
 "Silicon" "R.Siliconepi")        ;; SUBSTRATE / BODY

(sdegeo:create-rectangle
 (position -0.2 -0.004 0) (position 0.2 0 0)
 "Oxide" "R.Gateox")           ;; GATE OXIDE

(sdegeo:create-rectangle
 (position -0.2 -0.2 0) (position 0.2 -0.004 0)
 "Nitride" "R.Spacer")          ;; SPACER

(sdegeo:create-rectangle
 (position -0.1 -0.2 0) (position 0.1 -0.004 0)
 "PolySilicon" "R.Polygate")         ;; GATE

(sdegeo:create-rectangle
 (position -0.5 0.1 0) (position 0.5 0.2 0)
 "Oxide" "R.Box")           ;; FIELD OXIDE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FILLET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:fillet-2d
 (list
  (car (find-vertex-id (position 0.2 -0.2 0)))
  (car (find-vertex-id (position -0.2 -0.2 0)))
 )
 0.08)

(render:rebuild)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTACT DEFINITIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:define-contact-set "source"    4 (color:rgb 1 0 0) "##")
(sdegeo:define-contact-set "drain"     4 (color:rgb 0 1 0) "##")
(sdegeo:define-contact-set "gate"      4 (color:rgb 1 1 0) "##")
(sdegeo:define-contact-set "substrate" 4 (color:rgb 0 0 1) "##")
(sdegeo:define-contact-set "bodytie"   4 (color:rgb 1 1 1) "##")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SOURCE & DRAIN (SILICON SIDEWALLS)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:set-current-contact-set "source")
(sdegeo:set-contact
 (list (car (find-edge-id (position -0.35 0 0))))
 "source")

(sdegeo:set-current-contact-set "drain")
(sdegeo:set-contact
 (list (car (find-edge-id (position 0.35 0 0))))
 "drain")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SUBSTRATE (BOTTOM OF SILICON — CORRECT)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:set-current-contact-set "substrate")
(sdegeo:set-contact
 (list (car (find-edge-id (position 0.0 1.0 0))))
 "substrate")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GATE (POLYSI BOTTOM EDGE — CORRECT)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:set-current-contact-set "gate")
(sdegeo:set-contact (list (car (find-body-id (position 0 -0.102 0)))) "gate")

(sdegeo:set-contact (list (car (find-edge-id (position 0.0 -0.2 0))) (car (find-edge-id (position 0.1 -0.102 0))) (car (find-edge-id (position 0.0 -0.004 0))) (car (find-edge-id (position -0.1 -0.102 0)))) "gate")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BODY TIE (SIDE SILICON)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdegeo:insert-vertex (position -0.1 0.1 0))
(sdegeo:insert-vertex (position -0.05 0.1 0))

(sdegeo:set-current-contact-set "bodytie")
(sdegeo:set-contact
 (list (car (find-edge-id (position -0.075 0.1 0))))
 "bodytie")

(render:rebuild)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DOPING (CLEAN, NO DUPLICATES)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdedr:define-constant-profile
 "Const.Silicon" "BoronActiveConcentration" 1e15)

(sdedr:define-constant-profile-material
 "PlaceCD.Silicon" "Const.Silicon" "Silicon")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REFINEMENT WINDOW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdedr:define-refeval-window "BaseLine.Source" "Line" (position -0.8 0 0) (position -0.2 0 0)) 
(sdedr:define-refeval-window "BaseLine.Drain" "Line" (position 0.2 0 0) (position 0.8 0 0)) 
(sdedr:define-refeval-window "BaseLine.SourceExt" "Line" (position -0.8 0 0) (position -0.1 0 0)) 
(sdedr:define-refeval-window "BaseLine.DrainExt" "Line" (position 0.1 0 0) (position 0.8 0 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Analytical Doping(GAUSSIAN PROFILES)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdedr:define-analytical-profile-placement "PlaceAP.Source" "Guassian.SourceDrain" "BaseLine.Source" "Positive" "NoReplace" "Eval") 
(sdedr:define-gaussian-profile "Guassian.SourceDrain" "ArsenicActiveConcentration" "PeakPos" 0 "PeakVal" 5e+19 "ValueAtDepth" 1e+17 "Depth" 0.12 "Gauss" "Factor" 0.8)

(sdedr:define-analytical-profile-placement "PlaceAP.Drain" "Guassian.SourceDrain" "BaseLine.Drain" "Positive" "NoReplace" "Eval") 
(sdedr:define-gaussian-profile "Guassian.SourceDrain" "ArsenicActiveConcentration" "PeakPos" 0 "PeakVal" 5e+19 "ValueAtDepth" 1e+17 "Depth" 0.12 "Gauss" "Factor" 0.8)

(sdedr:define-analytical-profile-placement "PlaceAP.SourceExt" "Guassian.SourceDrainExt" "BaseLine.SourceExt" "Positive" "NoReplace" "Eval")
(sdedr:define-gaussian-profile "Guassian.SourceDrainExt" "ArsenicActiveConcentration" "PeakPos" 0 "PeakVal" 5e+18 "ValueAtDepth" 1e+17 "Depth" 0.035 "Gauss" "Factor" 0.8) 

 (sdedr:define-analytical-profile-placement "PlaceAP.DrainExt" "Guassian.SourceDrainExt" "BaseLine.DrainExt" "Positive" "NoReplace" "Eval")
(sdedr:define-gaussian-profile "Guassian.SourceDrainExt" "ArsenicActiveConcentration" "PeakPos" 0 "PeakVal" 5e+18 "ValueAtDepth" 1e+17 "Depth" 0.035 "Gauss" "Factor" 0.8)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MESH (ONLY MISSING WINDOW FIXED)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sdedr:define-refeval-window "RefWin.all" "Rectangle" (position -1 -0.5 0) (position 1 1.5 0))
(sdedr:define-refinement-size "RelDef.all" 0.25 0.1 0.25 0.1 )
(sdedr:define-refinement-placement "Place.RF.all" "RelDef.all" (list "window" "RefWin.all" ) )
(sdedr:define-refinement-function "RelDef.all" "DopingConcentration" "MaxTransDiff" 1)
(sdedr:define-refinement-function "RelDef.all" "MaxLenInt" "Silicon" "Oxide" 0.001 1.5 "DoubleSide")


(sdedr:define-refinement-size "RefDef.Epi" 0.1 0.0125 0.0025 0.0025)
(sdedr:define-refinement-function "RefDef.Epi" 
  "DopingConcentration" "MaxTransDiff" 1) 
(sdedr:define-refinement-region "PlaceRF.Epi" "RefDef.Epi" "R.Siliconepi")
(sdedr:define-refinement-function "RefDef.Epi" "MaxLenInt" "R.Siliconepi" 
  "R.Gateox" 0.0002 1.5 "DoubleSide" "UseRegionNames")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BUILD & VIEW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sde:set-meshing-command "snmesh")
(sde:build-mesh "" "/home/banotht.scee.iitmandi/mosfet_tutorial/final_structure")

(sde:save-model
 "/home/banotht.scee.iitmandi/mosfet_tutorial/final_structure")

(system:command
 "svisual /home/banotht.scee.iitmandi/mosfet_tutorial/final_structure_msh.tdr &")


