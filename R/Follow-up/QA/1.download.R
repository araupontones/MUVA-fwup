cli::cli_alert_info("Downloading data from from server")
library(httr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(rio)
library(susor)





#parameters are created in X.QA_System.


#download data ----------------------------------------------------------------

#login
susor_login(susor_server = "http://my.muvasurveys.com/",
            susor_user = "araupontones",
            susor_password = "Seguridad1",
            susor_dir_downloads = dir_downloads,
            susor_dir_raw = dir_raw,
            limit = 40,
            ofset = 1
)





#download
susor_export_file(susor_qn_variable = "grandfollowup2022",
                  susor_qn_version = 5,
                  susor_format = "STATA"
                  )

#download
susor_export_file(susor_qn_variable = "grandfollowup2022",
                  susor_qn_version = 6,
                  susor_format = "STATA"
)

#append version
susor_append_versions(susor_qn_variable = "grandfollowup2022",
                      susor_format = "STATA")


#get data from sample ---------------------------------------------------------
raw_file <- file.path(dir_raw, "grandfollowup2022/grandfollowup2022.dta")
raw_data <- rio::import(raw_file)



raw_data_sampled <- raw_data %>%
  mutate(ID_participant = as.character(ID_participant),
         url = glue('<a href="https://muva.mysurvey.solutions/Interview/Review/{interview__id}"target="_blank">Link</a>'),
         status = define_status(outcome)) %>%
  left_join(select(sample,
                   ID_participant = ID,
                   provincia,
                   cidade,
                   bairro,
                   quarteirao),
            by = "ID_participant") %>%
  group_by(ID_participant) %>%
  mutate(dup = n(),
         final_attemps = sum(str_detect(status, "FINAL"))) %>%
  ungroup() %>%
  #keep latest interviews or non duplicated, or without final outcome
  mutate(keep = dup >1 & str_detect(status, "FINAL") | (dup ==1) |(dup >1 & final_attemps == 0)) %>%
  filter(keep) %>%
  group_by(ID_participant) %>%
  mutate(dup = n()>1) %>%
  ungroup() %>%
  arrange(ID_participant) %>%
  select(-keep) %>%
  #fix error of roster shocks (enabling condition not working)
  rowwise() %>%
  mutate(total_shocks = sum(c_across(starts_with("shock_faced__")), na.rm = T),
         total_severe = sum(c_across(starts_with("shock_severe__")), na.rm = T),
         n_questions_unanswered = if_else(n_questions_unanswered == 1 & (total_shocks == 0 & total_severe == 0), 
                                           n_questions_unanswered - 1,
                                           n_questions_unanswered)) %>%
  ungroup()






#t <- select(raw_data_sampled, ID_participant, outcome, dup, status,final_attemps, keep) %>% arrange(ID_participant)


export(raw_data_sampled, raw_file)

cli::cli_alert_success(glue::glue('Data saved in {dir_raw}'))
