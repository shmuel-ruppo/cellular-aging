createSubset <- function(mat, cell_names, metadata=NULL, min.genes = 0, min.cells = 0, project = "SeuratProject") {
  
  # Check that the cell names correspond to the column names of the matrix
  if(! all(cell_names %in% colnames(mat)))
    stop("Matrix does not include all of the cell names in its columns!")

  # If metadata should be used - check whether it exists for all the selected cells
  if(!is.null(metadata)) {
    if( sum( cell_names %in% rownames(metadata)) != length(cell_names))
      stop("Not all cell names have metadata attached")
    
    metadata <- metadata[cell_names,]
  }
  
  
  # Subset the matrix based on the cell names passed
  mat_subset <- mat[, cell_names]
  
  # Print a message informing of min genes used, and min cells used
  print(paste("With min.genes =", min.genes, ",min.cells=", min.cells))
  
  # Create a Seurat object
  sObj <- CreateSeuratObject(counts = mat_subset, meta.data=metadata, min.cells = min.cells, min.features = min.genes, project = project)
  
  # We store the very initial raw data in misc 
  sObj@misc$orig_count <- mat
  
  
  # sObj <- AddMetaData(sObj, sObj@meta.data$nCount_RNA, "nUMI")
  # sObj <- AddMetaData(sObj, sObj@meta.data$nFeature_RNA, "nGene")
  
  # Create an additional slot for backward compatability of Seurat v5 with Seurat v3
  # Changing the key is done to avoid a warning of key incompatability
  # RNA <- sObj[["RNA"]]
  # Key(RNA) <- "rna3_"
  # sObj[["RNA3"]] <- as(object = RNA, Class = "Assay")
  
  
  sObj <-  SCTransform(sObj, vst.flavor = "v2", verbose = FALSE)
  
  return(sObj)

}
