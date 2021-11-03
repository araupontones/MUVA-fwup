#clean variable classe

clean_classe <- function(.data, var){
  db = .data %>%
    mutate(escolaridade = str_trim(escolaridade),
           escolaridade = str_replace(escolaridade, "ª|º", ""),
           escolaridade = str_to_sentence(escolaridade),
           escolaridade = str_replace(escolaridade,"Basico|Básico|1 tec basico|2 ano, instituto basico", "Técnico basico" ),
           escolaridade = str_replace(escolaridade,"Superior", "Técnico superior" ),
           
           
    )
  
  
  for(i in c(1:10)){
    
    
    search_this <- glue("{i}$|{i}a$|{i} $|{i}classe|{i}a classe")
    change_for_this <- paste(i, "classe")
    db <- db |>
      mutate( escolaridade = str_replace({{var}}, search_this, change_for_this))
    
  }
  
  db2 <- db |>
    mutate(escolaridade = str_replace(escolaridade, "8 classe - 10 classe", "8 classe"),
           escolaridade = str_replace(escolaridade, "11 classe - 12 classe", "11 classe"),
           escolaridade = str_replace(escolaridade, "Médio", "Técnico médio"),
           escolaridade = case_when(escolaridade == ".A" ~ NA_character_,
                                    T ~ escolaridade)
    ) |>
    mutate(escolaridade = str_replace(escolaridade, "11 classe \\(ou equivalente\\)", "11 classe"),
           escolaridade = str_replace(escolaridade, "Tecnico basico\\/10 classe", "10 classe"),
           escolaridade = str_replace(escolaridade, "Tecnico medio\\/12 classe|Técnico médio profissional", "Técnico médio"),
           escolaridade = str_replace(escolaridade, "Menos que 10 classe", "9 classe"),
           escolaridade = str_replace(escolaridade, "Cadeiras concluidas excepto monografia", "Licenciado"),
           
           escolaridade = factor(escolaridade,
                                 levels = c(0,
                                            paste(c(1:12), "classe"),
                                            "Técnico basico",
                                            "Técnico médio",
                                            "Técnico superior",
                                            "Licenciado"
                                 ))
                                            
           
           )
           
  
  return(db2)
  
}

