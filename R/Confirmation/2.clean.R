infile <- file.path(dir_conf_downloads, "confirmation_download.rds")
exfile <- file.path(dir_conf_clean, "confirmation_clean.rds")
exfile_count <- file.path(dir_conf_clean, "confirmation_summary.xlsx")


#import downloads --------------------------------------------------------------

dwls <- import(infile)


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
                            T ~ bairro),
         
         across(c(telefone1, telefone2), function(x)str_remove(x, "\\+258")),
         across(c(telefone1, telefone2), function(x)beauty_telefone(x)),
         
         #Beira
         
         
         
         #Gaza 
         bairro = case_when(#Beira,
           
           cidade == "Beira" & bairro == "Inhamisa" ~ "Inhamiza",
           cidade == "Beira" & bairro == "Chipangara" ~ "Chipangara 1",
           cidade == "Beira" & bairro == "Segundo Chipangara" ~ "Chipangara 2",
           
           #cidade == "Beira" & bairro == "10 Munhava" ~ "Decimo Munhava",
          
           #cidade == "Beira" & bairro == "Mananga" ~ "Malanga",
          
           
           cidade == "Beira" & str_detect(bairro,"2 Chipangara") ~ "Chipangara 2",
           cidade == "Beira" & str_detect(bairro,"Mananga|Malanga") ~ "Malanga",
           
           cidade == "Beira" & str_detect(bairro,"Manga") ~ "Manga",
           cidade == "Beira" & str_detect(bairro,"Macurrungo|Macurungo|Macurunga") ~ "Macurungo",
           cidade == "Beira" & str_detect(bairro,"Chimpangara|Xipandara|Chicangara|Chipagara|Chipangara Palmeiras") ~ "Chipangara 2",
           cidade == "Beira" & str_detect(bairro,"Goto") ~ "Goto",
           cidade == "Beira" & str_detect(bairro,"Nhamiza|Nhamizwa") ~ "Nhamissa",
           cidade == "Beira" & str_detect(bairro,"Munhava")  ~ "Munhava",
           cidade == "Beira" & str_detect(bairro,"Mataquane")  ~ "Mataquane",
           cidade == "Beira" & str_detect(bairro,"Chota")  ~ "Chota",
           cidade == "Beira" & str_detect(bairro,"Namataga")  ~ "Nhamatanda",
           cidade == "Beira" & str_detect(bairro,"Pontagea")  ~ "Pontageia",
           cidade == "Beira" & str_detect(bairro,"Marrava")  ~ "Marrava",
           
           
          

           
           
           #Gaza
           cidade == "Chokwé" & str_detect(bairro,"Terceiro") ~ "Terceiro Bairro",
           cidade == "Chokwé" & str_detect(bairro,"4|Quarto") ~ "Quarto Bairro",
           cidade == "Chokwé" & str_detect(bairro,"5|Quinto|Quito") ~ "Quinto Bairro",
           cidade == "Chokwé" & str_detect(bairro,"6") ~ "Sexto Bairro",
           
           cidade == "Chonguene" & str_detect(bairro,"Fidel") ~ "Fidel Castro",
           cidade == "Chonguene" & str_detect(bairro,"Nho") ~ "Nhoquene",
           cidade == "Chonguene" & str_detect(bairro,"Bango") ~ "Bango",
           cidade == "Chonguene" & str_detect(bairro,"2") ~ "Segundo Bairro",
           cidade == "Chonguene" & str_detect(bairro,"3") ~ "Terceiro Bairro",
           
           cidade == "Xai-Xai" & str_detect(bairro,"Castro") ~ "Fidel Castro",
           cidade == "Xai-Xai" & str_detect(bairro,"Choguene|Choeguene|Chogoen|Chonguene") ~ "Chonguene",
           cidade == "Xai-Xai" & str_detect(bairro,"Patrice") ~ "Patrice Lumumba",
           cidade == "Xai-Xai" & str_detect(bairro,"Bango") ~ "Bango",
           cidade == "Xai-Xai" & str_detect(bairro,"Chilequene") ~ "Chilenguene",
           cidade == "Xai-Xai" & str_detect(bairro,"Ngulelene|Ngangalene") ~ "Ngulelene",
           cidade == "Xai-Xai" & str_detect(bairro,"2000") ~ "2000",
           cidade == "Xai-Xai" & str_detect(bairro,"Chissano") ~ "Chissano",
           cidade == "Xai-Xai" & bairro == "1" ~ "Primeiro Bairro",
           cidade == "Xai-Xai" & bairro == "3 Bairo" ~ "Terceiro Bairro",
           
           cidade == "Limpopo" & str_detect(bairro,"Chissano") ~ "Chissano",
           
           
           provincia == "Maputo Cidade" & str_detect(bairro,"Polana Canico A") ~ "Polana Caniço A",
           provincia == "Maputo Cidade" & str_detect(bairro,"Polana Canico B") ~ "Polana Caniço B",
           provincia == "Maputo Cidade" & str_detect(bairro,"Matutuine") ~ "Matutuine",
           provincia == "Maputo Cidade" & str_detect(bairro,"Nhagoi") ~ "Nhagoi",
           provincia == "Maputo Cidade" & str_detect(bairro,"Urbanizacao") ~ "Urbanização",
           provincia == "Maputo Cidade" & str_detect(bairro,"Unidade") ~ "Unidade",
           provincia == "Maputo Cidade" & bairro == "Maxaquene" ~ "Maxaquene A",
           provincia == "Maputo Cidade" & bairro == "Magoanine" ~ "Magoanine A",
           
           
           provincia == "Maputo Provincia" & str_detect(bairro,"Mahubo") ~ "Mahubo",
           provincia == "Maputo Provincia" & str_detect(bairro,"Goba") ~ "Goba",
           provincia == "Maputo Provincia" & str_detect(bairro,"Mahelane|Mahaelani") ~ "Mahelane",
           provincia == "Maputo Provincia" & str_detect(bairro,"Liberdade") ~ "Liberdade",
           provincia == "Maputo Provincia" & str_detect(bairro,"Maelane") ~ "Mahelane",
           provincia == "Maputo Provincia" & str_detect(bairro,"Cobe") ~ "Khobe",
           provincia == "Maputo Provincia" & str_detect(bairro,"Infulene") ~ "Infulene",
           provincia == "Maputo Provincia" & str_detect(bairro,"Machava") ~ "Machava",
           provincia == "Maputo Provincia" & str_detect(bairro,"Matleme") ~ "Matlhemele",
           provincia == "Maputo Provincia" & str_detect(bairro,"Mualaze") ~ "Muhalaze",
           
           
           provincia == "Maputo Provincia" & bairro == "Matola" ~ "Matola A",
           provincia == "Maputo Provincia" & bairro == "Matola 700" ~ "Matola A",
           
           
           provincia == "Maputo Provincia" & bairro == "1" ~ "Primero Bairro",
           provincia == "Maputo Provincia" & bairro == "2" ~ "Segundo Bairro",
           provincia == "Maputo Provincia" & bairro == "7" ~ "Bairro 7",
           provincia == "Maputo Provincia" & bairro == "B" ~ "Bairro B",
           provincia == "Maputo Provincia" & bairro == "13" ~ "Bairro 13",
           provincia == "Maputo Provincia" & bairro == "F" ~ "Bairro F",
           
           
           bairro == "" ~ "Sem Bairro",
           
           T ~ bairro)
         
         
  ) |>
  mutate(provincia = case_when(cidade == "Mahotas" ~ "Maputo Cidade",
                               bairro == "2 Chicumbane" ~ "Gaza",
                               T ~ provincia),
         bairro = case_when(cidade == "Mahotas" ~ "Mahotas",
                            T ~ bairro),
         cidade = case_when(cidade == "Mahotas" ~ "Maputo",
                            bairro == "2 Chicumbane" ~ "Xai-Xai",
                            T ~ cidade)
  ) %>%
  distinct()






#d_loc |> tabyl(bairro)

#to fetch information from reference data --------------------------------------
infile_ref <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
ref <- import(infile_ref) |>
  mutate(nome = str_remove_all(nome, '"'),
         nome = str_replace(nome, "DIA\\.", "DIA"),
         nome = str_trim(nome)) |>
  select(participante = nome,
         sexo,
         telefone_ref = telefone,
         telefone_ref_2 = telefone2)




d_phone <- d_loc |>
  left_join(ref, by = "participante") |>
  mutate(telefone1 = case_when(is.na(telefone1) ~ telefone_ref,
                               T ~ telefone1)) %>%
  select(-matches("ref")) %>%
  relocate(sexo, .after = "participante")









#export --------------------------------------------------------------------------

export(d_phone, exfile)

d_summary <- d_loc |> group_by(provincia, cidade) |> summarise(confirmados = n()) |> mutate(enquerito = "")
export(d_summary, exfile_count, overwrite = T)



