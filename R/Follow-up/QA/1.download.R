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

susor_login(susor_server = "http://my.muvasurveys.com/",
            susor_user = "araupontones",
            susor_password = "Seguridad1",
            susor_dir_downloads = dir_downloads,
            susor_dir_raw = dir_raw,
            limit = 100,
            ofset = 2
)




#View(susor_questionnaires)

#NDT
susor_export_file(susor_qn_variable = "grandfollowup2022",
                  susor_qn_version = 3,
                  susor_format = "STATA"
                  )


susor_append_versions(susor_qn_variable = "grandfollowup2022",
                      susor_format = "STATA")


#get data from sample ---------------------------------------------------------
raw_file <- file.path(dir_raw, "grandfollowup2022/grandfollowup2022.dta")
raw_data <- rio::import(raw_file)


raw_data_sampled <- raw_data %>%
  mutate(ID_participant = as.character(ID_participant),
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
  select(-keep)

#t <- select(raw_data_sampled, ID_participant, outcome, dup, status,final_attemps, keep) %>% arrange(ID_participant)



export(raw_data_sampled, raw_file)
cli::cli_alert_success(glue::glue('Data saved in {dir_raw}'))
