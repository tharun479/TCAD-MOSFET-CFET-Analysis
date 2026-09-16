Title ""

Controls {
}

IOControls {
	outputFile = "new_mesh"
	EnableSections
}

Definitions {
	Constant "Dop_NS_P1" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+15
	}
	Constant "Dop_NS_P2" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+15
	}
	Constant "Dop_NS_N1" {
		Species = "BoronActiveConcentration"
		Value = 5e+15
	}
	Constant "Dop_NS_N2" {
		Species = "BoronActiveConcentration"
		Value = 5e+15
	}
	Constant "Dop_Src_P" {
		Species = "BoronActiveConcentration"
		Value = 5e+20
	}
	Constant "Dop_Drn_P" {
		Species = "BoronActiveConcentration"
		Value = 5e+20
	}
	Constant "Dop_Src_N" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+20
	}
	Constant "Dop_Drn_N" {
		Species = "PhosphorusActiveConcentration"
		Value = 5e+20
	}
	Refinement "RefSize_Global" {
		MaxElementSize = ( 0.01 0.01 0.01 )
		MinElementSize = ( 0.01 0.01 0.01 )
	}
	Refinement "RefSize_NS_all" {
		MaxElementSize = ( 0.0007 0.0015 0.0007 )
		MinElementSize = ( 0.0007 0.0015 0.0007 )
	}
	Refinement "RefSize_P_Junc" {
		MaxElementSize = ( 0.0008 0.002 0.0008 )
		MinElementSize = ( 0.0008 0.002 0.0008 )
	}
	Refinement "RefSize_N_Junc" {
		MaxElementSize = ( 0.0008 0.002 0.0008 )
		MinElementSize = ( 0.0008 0.002 0.0008 )
	}
	Refinement "RefSize_SrcP" {
		MaxElementSize = ( 0.0015 0.0015 0.002 )
		MinElementSize = ( 0.0015 0.0015 0.002 )
	}
	Refinement "RefSize_DrnP" {
		MaxElementSize = ( 0.0015 0.0015 0.002 )
		MinElementSize = ( 0.0015 0.0015 0.002 )
	}
	Refinement "RefSize_SrcN" {
		MaxElementSize = ( 0.0015 0.0015 0.002 )
		MinElementSize = ( 0.0015 0.0015 0.002 )
	}
	Refinement "RefSize_DrnN" {
		MaxElementSize = ( 0.0015 0.0015 0.002 )
		MinElementSize = ( 0.0015 0.0015 0.002 )
	}
	Refinement "RefSize_Gate" {
		MaxElementSize = ( 0.0015 0.0015 0.002 )
		MinElementSize = ( 0.0015 0.0015 0.002 )
	}
}

Placements {
	Constant "Place_NS_P1" {
		Reference = "Dop_NS_P1"
		EvaluateWindow {
			Element = region ["Nanosheet_P1"]
		}
	}
	Constant "Place_NS_P2" {
		Reference = "Dop_NS_P2"
		EvaluateWindow {
			Element = region ["Nanosheet_P2"]
		}
	}
	Constant "Place_NS_N1" {
		Reference = "Dop_NS_N1"
		EvaluateWindow {
			Element = region ["Nanosheet_N1"]
		}
	}
	Constant "Place_NS_N2" {
		Reference = "Dop_NS_N2"
		EvaluateWindow {
			Element = region ["Nanosheet_N2"]
		}
	}
	Constant "Place_Src_P" {
		Reference = "Dop_Src_P"
		EvaluateWindow {
			Element = region ["Source_P"]
		}
	}
	Constant "Place_Drn_P" {
		Reference = "Dop_Drn_P"
		EvaluateWindow {
			Element = region ["Drain_P"]
		}
	}
	Constant "Place_Src_N" {
		Reference = "Dop_Src_N"
		EvaluateWindow {
			Element = region ["Source_N"]
		}
	}
	Constant "Place_Drn_N" {
		Reference = "Dop_Drn_N"
		EvaluateWindow {
			Element = region ["Drain_N"]
		}
	}
	Refinement "RefPlace_Global" {
		Reference = "RefSize_Global"
		RefineWindow = Cuboid [(-0.001 -0.001 -0.001) (0.045 0.05 0.105)]
	}
	Refinement "RefPlace_NS_all" {
		Reference = "RefSize_NS_all"
		RefineWindow = Cuboid [(0.012 0 0.025) (0.028 0.044 0.095)]
	}
	Refinement "RefPlace_P_Junc" {
		Reference = "RefSize_P_Junc"
		RefineWindow = Cuboid [(0.013 0 0.025) (0.027 0.044 0.046)]
	}
	Refinement "RefPlace_N_Junc" {
		Reference = "RefSize_N_Junc"
		RefineWindow = Cuboid [(0.013 0 0.075) (0.027 0.044 0.096)]
	}
	Refinement "RefPlace_SrcP" {
		Reference = "RefSize_SrcP"
		RefineWindow = Cuboid [(0.008 -0.001 0.025) (0.032 0.004 0.048)]
	}
	Refinement "RefPlace_DrnP" {
		Reference = "RefSize_DrnP"
		RefineWindow = Cuboid [(0.008 0.04 0.025) (0.032 0.045 0.048)]
	}
	Refinement "RefPlace_SrcN" {
		Reference = "RefSize_SrcN"
		RefineWindow = Cuboid [(0.008 -0.001 0.075) (0.032 0.004 0.098)]
	}
	Refinement "RefPlace_DrnN" {
		Reference = "RefSize_DrnN"
		RefineWindow = Cuboid [(0.008 0.04 0.075) (0.032 0.045 0.098)]
	}
	Refinement "RefPlace_Gate" {
		Reference = "RefSize_Gate"
		RefineWindow = Cuboid [(0.012 0.015 0.025) (0.028 0.029 0.095)]
	}
}

