#'utils QA
#'


#'define status of interview
#'@param x outcome variable
define_status <- function(x){
  
  
  revisitar <- c(2:4,10)
  concluida <- c(1,5:9, 11:13)
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



#'save clean data and removes drop interviews from rosters
#'@param clean_database clean data set
#'@param dir_clean directory to save the clean data
#'@param dir_raw directory where the raw data is stored

save_clean_data <- function(clean_database,
                            dir_clean,
                            dir_raw){
  
  #list stata files in raw folder
  raw_modules <- list.files(dir_raw, recursive = T, pattern = ".dta", full.names = T)
  
  for(module in raw_modules){
    
    #fetch file name
    stata_file <- str_extract(module, "[^\\/]+$")
    data_check <- select(clean_database, interview__key,status) #to join with modules
    
    if(!dir.exists(dir_clean)){
      
      dir.create(dir_clean)
    }
    
    #do not save interview diagonistcs nor actions
    if(!str_detect(stata_file, "interview__|_actions")){
      
      
      #save main questionnaire
      if(str_detect(module, paste0(survey, ".dta"))){
        
        message(stata_file)
        rio::export(clean_database, file.path(dir_clean, stata_file))
        
      } else{
        #drop deleted interviews from rosters
        
        data_module <- rio::import(module) %>%
          left_join(data_check, by = "interview__key") %>%
          filter(!is.na(status)) %>%
          select(-status)
        
        message(stata_file)
        rio::export(data_module, file.path(dir_clean, stata_file))      
      }
      
      
      
    }
    
    
    
  }
  
  cli::cli_alert_success(glue::glue("Data saved in {dir_clean}"))
  
}


#'clean data after supervisor's QA ---------------------------------------------
#'@param data_field data from the field (stored in raw folder)
#'@param drop_this vector of interview__keys to drop
#'@param force_approved_this vector with interview__keys to force approval

clean_data <- function(data_field,
                       drop_this,
                       force_approved_this){
  
  
  data_field %>%
    #drop interviews defined by data manager
    filter(! interview__key %in% drop_this) %>%
    #Mark as verificada interviews that the suepervisor has confirm are OK (though have errors)
    mutate(status = if_else(interview__key %in% force_approved_this, "VERIFICADA-FINAL", status)) %>%
    #check for duplicates
    group_by(ID_participant) %>%
    mutate(dup = n() >1) %>%
    ungroup() %>%
    mutate(reject = has__errors >0 | dup >0 | n_questions_unanswered >0,
           Management = case_when(status == "VERIFICADA-FINAL" ~ "APPROVED",
                                  !reject & str_detect(status, "FINAL") ~ "APPROVED",
                                  !reject & !str_detect(status, "FINAL") ~ "REVISITING",
                                  reject ~ "REJECTED")) %>%
    select(-reject) %>%
    relocate(starts_with("interview__"),ID_participant,participante,Management, 
             status, has__errors, n_questions_unanswered,dup,
             outcome,project, provincia, 
             cidade, bairro)
  
}



#' create data at the geo level for dashboard ---------------------------------------

#'@param database dashboard data base
#'@param by c("provincias", "cidades", "bairros)
#'@param dir_dashboard directory where data for dashboard is saved 

create_dashGeo <- function(database,
                           by,
                           dir_dashboard,
                        
                           ...){
  
  #Define infile to read sample summary for this unit
  infile2 <- function(geo){file.path("data/Follow-up/sample", glue::glue('Sampled_{geo}.rds'))}
  
  
  
  
  #read sample data for this unit
  sample_geo <- import(infile2(by))
  
  
  #define exfile
  exfile <- file.path(dir_dashboard, paste0("summary_", by,".csv"))
  
  
  
  #define group by parameters
  if(by == "provincias"){
    
    join_by <- "provincia"
    
  }
  
  if(by == "cidades"){
    
    join_by <- c("provincia", "cidade")
    
  }
  
  
  if(by == "bairros"){
    
    join_by <- c("provincia", "cidade", "bairro")
    
  }
  
  #vector of units for factor
  #factor_levels <- c(sort(unique(database[[level]])), "Total")
  
  #create data
  geo <- database %>% group_by(...) %>%
    #count status of interviews
    summarise(Visitadas = sum(resultado != "Sin visitar"),
              Revisitando = sum(Management == "REVISITING"),
              Completas = sum(str_detect(resultado, "Entrevista completa") & Management == "APPROVED" ),
              Rejected = sum(Management == "REJECTED"),
              `Sim visitar` = sum(Management == "Sin visitar"),
              Approved = sum(Management == "APPROVED"),
              .groups = 'drop') %>%
    #any approved that is not completa is not achieved
    mutate(`Nao conseguimos` = Approved - Completas, .after = Completas) %>%
    #join with summary of sample
    left_join(sample_geo, by = join_by) %>%
    janitor::adorn_totals("row", name = "Total") %>%
    mutate(status = case_when(Approved == sampled ~ "APPROVED",
                              Rejected >0 ~ "CHECK!",
                              `Sim visitar` == sampled ~ "INATIVO",
                              T ~ "ATIVO"
    ), .before = provincia) 
    
    
  
  
  #export  
  rio::export(geo, exfile)
  cli::cli_alert_success(paste("Dashboard data for", by, "Saved!"))
  return(geo)
}
