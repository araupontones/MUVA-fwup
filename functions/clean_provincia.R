
clean_provincia <- function(.data){
  
  .data %>%
    mutate(provincia = case_when(provincia %in% c("Maputo","Maputo Cidad", "Maputo cidade",
                                                  "Maputp Cidade","Maputp Cidade" ) ~ "Maputo Cidade",
                                 provincia %in% c("Maputo provincia") ~ "Maputo Provincia",
                                 provincia %in% c("Zambézia") ~ "Zambezia",
                                 T ~ provincia)
    )
}
