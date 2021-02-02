require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
tools <- get_synapse_tbl(syn, "syn21930566")
saveRDS(tools, "tools.RDS")
store_file_in_synapse(
  "tools.RDS",
  "syn24172460"
)

