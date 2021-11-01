# append data --------------------------------------------------------------------
indir <- dir_raw
exfile <- file.path(dir_raw_appended, "muva_follow_up_raw.rds")


#list files in raw folder
files_raw <- list.files(indir, full.names = T)


#function to import and check names of variables
check_names <- function(file){
  
  project <- str_extract(file, "(?<=raw\\/).*(?=.xlsx)")
  raw_files <- rio::import(file, col_types = "text") 
  #because there are records missing project
  
  
  
  message(project)
  message(ncol(raw_files))
  message(nrow(raw_files))
  
  if(nrow(raw_files > 0)){
    raw_files$project = project
    return(raw_files)
  }
  
  
}


#append
list_of_files <- lapply(files_raw, check_names)

#save ==========================================================================
append_db <- do.call(plyr::rbind.fill, list_of_files)



class(append_db$ano_participacao)
rio::export(append_db, exfile)
