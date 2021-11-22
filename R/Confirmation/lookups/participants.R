#' create look ups for provincia

infile <- file.path(dir_prep_clean, "muva_follow_up_clean.xlsx")
exfile <- file.path(dir_conf_lookUps, "participants.xlsx")



names(c)
c <- import(infile) |>
 select(name = nome,
        sexo,
        projects = project,
        telefone,
        telefone2,
        ano_participacao) |>
  mutate(name = str_trim(name))



export(c, exfile, encoding= "UTF-8", overwrite = T)
