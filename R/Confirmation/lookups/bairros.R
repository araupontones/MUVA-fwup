infile <- file.path(dir_conf_lookUps, "cidades.xlsx")
infileManuel <- file.path(dir_data_ref, "Bairros_Manuel.xls")

infileProvs <- file.path(dir_conf_zoholookUps, "cidades_Report.xls")
exfile <- file.path(dir_conf_lookUps, "bairros.xlsx")

provs <- import(infileProvs)

bairros <- import(infileManuel) |>
  rename(cidade = Cidade) |>
  mutate(cidade = str_remove_all(cidade, "Cidade Da |Cidade De ")) |>
  group_by(cidade) |>
  mutate(count = n()) |>
  ungroup()|>
  filter(count >5) |>
  mutate(cidade = case_when(cidade == "Maputo Cidade" ~ "Maputo",
                            T ~ cidade)) |>
  filter(! cidade %in% c("Chiure",
                         "Marracuene",
                         "Namuno"))



lp <- bairros |>
  left_join(provs, by = c("cidade")) |>
  select(provincias,
         cidades =cidade,
         bairro = Bairro)




export(lp, exfile, overwrite = T, encoding = "UTF-8")
exfile
