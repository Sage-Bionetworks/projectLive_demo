require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
pubs <- get_synapse_tbl(syn, "syn21868591")
saveRDS(pubs, "pubs.RDS")
store_file_in_synapse(
  "pubs.RDS",
  "syn24172460"
)
