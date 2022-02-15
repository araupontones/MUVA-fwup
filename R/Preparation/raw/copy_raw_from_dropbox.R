#copy raw files from dropbox to repo
cli::cli_alert_info("Copying files from dropbox")
indir <- db_data
exdir <- dir_prep_raw


#list files -------------------------------------------------------------------
files_db <- list.files(indir, full.names = T)


#function to copy files in repo
copy_to_repo <- function(file){
  
  message(file)
  file.copy(file, exdir, overwrite = T)
}


#copy all files ----------------------------------------------------------------
sapply(files_db, copy_to_repo)
