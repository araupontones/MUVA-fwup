#Run workflow preparation raw append

r_dir_prep <- "R/Preparation/raw"
list.files(r_dir_prep)


#copy files from dropbox
source(file.path(r_dir_prep,"copy_raw_from_dropbox.R"), encoding = "utf-8")

#append files
source(file.path(r_dir_prep,"append_raw.R"), encoding = "utf-8")
