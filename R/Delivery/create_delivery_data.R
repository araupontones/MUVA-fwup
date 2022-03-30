#paths define in .Rprofile
#' Input: clean data from the survey field work
#' Output: delivery data (only approved files)
#' data is imported from dir_fp_clean
#' The imported data is created in R/Follow-up/QA/3.clean_and_exort_data_dashboard.R
#' exported to dir_delivery




#i. confirm that there are no duplicates ---------------------------------------
main <- import(file.path(dir_fp_clean, "grandfollowup2022.dta"))

duplicates <- main %>% get_dupes(ID_participant) %>% select(ID_participant, outcome, status)



#ii. Remove the management variables and relocate variables to improve browsing
main_clean <- main %>%
  select(-c(url, last_action,time, link, date,entities__errors,
            questions__comments,rejections__hq, rejections__sup,
            sssys_irnd, concatPart, concatProj, interviewers,
            interview__id, interview__status,
            has__errors, n_questions_unanswered, interview__duration,
            inquiridor, responsible
            )) %>%
  mutate(outcome = susor::susor_get_stata_labels(outcome)) %>%
  relocate(interview__key, ID_participant, participante, project,status, Management, final_attemps) %>%
  rename(Field_Management = Management,
         Status_field = status,
         Attempts = final_attemps) %>%
  filter(Field_Management == "APPROVED")




#iii. drop redundant interviews in rosters and save-------------------------------------


#list of clean files
clean_files <- list.files(dir_fp_clean, full.names = T)
#identify main file
main_file <- which(str_detect(clean_files, "grandfollowup"))
#roster files
roster_files <- clean_files[-main_file]

#main files with ids to share with the rosters
main_ids <- main_clean %>% select(interview__key, ID_participant)


#Fetch ID_participant to each roster, drop redundant observations, and save

clean_rosters <- lapply(roster_files, function(roster){
  
  #get name of stata file
  stata_file <- str_extract(roster, "[^\\/]+$")
  message(stata_file)
  
  #import clean roster
  clean_roster <- import(roster)
  print(paste("rows before join:",nrow(clean_roster)))
  
  #get IDs from main questionnaire and drop redundant interviews
  # drop those that were removed from the main file
  roster_ids <- clean_roster %>% left_join(main_ids, by = "interview__key") %>%
    filter(!is.na(ID_participant))
  
  
  print(paste("rows after join:",nrow(roster_ids)))
  
  #save to delivery
  
  rio::export(roster_ids, file.path(dir_delivery, stata_file))
  rio::export(roster_ids, file.path(db_data_delivery, stata_file)) #dropbox
  
  
  
  
})



#iv. Save main file -----------------------------------------------------------

rio::export(main_clean, file.path(dir_delivery, "grandfollowup2022.dta"))
rio::export(main_clean, file.path(db_data_delivery, "grandfollowup2022.dta"))








