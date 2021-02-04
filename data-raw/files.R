require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
files <- get_synapse_tbl(syn, "syn9630847") %>% 
  dplyr::select(
    "id", "createdOn", "dataset", "assay", "Theme", "consortium", "grantName"
  ) %>% 
  dplyr::mutate(
    "accessType" = "PUBLIC"
  ) %>% 
  format_date_columns()
  
saveRDS(files, "files.RDS")
store_file_in_synapse(
  "files.RDS",
  "syn24172460"
)

  
  