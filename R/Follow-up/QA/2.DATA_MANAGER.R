

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
  "67-98-54-78",
  "17-76-12-19",
  "72-09-77-94",
  "55-28-43-70",
  "83-83-73-92",
  "14-93-87-09",
  "99-53-62-54",
  "37-41-95-97",
  "79-10-64-61",
  "55-16-28-77",
  "04-26-06-80",
  "44-82-66-64",
  "18-42-51-52",
  "16-80-53-85",
  "60-51-78-88",
  "96-91-18-95",
  "26-60-09-07",
  "41-85-75-62",
  "81-49-48-31",
  "51-80-33-55",
  "02-82-09-78",
  "18-19-51-70",
  "57-99-10-62",
  "34-71-55-83",
  "71-12-38-67",
  "51-59-59-29",
  "95-18-15-75",
  "38-48-58-23",
  "06-52-40-02",
  "45-00-56-81",
  "42-53-27-12",
  "42-53-27-12",
  "58-77-05-52",
  "42-53-27-12",
  "47-70-44-35",
  "44-24-28-41",
  "74-97-51-82",
  "97-89-77-91",
  "78-83-39-41",
  "06-58-51-33",
  "20-18-36-74",
  "90-56-51-79",
  "43-22-50-88",
  "08-20-26-37",
  "88-42-04-13",
  "10-58-60-99",
  "99-37-86-75",
  "72-58-92-85",
  "88-18-52-78",
  "02-96-98-29",
  "49-94-80-49",
  "37-45-73-75",
  "23-87-18-23",
  "04-97-54-60",
  "40-13-26-96",
  "08-26-23-69",
  "72-99-58-27",
  "96-60-08-51",
  "41-54-24-44",
  "01-65-19-74",
  "58-41-68-13",
  "65-67-95-70",
  "56-07-77-76",
  "32-43-83-22",
  "68-00-78-15",
  "11-09-80-94",
  "11-12-31-65",
  "85-47-11-59",
  "28-32-51-87",
  "27-58-55-60",
  "59-54-30-72",
  "90-93-42-10",
  "16-27-41-85",
  "84-83-08-04",
  "54-57-83-82",
  "25-57-01-14",
  "84-36-35-13",
  "86-60-27-76",
  "36-26-17-10",
  "72-17-01-87",
  "63-72-41-79",
  "38-51-22-68",
  "75-51-65-65",
  "57-72-83-01",
  "26-45-21-95",
  "39-96-23-74",
  "51-51-17-62",
  "01-20-17-61",
  "12-74-60-27",
  "05-92-39-41",
  "64-34-51-88",
  "28-41-77-58",
  "88-34-54-34",
  "50-23-53-71",
  "78-06-26-01",
  "63-95-71-44",
  "78-31-39-78",
  "27-97-28-05",
  "91-85-41-01",
  "78-58-14-83",
  "31-35-36-62",
  "45-28-78-35",
  "70-29-35-25",
  "28-94-27-25",
  "66-49-68-34",
  "59-13-65-63",
  "53-00-96-72",
  "74-58-57-97",
  "24-86-16-46",
  "52-95-29-78",
  "64-93-06-66",
  "81-81-00-08",
  "60-26-03-10",
  "03-90-71-53",
  "39-25-09-06",
  "52-04-46-80",
  "21-69-63-49",
  "42-67-68-81",
  "95-92-11-84",
  "84-12-76-20",
  "51-63-96-94",
  "14-31-00-71",
  "09-99-42-06",
  "46-95-75-20",
  "12-88-98-18",
  "13-02-45-45", #entrevista da Nilza Fidalgo que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "98-91-83-69", #entrevista da Sharin que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "51-45-62-48", #entrevista da Sharin que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "97-40-95-00", #entrevista da Celeste que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "12-66-77-12", #entrevista da Cecília que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "78-67-74-83", #entrevista da Celeste que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "56-41-69-66", #entrevista da Cecília que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "85-57-83-14", #entrevista da Nilza Fidalgo que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "33-29-17-49",
  "45-26-86-90", #entrevista da Celeste que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "84-79-77-73",
  "94-46-02-67", #entrevista da Celeste que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "11-84-04-25", #entrevista da Celeste que se tentou repetir sem sucesso pelo Manuel. Reintroduzir com 3 vezes sem sucesso
  "99-61-81-96",
  "79-74-80-72"
  
  
  
  
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
  "16-38-70-85",
  "11-99-01-32",
  "97-91-00-74",
  "63-40-86-39",
  "42-74-95-46",
  "38-48-58-23",
  "31-37-88-99",
  "22-72-68-38" #entrevista incompleta mas que se forçou a aprovação
  
  
)






#==============================================================================
#drop interviews indicated by data manager,
#force to approve if data manager indicates to do so
# drops redundant interviews from roster
# saves clean data in clean folder
# Creates status and management variables for all the interviews and for geo units (province, cidades, bairro)
#exports data to dashboard folder (interviews, summary_bairros, summary_provincias, summary_cidades)


source(run_file("3.clean_and_exort_data_dashboard"))










