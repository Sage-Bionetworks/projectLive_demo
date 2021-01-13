require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
studies <- get_synapse_tbl(syn, "syn21918972") %>% 
  dplyr::select("grantId", "grantType")
datasets <-  get_synapse_tbl(syn, "syn21889931") %>% 
  dplyr::select("id", "createdOn")
files <- get_synapse_tbl(syn, "syn21897968") %>% 
  dplyr::mutate(
    "accessType" = "PUBLIC",
    # "assay" = purrr::map_chr(.data$assay, purrr::pluck, 1),
    # "theme" = purrr::map_chr(.data$theme, purrr::pluck, 1),
    "grantId" = purrr::map_chr(.data$grantId, purrr::pluck, 1)
  ) %>% 
  dplyr::left_join(studies) %>% 
  dplyr::left_join(datasets, by = c("datasetId" = "id")) %>% 
  format_date_columns()
  

saveRDS(files, "files.RDS")
store_file_in_synapse(
  "files.RDS",
  "syn24172460"
)

  
  