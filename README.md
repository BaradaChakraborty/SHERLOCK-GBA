# SHERLOCK-GBA: CRISPR-Cas13a Diagnostics and Neuro-Immune Mapping

## Project Overview
This repository establishes an independent, end-to-end computational framework for the precision molecular surveillance of *Plasmodium falciparum* and its systemic impact on host physiology. The project integrates a **CRISPR-Cas13a (SHERLOCK)** guide RNA (gRNA) design pipeline with high-dimensional modeling of the **Gut-Brain Axis (GBA)**.

By targeting the **Kelch13 (PfK13) propeller domain**—the primary genetic determinant of artemisinin resistance—this workflow enables the "ultrasensitive" detection of pathogen genotypes. These diagnostic outputs are then correlated with **microglial activation signatures** (CX3CR1/Iba1) to parameterize the neuro-inflammatory sequelae of systemic infection.

## Pipeline Architecture

* **Script 01: Cas13a gRNA Engineering for AT-Rich Genomes**
    * Implements a custom sliding window algorithm to generate **28nt spacers**, adhering to the biophysical constraints of the **Cas13a (SHERLOCK)** effector protein.
    * Optimizes for a **25-45% GC-content threshold** to address the unique **AT-rich genomic architecture** of the *Plasmodium* genome, ensuring diagnostic specificity.
    * Filters and isolates candidate guides (n=25) targeting critical drug-resistance SNPs within the **PfK13 domain**.

* **Script 02: Neuro-Immune Correlation and GBA Modeling**
    * Constructs a statistical framework linking CRISPR-detected parasite loads to host hypothalamic microglial set-points.
    * Models the **negative correlation** ($r = -0.946$) between microglial activation (**Iba1 intensity**) and the expression of homeostatic regulatory checkpoints (**CX3CR1**).
    * Quantifies the collapse of neuro-immune resilience as a function of pathogen genotype severity.

## Visual Results
All technical outputs proving diagnostic viability and systemic correlation are securely archived in the `results/` and `figures/` directories. The **GBA_Microglia_Correlation.png** plot specifically demonstrates a robust negative correlation between Iba1-mediated activation and CX3CR1-mediated regulation, providing a computational proof-of-concept for the predictive value of molecular genotyping in neuro-immunology.

## Future Directions: In Vitro and In Vivo Validation
To empirically validate the computational gRNA designs and the GBA-crosstalk model, an integrated experimental approach is proposed:

1. **Diagnostic Validation**: The engineered Cas13a guides will be synthesized and screened using a fluorescence-based SHERLOCK assay. Synthetic *PfK13* RNA fragments containing artemisinin-resistance SNPs will be used to quantify the "collateral cleavage" efficiency and limit of detection (LoD) for each candidate gRNA.
2. **Gut-Brain Axis Modeling**: Utilizing a microfluidic Gut-on-a-Chip system, the impact of *Plasmodium*-derived metabolites or extracellular vesicles on human-derived microglial cell lines will be assessed. High-resolution confocal microscopy and qRT-PCR will quantify the predicted shift from a homeostatic (CX3CR1-high) to an activated (Iba1-high) microglial phenotype.
3. **In Vivo Assessment**: Balb/c mice will be infected with *Plasmodium berghei* (as a proxy for severe malaria) to monitor real-time gut-barrier permeability and hypothalamic microglial remodeling, bridging the gap between in-silico genotyping and functional systemic pathology.

## Dependencies & Reproducibility
This project utilizes the `renv` package manager to guarantee 100% computational reproducibility across research environments. The primary R packages required include:

* **Biostrings (Bioconductor):** The core engine for high-performance sequence analysis and gRNA design.
* **Tidyverse & ggplot2:** Utilized for data wrangling and generating publication-ready GBA correlation visualizations.
* **BiocManager:** Essential for managing specialized bioinformatics dependencies.

## How to Run the Pipeline
1. Clone this repository to your local machine.
2. Open the `SHERLOCK-GBA.Rproj` file in RStudio.
3. Run `renv::restore()` in the R console to install the exact dependency versions.
4. Execute `scripts/01_gRNA_Design.R` and `scripts/02_GBA_Correlation.R` in sequential order.
