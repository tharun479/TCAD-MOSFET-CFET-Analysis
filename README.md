# ⚡ TCAD-Based Planar MOSFET & CFET Analysis

### 🔬 Device Modeling & Simulation using Synopsys Sentaurus TCAD

<p align="center">

<img src="https://img.shields.io/badge/Domain-Semiconductor%20Devices-8A2BE2?style=for-the-badge">
<img src="https://img.shields.io/badge/TCAD-Sentaurus-0066CC?style=for-the-badge">
<img src="https://img.shields.io/badge/MOSFET-Device%20Modeling-FF6B35?style=for-the-badge">
<img src="https://img.shields.io/badge/CFET-Advanced%20Architecture-00A86B?style=for-the-badge">

</p>

<p align="center">

<img src="https://img.shields.io/badge/SDE-Structure%20Editor-555555?style=flat-square">
<img src="https://img.shields.io/badge/SDevice-Device%20Simulation-555555?style=flat-square">
<img src="https://img.shields.io/badge/SVisual-Data%20Analysis-555555?style=flat-square">

</p>

---

## 🧠 About the Project

This project focuses on the **physics-based modeling and electrical analysis of nanoscale transistor structures** using **Synopsys Sentaurus TCAD**.

The work covers the simulation of a conventional **planar MOSFET** followed by the modeling of an advanced **vertically stacked Complementary FET (CFET)** architecture.

The project explores:

> **Device Geometry → Doping → Meshing → Physics → Electrical Simulation → Parameter Extraction**

The primary goal is to understand how transistor architecture and scaling influence device behavior at advanced technology dimensions.

---

## 🎯 Project Objectives

| #     | Objective                                                             |
| ----- | --------------------------------------------------------------------- |
| 🔹 01 | Construct and simulate a planar MOSFET                                |
| 🔹 02 | Define semiconductor geometry, materials, contacts and doping         |
| 🔹 03 | Generate an appropriate device mesh                                   |
| 🔹 04 | Analyze MOSFET electrical characteristics                             |
| 🔹 05 | Obtain $I_D$-$V_G$ transfer characteristics                           |
| 🔹 06 | Obtain $I_D$-$V_D$ output characteristics                             |
| 🔹 07 | Extract threshold voltage from simulated characteristics              |
| 🔹 08 | Develop a 3D CFET device structure                                    |
| 🔹 09 | Investigate vertically stacked complementary transistor architectures |
| 🔹 10 | Study device scaling and electrical behavior                          |

---

# 🛠️ Tools & Technologies

|       Tool / Technology       | Application                                 |
| :---------------------------: | ------------------------------------------- |
| 🔬 **Synopsys Sentaurus SDE** | Device geometry and structure generation    |
|     📐 **Sentaurus Mesh**     | Mesh generation and refinement              |
|    ⚙️ **Sentaurus SDevice**   | Semiconductor device simulation             |
|    📊 **Sentaurus SVisual**   | Visualization and electrical analysis       |
|          🧪 **TCAD**          | Physics-based semiconductor device modeling |
|   💻 **Tcl / Command Files**  | Simulation setup and automation             |

---

# 🟣 1. Planar MOSFET

## 🧩 Device Structure

The first stage of the project involved constructing and simulating a **planar MOSFET**.

The device structure was defined by specifying:

* Semiconductor regions
* Source and drain regions
* Channel region
* Gate dielectric
* Gate electrode
* Electrical contacts
* Doping profiles

A refined mesh was applied to electrically important regions, particularly around the **channel and semiconductor–insulator interface**.

### 📐 Device Structure

> 📌 Add your SVisual structure screenshot here.

```text
![Planar MOSFET Structure](figures/planar_mosfet_structure.png)
```

---

## ⚡ Electrical Characterization

The simulated MOSFET was electrically characterized using appropriate voltage bias sweeps.

### 📈 Drain Characteristics — $I_D$-$V_D$

The drain current was evaluated as a function of drain voltage for different gate-bias conditions.

The resulting characteristics illustrate the progression from the low-field region toward the **current-saturation regime** as the drain voltage increases.

### 📊 Result

> 📌 Add your $I_D$-$V_D$ plot here.

```text
![MOSFET Output Characteristics](figures/planar_mosfet_iv.png)
```

---

## 🔋 Transfer Characteristics — $I_D$-$V_G$

The transfer characteristic was obtained by sweeping the gate voltage while maintaining an appropriate drain bias.

The resulting $I_D$-$V_G$ curve was used to study:

* Transistor turn-on behavior
* Subthreshold behavior
* Drain current variation with gate voltage
* Threshold-voltage extraction

### 📊 Result

```text
![MOSFET Transfer Characteristics](figures/Id_Vg.png)
```

---

## 🎚️ Threshold Voltage Extraction

The threshold voltage was extracted from the simulated transfer characteristic using the selected extraction methodology.

```text
![Threshold Voltage Extraction](figures/threshold_voltage.png)
```

---

# 🟢 2. CFET Modeling

## 🏗️ What is a CFET?

A **Complementary FET (CFET)** is an advanced transistor architecture in which complementary transistor devices are vertically integrated rather than placed side-by-side.

This vertical integration can provide a pathway toward increased device density and reduced footprint as conventional CMOS scaling becomes increasingly challenging.

---

## 🧱 CFET Structure

The CFET structure was modeled using **Sentaurus Structure Editor** and subsequently prepared for electrical simulation using **Sentaurus Device**.

The model incorporates vertically arranged device regions together with:

