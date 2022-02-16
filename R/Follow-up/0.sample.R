infile <- file.path(dir_conf_clean, "confirmation_clean.rds")
infile_sonho_rural <- file.path(dir_conf_clean,"Sonho_Rural_Extra_Sample.rds") #extra sample of sonho rural
exfile <- file.path(dir_fp_sample, "sample.rds")
exsummary <- file.path(dir_fp_sample, "respondents_by_city.xlsx")
exbairros <- file.path(db_design, "ista_dos_bairros.xlsx")



#import data -------------------------------------------------------------------

conf <- import(infile)
sonho_rural <- import(infile_sonho_rural)


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





##append sonho rural ----------------------------------------------------------

target_plus_sonho <- target %>%
  plyr::rbind.fill(sonho_rural)


#Create IDs --------------------------------------------------------------------





ids <- target_plus_sonho %>% 
  create_ids(geo = "provincia") %>%
  create_ids(geo = "cidade", higher_level = "provincia") %>%
  create_ids(geo = "bairro", higher_level = "cidade") %>%
  arrange(provincia, cidade, bairro, quarteirao, participante) %>%
  group_by(provincia, cidade) %>%
  mutate(ID_participante = row_number(),
         ID_participante = case_when(ID_participante < 10 ~  paste0("00", ID_participante),
                                     between(ID_participante,10,99) ~  paste0("0", ID_participante),
                                     ID_participante >99 ~ as.character(ID_participante)
                                     )) %>%
  ungroup() %>%
  #create_ids(geo = "participante", higher_level = "bairro") %>%
  relocate(provincia, ID_provincia, cidade, ID_cidade, bairro, ID_bairro, ID_participante) %>%
  #arrange(provincia, cidade, bairro, participante) %>%
  mutate(across(c(ID_cidade, ID_bairro, ID_participante), function(x)case_when(str_length(x) == 1 ~ paste0("0", x),
                                                                               T ~ as.character(x))),
         ID = paste0(ID_provincia, ID_cidade, ID_participante)) %>%
  relocate(ID) %>%
  relocate(quarteirao, .after = bairro)


#View(ids)

dups <- ids %>% get_dupes(ID)



#export --------------------------------------------------------------------------

export(ids, exfile)

#count records by cidade,
# 
# ids %>% group_by(provincia, cidade) %>% summarise(total = n()) %>% export(., exsummary, overwrite = T)
# View(ids)
# names(ids)
# #lista dos bairros --------------------------------------------------------
# bairros <- ids %>% group_by(cidade, bairro) %>% summarise(participantes = n())
# 
# View(bairros)
# 
# 
# cidades <- unique(bairros[["cidade"]])
# 
# hs <- openxlsx::createStyle(
#   textDecoration = "BOLD", fontColour = "#FFFFFF", fontSize = 12,
#   fontName = "Arial Narrow", fgFill = "#4F80BD"
# )
# 
# 
# for( i in 1:length(cidades)){
# 
#   selected = cidades[i]
# 
# 
#   data_export <- bairros %>% filter(cidade == selected)
# 
#   exfile <- file.path(db_design,"check lista bairros",glue("lista_bairros_{selected}.xlsx"))
# 
# 
#   export(data_export, exfile, sheetName = selected, colWidths = c("22", "22", "11"), headerStyle = hs,
#          overwrite = T,  borders = "all", gridLines = FALSE)
# 
# 
# }
