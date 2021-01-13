require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
files <- get_synapse_tbl(syn, "syn21897968")

saveRDS(files, "files.RDS")
store_file_in_synapse(
  "files.RDS",
  "syn24172460"
)

