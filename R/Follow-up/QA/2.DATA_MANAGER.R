
#Download data -------------------------------------------------------------------
run_file <- function(fichero){file.path("R/Follow-up/QA", glue::glue("{fichero}.R"))}
survey <- "grandfollowup2022" #defines name of main questionnaire
source(run_file("0.Define_paths")) #defines key paths and paramenters
source(run_file("1.download")) #downloads, appends versions and creates raw data




#read main questionaire -------------------------------------------------------

field_data <- rio::import(get_file2(dir_raw, survey))


#inteerviews to be dropped: duplicates, etc. ----------------------------------
drop_interviews <- c(
  
  "17-23-36-51",
  "30-12-12-10"
  
  
)


# interviews with errors but that have been confirmed by supervisor
force_approve <- c(
  
  "73-54-31-64",
  "84-63-06-88",
  "95-82-56-77"
  
)







#==============================================================================
#drop interviews indicated by data manager,
#force to approve if data manager indicates to do so
# drops redundant interviews from roster
# saves clean data in clean folder
# Creates status and management variables for all the interviews and for geo units (province, cidades, bairro)
#exports data to dashboard folder (interviews, summary_bairros, summary_provincias, summary_cidades)


source(run_file("3.clean_and_exort_data_dashboard"))










