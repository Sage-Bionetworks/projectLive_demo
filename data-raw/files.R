require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
studies <- 
  projectlive.modules::get_synapse_tbl(
    syn, 
    "syn21918972",
    columns = c(
      "grantName",
      "theme"
    )
  ) %>% 
  dplyr::select(-c("ROW_ID", "ROW_VERSION"))

files <-
  projectlive.modules::get_synapse_tbl(
    syn,
    "syn9630847",
    columns = c(
      "id",
      "assay",
      "diagnosis",
      "tumorType",
      "species",
      "grantName",
      "createdOn",
      "consortium",
      "organ",
      "experimentalStrategy"
    )
  ) %>%
  format_date_columns() %>%
  dplyr::select(-c("createdOn", "ROW_ID", "ROW_VERSION", "ROW_ETAG")) %>%
  dplyr::mutate( "accessType" = "PUBLIC") %>% 
  dplyr::left_join(studies, by = "grantName")
  
saveRDS(files, "files.RDS")
store_file_in_synapse(
  "files.RDS",
  "syn24172460"
)

  
  