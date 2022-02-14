#'utils QA
#'


#'define status of interview
#'@param x outcome variable
define_status <- function(x){
  
  
  revisitar <- c(1:4,10)
  concluida <- c(5:9, 11:13)
  completa <- 13
  incompleta_final <- 11
  nao_conseguimos <- concluida[-which(concluida %in% c(completa, incompleta_final))]
  
  case_when(x %in% revisitar ~ "REVISITAR",
            x == incompleta_final ~ "INCOMPLETA-FINAL",
            x %in% nao_conseguimos ~ "NAO CONSEGUIMOS-FINAL",
            x == completa ~ "COMPLETA-FINAL")
  
}



#
#get module from raw dir
get_file2 <- function(dir_raw,module){
  
  file.path(dir_raw, survey, glue::glue('{module}.dta'))
  
}

#create path to clean file
clean_path <- function(dir_clean,module){
  
  file.path(dir_clean, glue::glue('{module}.dta'))
} 