* 🟦 Semiconductor regions
* 🟨 Source/drain regions
* 🟪 Gate structures
* ⚪ Dielectric layers
* 🔲 Isolation regions
* 📐 Device-specific geometry and scaling parameters

### 🔬 3D CFET Model

```text
![CFET Structure](figures/cfet_structure.png)
```

---

## ⚡ CFET Electrical Analysis

The modeled CFET structure is being investigated to understand its electrical behavior and the influence of geometry and scaling parameters.

The analysis focuses on understanding:

* Device electrostatics
* Current–voltage behavior
* Vertical device integration
* Scaling effects
* Interaction between vertically stacked devices

### 📊 Simulation Results

```text
![CFET Results](figures/cfet_results.png)
```

---

# 🔄 3. TCAD Simulation Workflow

The overall simulation flow used in this project can be summarized as:

```text
                ┌─────────────────────┐
                │   Device Geometry   │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │ Material Definition │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │  Doping Profiles    │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │ Contacts / Electrodes│
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │   Mesh Generation   │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │  Physical Models   │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │ Electrical Biasing │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │ Sentaurus Device   │
                └──────────┬──────────┘
                           ↓
                ┌─────────────────────┐
                │     SVisual        │
                └──────────┬──────────┘
                           ↓
              ┌─────────────────────────┐
              │ I–V & Parameter Analysis│
              └─────────────────────────┘
```

---

# 📁 4. Repository Structure

```text
TCAD-MOSFET-CFET-Analysis/
│
├── 📄 README.md
│
├── 🟣 planar_mosfet/
│   ├── 📐 sde/
│   │   └── planar_mosfet.sde
│   │
│   ├── ⚙️ sdevice/
│   │   └── planar_mosfet_des.cmd
│   │
│   ├── 📏 mesh/
│   │   └── planar_mosfet_msh.cmd
│   │
│   └── 📊 results/
│       ├── Id_Vg.png
│       ├── Id_Vd.png
│       └── threshold_voltage.png
│
├── 🟢 cfet/
│   ├── 📐 sde/
│   │   └── cfet.sde
│   │
│   ├── ⚙️ sdevice/
│   │   └── cfet_des.cmd
│   │
│   ├── 📏 mesh/
│   │   └── cfet_msh.cmd
│   │
│   └── 📊 results/
│       ├── cfet_structure.png
│       └── cfet_results.png
│
├── 🖼️ figures/
│   ├── planar_mosfet_structure.png
│   ├── planar_mosfet_iv.png
│   ├── threshold_voltage.png
│   ├── cfet_structure.png
│   └── cfet_results.png
│
├── 📚 docs/
│   └── project_report.pdf
│
├── 🚫 .gitignore
│
└── 📄 LICENSE
```

---

# 📚 5. Key Learning Outcomes

Through this project, I gained hands-on experience with:

### 🔬 Device Modeling

* Semiconductor device geometry definition
* Material specification
* Doping profile definition
* Electrical contact definition
* Device meshing and refinement

### ⚡ Device Characterization

* $I_D$-$V_D$ analysis
* $I_D$-$V_G$ analysis
* Threshold-voltage extraction
* Bias-sweep configuration
* Electrical parameter analysis

### 🧪 TCAD Simulation

* Sentaurus Structure Editor
* Sentaurus Mesh
* Sentaurus Device
* Sentaurus Visual
* Numerical semiconductor-device simulation

### 🚀 Advanced Devices

* 3D transistor modeling
* CFET architecture
* Vertical transistor integration
* Device scaling considerations
* Electrostatic behavior of advanced architectures

---

# 📌 6. Project Status

| Module                          |     Status     |
| ------------------------------- | :------------: |
| 🟣 Planar MOSFET Structure      |   ✅ Completed  |
| 🟣 MOSFET Meshing               |   ✅ Completed  |
| 🟣 Electrical Simulation        |   ✅ Completed  |
| 🟣 $I_D$-$V_D$ Analysis         |   ✅ Completed  |
| 🟣 $I_D$-$V_G$ Analysis         |   ✅ Completed  |
| 🟣 Threshold Voltage Extraction |   ✅ Completed  |
| 🟢 3D CFET Structure            |   ✅ Completed  |
| 🟢 CFET Electrical Simulation   | 🔄 In Progress |
| 🟢 Scaling Analysis             | 🔄 In Progress |
| 🟢 CFET Inverter Analysis       | 🔄 In Progress |

---

# 📈 7. Future Work

The project can be extended toward:

* 🔹 Optimization of CFET geometry
* 🔹 Detailed scaling analysis
* 🔹 Comparison between planar MOSFET and CFET architectures
* 🔹 Analysis of electrostatic scaling effects
* 🔹 CFET inverter implementation
* 🔹 Investigation of device performance under different design parameters

---

# 👨‍💻 Author

### **Banoth Tharun**

🎓 B.Tech — Microelectronics and VLSI
🏛️ Indian Institute of Technology Mandi
💻 GitHub: [@tharun479](https://github.com/tharun479)

---

# 📜 Note

This repository contains selected **TCAD input files, simulation configurations, output figures, and analysis** associated with the project.

Large generated simulation datasets and proprietary software-generated files are intentionally excluded from version control.

> ⚠️ **Software Requirement:** Running the simulation files requires access to **Synopsys Sentaurus TCAD**.

---

<p align="center">

### 🔬 Semiconductor Devices • TCAD • MOSFET • CFET • Device Scaling

**Built through simulation, analysis, and device-level exploration.**

</p>
