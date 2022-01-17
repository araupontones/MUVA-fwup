infile <- file.path(dir_conf_clean, "confirmation_clean.rds")
exfile <- file.path(dir_fp_sample, "sample.rds")
exsummary <- file.path(dir_fp_sample, "respondents_by_city.xlsx")



#import data -------------------------------------------------------------------

conf <- import(infile)



#Keep targeted locations --------------------------------------------------------

target <- conf %>%
  mutate(target = case_when(provincia == "Cabo Delgado" & cidade %in% c("Pemba") ~ TRUE,
                            provincia == "Gaza" ~ TRUE,
                            provincia == "Maputo Cidade" ~ TRUE,
                            provincia == "Maputo Provincia" ~ TRUE,
                            provincia == "Sofala" & cidade %in% c("Beira") ~ TRUE,
                            provincia == "Zambézia" ~ TRUE,
                            T ~ FALSE
                            )
         ) %>%
  filter(target)



target |> tabyl(cidade)
target |> filter(provincia == "Maputo Provincia") |> tabyl(cidade)



View(dups)

#Create IDs --------------------------------------------------------------------






ids <- target %>% 
  create_ids(geo = "provincia") %>%
  create_ids(geo = "cidade", higher_level = "provincia") %>%
  create_ids(geo = "bairro", higher_level = "cidade") %>%
  create_ids(geo = "participante", higher_level = "bairro") %>%
  relocate(provincia, ID_provincia, cidade, ID_cidade, bairro, ID_bairro, ID_participante) %>%
  arrange(provincia, cidade, bairro, participante) %>%
  mutate(across(c(ID_cidade, ID_bairro, ID_participante), function(x)case_when(str_length(x) == 1 ~ paste0("0", x),
                                                                  T ~ as.character(x))),
         ID = paste0(ID_provincia, ID_cidade, ID_bairro, ID_participante)) %>%
  relocate(ID)


#View(ids)

#dups <- ids |> get_dupes(ID)
  




#export --------------------------------------------------------------------------
exfile
export(ids, exfile)


#count records by cidade,

ids |> group_by(provincia, cidade) |> summarise(total = n()) %>% export(., exsummary, overwrite = T)
