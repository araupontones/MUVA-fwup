#clean data of sonho rural using file given by Andre
#The reference document is confirmatio_clean.rds created during the confirmation of the call center



#import files ------------------------------------------------------------------
infile_SR <- file.path(dir_conf_downloads,"Sonho_Rural_Sample.xlsx")
infile_confirmation <- file.path(dir_conf_clean, "confirmation_clean.rds")


exfile <- file.path(dir_conf_clean,"Sonho_Rural_Extra_Sample.rds")


raw_sr <- import(infile_SR)
conf <- import(infile_confirmation)


#===============================================================================

conf_ref <- conf %>%
  filter(project == "Sonho Rural") %>%
  select(project, participante)



sr <- raw_sr %>%
  select(provincia = Provincia,
         cidade = Distrito,
         bairro = Comunidade,
         participante = Nome_participante) %>%
  mutate(participante = str_to_upper(participante)) %>%
  mutate(participante = str_replace(participante, "LEOPORDINA DOMINGOS VICTOR SANDRAMO NGOMA", "LEOPORDINA DOMINGOS")) %>%
  left_join(conf_ref, by = "participante") %>%
  ##keep those who've not been included in the final sample --------------------
  filter(is.na(project)) %>%
  mutate(project = "Sonho Rural") %>%
  #clean provincia
  mutate(provincia = str_replace(provincia, "Maputo", "Maputo Provincia")) %>%
  #clean cidade
  mutate(cidade = str_replace(cidade, "Chokwe", "Chokwé"),
         cidade = str_replace(cidade, "Xai-xai", "Xai-Xai"),
         cidade = str_replace(cidade, "Chongoene", "Chonguene")
         ) %>%
  #clean bairro
  mutate(bairro ="Sonho Rural") 
  

export(sr, exfile)



