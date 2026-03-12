To prepare the data, run first _sc_Blood_1sample_NEW_for_github.Rmd_ and  _sc_Muscle_1sample_for_github.Rmd_. Then annotate and subset with _annotateCreateSubset.Rmd_ and  _annotateCreateSubset_withinTcells.Rmd_


Files description:


_sc_MT_Babraham_Blood_aging_Matrix.txt_: Initial data matrix.

_sc_Blood_1sample_NEW_for_github.Rmd_: Initial exploration and cluster annotation.

_sc_Muscle_1sample_for_github.Rmd_: Initial exploration of muscle cells.

_annotateCreateSubset.Rmd_, _annotateCreateSubset_withinTcells.Rmd_ :
Subset the data by cell-types. 



_createSubset.R_ : Helper script for subsetting

_sc_MT_Babraham_Blood_aging_Matrix.txt_: Expression table


_annotations.csv_, _polycomb_mean_methylation_values_Bcells.txt_, _polycomb_mean_methylation_values_Tcells.txt_ :
Cell metadata annotation, and mean methylation values. 




