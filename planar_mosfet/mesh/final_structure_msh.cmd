Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "Const.Silicon" {
		Species = "BoronActiveConcentration"
		Value = 1e+15
	}
	AnalyticalProfile "Guassian.SourceDrain" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 5e+19, ValueAtDepth = 1e+17, Depth = 0.12)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "Guassian.SourceDrainExt" {
		Species = "ArsenicActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 5e+18, ValueAtDepth = 1e+17, Depth = 0.035)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "RelDef.all" {
		MaxElementSize = ( 0.25 0.1 )
		MinElementSize = ( 0.25 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("Silicon","Oxide"), Value=0.001, factor=1.5, DoubleSide)
	}
	Refinement "RefDef.Epi" {
		MaxElementSize = ( 0.1 0.0125 )
		MinElementSize = ( 0.0025 0.0025 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
		RefineFunction = MaxLenInt(Interface("R.Siliconepi","R.Gateox"), Value=0.0002, factor=1.5, DoubleSide, UseRegionNames)
	}
}

Placements {
	Constant "PlaceCD.Silicon" {
		Reference = "Const.Silicon"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	AnalyticalProfile "PlaceAP.Source" {
		Reference = "Guassian.SourceDrain"
		ReferenceElement {
			Element = Line [(-0.8 0) (-0.2 0)]
			Direction = positive
		}
	}
	AnalyticalProfile "PlaceAP.Drain" {
		Reference = "Guassian.SourceDrain"
		ReferenceElement {
			Element = Line [(0.2 0) (0.8 0)]
			Direction = positive
		}
	}
	AnalyticalProfile "PlaceAP.SourceExt" {
		Reference = "Guassian.SourceDrainExt"
		ReferenceElement {
			Element = Line [(-0.8 0) (-0.1 0)]
			Direction = positive
		}
	}
	AnalyticalProfile "PlaceAP.DrainExt" {
		Reference = "Guassian.SourceDrainExt"
		ReferenceElement {
			Element = Line [(0.1 0) (0.8 0)]
			Direction = positive
		}
	}
	Refinement "Place.RF.all" {
		Reference = "RelDef.all"
		RefineWindow = Rectangle [(-1 -0.5) (1 1.5)]
	}
	Refinement "PlaceRF.Epi" {
		Reference = "RefDef.Epi"
		RefineWindow = region ["R.Siliconepi"]
	}
}

