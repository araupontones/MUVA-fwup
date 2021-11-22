infile <- file.path(dir_data_ref, "worldCities.csv")
exfile <- file.path(dir_data_ref, "cidades.xlsx")

wc <- import(infile, encoding = "UTF-8")


c <- wc |>
  filter(country == "Mozambique") |>
  rename(cidade = city,
         provincia = admin_name) |>
  select(provincia, cidade, lat, lng)



export(c, exfile, encoding = "UTF-8")
