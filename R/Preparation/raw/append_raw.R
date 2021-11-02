# append data --------------------------------------------------------------------
cli::cli_alert("Appending raw data and saving in Preparation/raw/appended")

indir <- dir_prep_raw #first run copy_raw_from_dropbox.R
exfile <- file.path(dir_prep_raw_appended, "muva_follow_up_raw.rds")


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




rio::export(append_db, exfile)
