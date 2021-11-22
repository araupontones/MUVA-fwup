#' create look ups for provincia

infile <- file.path(dir_data_ref, "cidades.xlsx")
exfile <- file.path(dir_conf_lookUps, "provincias.xlsx")

c <- import(infile)


p <- c |>
  mutate(provincia = case_when( cidade == "Maputo" ~ "Maputo Cidade",
                              provincia == "Maputo" ~ "Maputo Provincia",
                               T ~ provincia
                               )) |>
  group_by(provincia) |>
  slice(1) |>
  filter(!is.na(provincia)) |>
  arrange(provincia) |>
  ungroup() |>
  select(provincia)



export(p, exfile)

unique(c$cidade)
