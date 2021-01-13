require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
studies <- get_synapse_tbl(syn, "syn21918972")
saveRDS(studies, "studies.RDS")
store_file_in_synapse(
  "studies.RDS",
  "syn24172460"
)

