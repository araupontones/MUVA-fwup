infile <- file.path(dir_conf_downloads, "confirmation_download.rds")
exfile <- file.path(dir_conf_clean, "confirmation_clean.rds")
exfile_count <- file.path(dir_conf_clean, "confirmation_summary.xlsx")


#import downloads --------------------------------------------------------------

dwls <- import(infile)

View(dwls)
#clean provincia, cidade, bairro ----------------------------------------------

d_loc <- dwls %>%
  filter(cidade != "") |>
  mutate(across(c(provincia, cidade, bairro), str_to_title),
         across(c(provincia, cidade, bairro), str_trim),
         cidade = str_remove_all(cidade, "Distrito De | Cidade"),
         cidade = str_replace(cidade, "Naamacha", "Namaacha"),
         cidade = str_replace(cidade, "Xai Xai", "Xai-Xai"),
         cidade = str_replace(cidade, "Matola Rio", "Matola"),
         cidade = case_when(provincia == "Maputo Provincia" & str_detect(bairro, "Liberdade|Matola|Matli") ~ "Matola",
                            T ~ cidade),
         
         provincia = case_when(cidade == "Beira" ~ "Sofala",
                               cidade == "Maputo" ~ "Maputo Cidade",
                               T ~ provincia),
         bairro = str_remove_all(bairro, "Bairro |Bairro Da | Bairro Das "),
         bairro = str_remove(bairro, "Da |Das |Do "),
         bairro = str_replace(bairro, "Chamaculo|Chamamculo", "Chamanculo"),
         bairro = str_replace(bairro, "Chamanculo  B", "Chamanculo B"),
         bairro = str_replace(bairro, "Aeoporto", "Aeroporto"),
         bairro = str_replace(bairro, "Alto Maé", "Alto Mae"),
         bairro = str_replace(bairro, "Bagamoyo", "Bagamoio"),
         bairro = case_when(bairro == "Aeroporto" ~ "Aeroporto A",
                            str_detect(bairro, "Bela Vista") ~ "Bela Vista",
                            bairro == "Central" & cidade == "Maputo" ~ "Central A",
                            bairro == "Hulene" & cidade == "Maputo" ~ "Hulene A",
                            T ~ bairro)
         
         )




#to fetch information from reference data --------------------------------------
infile_ref <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
ref <- import(infile_ref) |>
  mutate(nome = str_remove_all(nome, '"'),
         nome = str_replace(nome, "DIA\\.", "DIA"),
         nome = str_trim(nome)) |>
  select(participante = nome, 
         telefone_ref = telefone,
         telefone_ref_2 = telefone2)


d_phone <- d_loc |>
  left_join(ref, by = "participante")

View(d_phone)

names(d_phone)

setdiff(d_loc$participante, ref$participante)





#export --------------------------------------------------------------------------
d_summary <- d_loc |> group_by(provincia, cidade) |> summarise(confirmados = n()) |> mutate(enquerito = "")

export(d_summary, exfile_count, overwrite = T)



