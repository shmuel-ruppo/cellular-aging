To prepare the data, run _first sc_Blood_1sample_NEW_for_github.Rmd_ and  _sc_Muscle_1sample_for_github.Rmd_. Then annotate and subset with _annotateCreateSubset.Rmd_ and  _annotateCreateSubset_withinTcells.Rmd_


Files description:


sc_MT_Babraham_Blood_aging_Matrix.txt: Initial data matrix.

sc_Blood_1sample_NEW_for_github.Rmd : Initial exploration and cluster annotation.

sc_Muscle_1sample_for_github.Rmd : Initial exploration of muscle cells.

annotateCreateSubset.Rmd, annotateCreateSubset_withinTcells.Rmd :
Subset the data by cell-types. 



createSubset.R : Helper script for subsetting

GSE121364_Table_raw_counts_RNA_QSC.txt, sc_MT_Babraham_Blood_aging_Matrix.txt : Expression tables


annotations.csv, polycomb_mean_methylation_values_Bcells.txt, polycomb_mean_methylation_values_Tcells.txt :
Cell metadata annotation, and mean methylation values. 




