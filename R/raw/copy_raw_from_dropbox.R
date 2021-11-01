#copy raw files from dropbox to repo
indir <- db_data
exdir <- dir_raw


#list files -------------------------------------------------------------------
files_db <- list.files(indir, full.names = T)


#function to copy files in repo
copy_to_repo <- function(file){
  
  message(file)
  file.copy(file, exdir)
}


#copy all files ----------------------------------------------------------------
sapply(files_db, copy_to_repo)
