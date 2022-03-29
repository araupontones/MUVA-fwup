
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
  "88-67-25-34",
  "99-42-96-45",
  "47-22-74-74",
  "08-03-42-28",
  "54-00-63-51",
  "43-15-77-79",
  "09-72-98-62",
  "84-66-95-02",
  "37-47-75-71",
  "66-54-88-50",
  "02-43-02-03",
  "11-77-41-46",
  "40-49-40-85",
  "60-89-74-42",
  "36-74-02-22",
  "99-74-86-29",
  "73-10-09-06",
  "87-49-52-98",
  "18-11-70-84",
  "33-79-59-63",
  "06-44-96-26",
  "04-19-09-47",
  "24-96-31-47",
  "56-69-62-77",
  "73-63-34-30",
  "30-89-11-31",
  "52-42-16-93",
  "14-67-00-32",
  "80-68-56-76",
  "88-43-43-23",
  "51-66-19-81",
  "35-84-00-87",
  "94-01-93-82",
  "34-84-51-03",
  "04-41-50-89",
  "95-23-81-25",
  "67-76-15-51",
  "95-50-69-31",
  "83-64-25-17",
  "95-34-71-45",
  "33-70-69-16",
  "78-43-78-96",
  "40-17-92-92",
  "21-23-35-34",
  "78-30-41-12",
  "55-98-03-43",
  "53-96-66-27",
  "19-53-19-00",
  "52-69-01-63",
  "98-23-74-93",
  "41-20-43-38",
  "81-51-81-24",
  "24-45-62-14",
  "70-89-41-83",
  "44-21-93-19",
  "44-84-01-27",
  "67-07-68-68",
  "17-96-79-58",
  "60-78-16-91",
  "39-65-53-62",
  "67-13-78-20",
  "77-62-75-62",
  "67-98-54-78"
  
  
  
  
  
  
)


# interviews with errors but that have been confirmed by supervisor
force_approve <- c(
  
  "50-59-97-11",
  "83-64-96-24",
  "89-71-50-00",
  "49-65-17-26",
  "79-29-15-42",
  "48-76-13-08",
  "83-14-73-72",
  "03-90-71-53",
  "16-38-70-85",
  "11-99-01-32",
  "97-91-00-74",
  "63-40-86-39"
  
  
)






#==============================================================================
#drop interviews indicated by data manager,
#force to approve if data manager indicates to do so
# drops redundant interviews from roster
# saves clean data in clean folder
# Creates status and management variables for all the interviews and for geo units (province, cidades, bairro)
#exports data to dashboard folder (interviews, summary_bairros, summary_provincias, summary_cidades)


source(run_file("3.clean_and_exort_data_dashboard"))










