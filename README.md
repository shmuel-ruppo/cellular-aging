# Cell-to-cell-variability and gain of methylation as a hallmark of aging

This repository contains scripts for reproducing the data analysis and figures in the article by Masika et al (2026).  

## Overview

This pipeline processes the data,  analyzes it and plots figures. 

## Requirements
MATLAB R2024a or later,R >= 4.4.3, Bioconductor >= 3.20, Pandoc >= 2.0 or RStudio. 

Required R packages are listed in dependencies.txt

All data required to run this pipeline is included in the repository or will be downloaded from GEO during execution.

This pipeline was tested on x86_64-linux-gnu. A minimum of 8GB free RAM, and an internet connection is required for steps 3-4. 

## Steps for execution

Expected runtime of data preprocessing and analysis (after installation of required R packages) is about 15 minutes. 

1. **Clone the repository** with the command `git clone https://github.com/shmuel-ruppo/cellular-aging/`
Typical install time for the repository is less than a minute.

2. **Figures reproduction**:
Run the files from Figures/ directory, to output figures as pdf files. This should be done in MATLAB and does not depend on the data preparation steps in R (steps 3-4). 

3. **Data Preparation for Regression**:

Go to data/ directory, and run *sc_Blood_1sample_NEW_for_github.Rmd* and *sc_Muscle_1sample_for_github.Rmd*. Then continue with  *annotateCreateSubset.Rmd* and *annotateCreateSubset_withinTcells.Rmd*.

This processes single-cell data, combines it with methylation data, and subsets  by cell type. The  output is .RData and text files to be further used in the next step.   

4. **Regression Analysis**: 

Go to *Reg_All/* directory and run *Reg_All.Rmd*. The output is in a results directory.

* Note:  `.Rmd` files can be executed with the rmarkdown package `rmarkdown::render("filename.Rmd",output_file="filename.html")`.  The RStudio program is a visual alternative.

