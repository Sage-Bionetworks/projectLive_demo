require(magrittr)
devtools::load_all()
syn <- create_synapse_login()
csbc_publications <-
  get_synapse_tbl(
    syn,
    "syn21868591",
    columns = c(
      "grantName",
      "publicationId",
      "publicationYear",
      "tissue",
      "theme"
    )
  ) %>%
  dplyr::mutate(
    "publicationYear" = as.factor(.data$publicationYear)
  )
store_file_in_synapse(
  "pubs.RDS",
  "syn24172460"
)
