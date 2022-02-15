clean_cidade <- function(.data){
  
  .data %>%
    mutate(cidade = case_when(cidade %in% c("Beira") ~ "Cidade Da Beira",
                              cidade %in% c("Boane", "Distrito de Boane", "Distrito de Boane") ~ "Boane",
                              cidade %in% c("Chokwe") ~ "Chokwe",
                              cidade %in% c("Cidade de Maputo",
                                            "Maputo",
                                            "Maputo cidade") ~ "Maputo Cidade",
                              cidade %in% c("Limpopo") ~ "Limpopo",
                              cidade %in% c("Maputo provincia") ~ "Maputo Provincia",
                              cidade %in% c("Matola") ~ "Cidade Da Matola",
                              cidade %in% c("PEMBA") ~ "Cidade De Pemba",
                              cidade %in% c("Quelimane") ~ "Cidade De Quelimane",
                              cidade %in% c("Xai-xai") ~ "Cidade De Xai-Xai",
                              
                              
                              T ~ cidade)
    )
  
}