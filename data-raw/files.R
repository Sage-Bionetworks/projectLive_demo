get_created_on_year <- function(syn_id, syn){
  e <- syn$get(syn_id)
  e$get("createdOn") %>% 
    stringr::str_sub(., end = 4) %>% 
    as.integer()
}

require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
studies <- get_synapse_tbl(syn, "syn21918972") %>% 
  dplyr::select("grantId", "grantType")
files <- get_synapse_tbl(syn, "syn21897968") %>% 
  dplyr::mutate(
    "accessType" = "PUBLIC",
    # "year" = purrr::map_int(.data$datasetId, get_created_on_year, syn)
    "year" = 2020,
    "assay" = purrr::map_chr(.data$assay, purrr::pluck, 1),
    "theme" = purrr::map_chr(.data$theme, purrr::pluck, 1),
    "grantId" = purrr::map_chr(.data$grantId, purrr::pluck, 1)
  ) %>% 
  dplyr::left_join(studies)

saveRDS(files, "files.RDS")
store_file_in_synapse(
  "files.RDS",
  "syn24172460"
)

  
  