
#Download data -------------------------------------------------------------------
run_file <- function(fichero){file.path("R/follow-up/QA", glue::glue("{fichero}.R"))}
survey <- "grandfollowup2022"
source(run_file("0.Define_paths"))
source(run_file("1.download"))




#read main questionaire -------------------------------------------------------

field_data <- rio::import(get_file2(dir_raw, survey))





drop_interviews <- c(
  
  "17-23-36-51"
  
  
)





#clean data -------------------------------------------------------------------
clean_data <- field_data %>%
  filter(! interview__key %in% drop_interviews) %>%
  group_by(ID_participant) %>%
  mutate(dup = n() >1)



#drop interviews in rosters --------------------------------------------


#export clean ---------------------------------------------------------






#data for dashboard ---------------------------------------------------------
dashboard_data <- clean_data %>% 
  mutate(resultado = susor::susor_get_stata_labels(outcome))%>%
  select(interview__key, ID_participant, provincia, 
         cidade, bairro, resultado, has__errors, 
         unanswered = n_questions_unanswered,
         duplicated = dup, 
         duration = interview__duration,
         date, time, url, status) %>%
  mutate(reject = has__errors >0 | duplicated >0 | unanswered >0,
         Management = case_when(!reject & str_detect(status, "FINAL") ~ "APPROVED",
                                       !reject & !str_detect(status, "FINAL") ~ "REVISITING",
                                       reject ~ "REJECT")) %>%
  select(-reject)










