

clean_cidade2 <- function(.data){
  .data %>%
  mutate(cidade = str_trim(cidade),
         cidade = str_to_title(cidade),
         cidade = case_when(cidade ==  "Cidade De Maputo" ~  "Maputo",
                            cidade == "Maputo Cidade"  ~ "Maputo",
                            cidade == "Cidade De Pemba" ~ "Pemba", 
                            cidade == "Cidade De Matola" ~ "Matola",
                            cidade == "Cidade De Xai-Xai" ~ "Xai-Xai",
                            cidade == "Chokwe" ~ "Chokwé",
                            cidade == "Cidade De Quelimane" ~ "Quelimane",
                            cidade == "Cidade Da Beira" ~ "Beira",
                            cidade %in% c("Sofala",
                                          "Marracuene",
                                          "Maputo Provincia",
                                          "Boane", 
                                          "Limpopo",
                                          "Chongoene",
                                          "Matutuine") ~ NA_character_,
                            T ~ cidade))
  
}
