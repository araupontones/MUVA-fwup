#Run clean flow

r_dir_clean <- "R/Preparation/clean"

list.files(r_dir_clean)

#clean raw data
source(file.path(r_dir_clean, "clean_raw_data.R"), encoding = "utf-8")

#create summary

source(file.path(r_dir_clean, "summary_clean_data.R"), encoding = "utf-8")


#table of duplicates
#create summary

source(file.path(r_dir_clean, "create_table_of_duplicates.R"), encoding = "utf-8")
