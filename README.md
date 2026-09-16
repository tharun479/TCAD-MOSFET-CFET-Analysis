# TCAD-Based Planar MOSFET and CFET Analysis

**Device Modeling and Simulation using Synopsys Sentaurus TCAD**

This project presents the modeling and electrical analysis of nanoscale transistor structures using **Synopsys Sentaurus TCAD**. The work includes planar MOSFET simulation, electrical characteristic extraction, threshold-voltage analysis, and modeling of a vertically stacked complementary FET (CFET) architecture.

---

## Project Overview

Technology scaling has pushed conventional planar transistor architectures toward increasingly complex device structures. TCAD provides a physics-based approach for studying these devices before fabrication by allowing their geometry, materials, doping profiles, and electrical behavior to be investigated through numerical simulation.

This project was carried out in two stages:

1. **Planar MOSFET modeling and characterization**
2. **CFET modeling and scaling analysis**

The simulations were performed using the Synopsys Sentaurus TCAD environment.

---

## Objectives

* Construct and simulate a planar MOSFET device.
* Define semiconductor geometry, materials, contacts, and doping profiles.
* Generate a suitable device mesh for numerical simulation.
* Analyze MOSFET electrical characteristics.
* Obtain drain-current versus gate-voltage ($I_D$-$V_G$) characteristics.
* Analyze drain-current versus drain-voltage ($I_D$-$V_D$) behavior.
* Extract the threshold voltage from simulated characteristics.
* Investigate advanced transistor architectures using CFET modeling.
* Study the effect of device scaling and vertical transistor integration.

---

## Tools and Technologies

| Tool                                      | Purpose                                          |
| ----------------------------------------- | ------------------------------------------------ |
| Synopsys Sentaurus Structure Editor (SDE) | Device geometry and structure generation         |
| Sentaurus Mesh                            | Mesh generation and refinement                   |
| Sentaurus Device (SDevice)                | Electrical device simulation                     |
| Sentaurus Visual (SVisual)                | Visualization and analysis of simulation results |
| TCAD                                      | Physics-based semiconductor device modeling      |

---

# 1. Planar MOSFET

## Device Structure

The planar MOSFET was constructed by defining the semiconductor region, source/drain regions, gate dielectric, gate electrode, and electrical contacts.

The device structure was then meshed with finer resolution in electrically important regions such as the channel and semiconductor-insulator interface.



---

## Electrical Characterization

The simulated device was characterized using bias sweeps to obtain its electrical behavior.

### Drain Characteristics

The drain current was evaluated as a function of drain voltage for different gate-bias conditions.



The resulting characteristics demonstrate the transition from the low-field region toward current saturation as the drain voltage increases.

---

## Transfer Characteristics

The $I_D$-$V_G$ characteristic was used to study the transistor turn-on behavior and extract the threshold voltage.



Threshold voltage extraction was performed from the simulated transfer characteristic using an appropriate extraction method.

---

# 2. CFET Modeling

Complementary FET (CFET) architectures vertically integrate complementary transistor devices, providing a potential approach for increasing transistor density beyond conventional side-by-side CMOS layouts.

The CFET structure in this project was modeled using Sentaurus Structure Editor and subsequently analyzed using Sentaurus Device.



The model includes vertically arranged device regions together with source/drain regions, gate structures, dielectric layers, and isolation regions.

---

## CFET Electrical Analysis

The simulated CFET structure was investigated to understand its electrical behavior and the influence of device geometry and scaling parameters.



The modeling process provides insight into the electrostatic and electrical behavior of vertically integrated transistor architectures.

---

# 3. Simulation Workflow

The overall TCAD workflow used in this project is:

```text
Device Geometry
      ↓
Material Definition
      ↓
Doping / Profiles
      ↓
Contacts and Electrodes
      ↓
Mesh Generation
      ↓
Physical Models
      ↓
Electrical Biasing
      ↓
Sentaurus Device Simulation
      ↓
SVisual Analysis
      ↓
I-V Characteristics
      ↓
Parameter Extraction
```

---

# 4. Repository Structure

```text
TCAD-MOSFET-CFET-Analysis/
│
├── planar_mosfet/
│   ├── sde/
│   ├── sdevice/
│   ├── mesh/
│   └── results/
│
├── cfet/
│   ├── sde/
│   ├── sdevice/
│   ├── mesh/
│   └── results/
│
├── figures/
├── docs/
└── README.md
```

---

# 5. Key Learning Outcomes

Through this project, I worked with:

* Semiconductor device geometry definition
* Doping and material specification
* TCAD mesh generation and refinement
* MOSFET electrical characterization
* $I_D$-$V_G$ and $I_D$-$V_D$ analysis
* Threshold-voltage extraction
* Numerical device simulation
* Sentaurus Structure Editor
* Sentaurus Device
* Sentaurus Visual
* Advanced transistor architecture modeling
* CFET structure and scaling considerations

---

# 6. Project Status

### Planar MOSFET

**Completed**

* Device structure
* Meshing
* Electrical simulation
* I-V characterization


### CFET

**In Progress / Under Development**

* 3D device structure modeling
* Electrical simulation
* Scaling analysis
* CFET inverter analysis

---

## Author

**Banoth Tharun**

B.Tech — Microelectronics and VLSI
Indian Institute of Technology Mandi

GitHub: [@tharun479](https://github.com/tharun479)

---

## Note

This repository contains simulation input files, selected output figures, and analysis associated with the TCAD study. Large generated simulation datasets and proprietary software files are intentionally excluded from version control.
