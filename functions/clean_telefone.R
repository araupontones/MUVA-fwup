
clean_telefone <- function(.data){
  .data %>%
    mutate(
      #The two telefones came separatate by a slash
      telefone_1 = case_when(telefone_1 == "##N/A##" ~ "Sem contacto",
                             telefone_1 == "sem contacto" ~ "Sem contacto",
                             is.na(telefone_1) ~ "Sem contacto",
                             T ~ telefone_1), 
      telefone_1 = str_replace(telefone_1, "Famicha", ""),
      telefone_1 = str_replace_all(telefone_1, "-", ""),
      
      telefone = case_when(!str_detect(telefone_1, "\\/") ~ telefone_1,
                           str_detect(telefone_1, "\\/") ~ str_extract(telefone_1 , "(?<=^).*(?=\\/)" )
      ),
      
      telefone2 = str_extract(telefone_1, "(?<=\\/).*(?=$)"),
      across(c(telefone, telefone2), beauty_telefone),
      telefone = case_when(str_detect(telefone, "Sem") ~ "Sem Contacto",
                           T ~ telefone)
    ) 
}



beauty_telefone <- function(str){
  
  case_when( !is.na(str) ~  as.character(glue("{str_sub(str, 1,3)}-{str_sub(str, 4,6)}-{str_sub(str, 7,10)}")),
             T ~ NA_character_)
  
  
}