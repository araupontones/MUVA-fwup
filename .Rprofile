cli::cli_alert_info("Follow up MUVA")

options("scipen"=100, digits = 2)
Sys.setlocale("LC_ALL","Portuguese")


#Define libraries --------------------------------------------------------------

libraries <- c(
  
  
  
  #ggplot
  "ggplot2",
  
  
  
  #tidyverse
  "dplyr", "tidyr", "stringr",
  
  #carpintery
  "lubridate", "janitor", "forcats", "gmdacr",
  
  
  #other
  "rio", "glue"
  
)


#define paths -----------------------------------------------------------------

db <- "C:/Users/andre/Dropbox/LIGADA MEL/MEL working/09 Follow up studies"
db_data <- file.path(db, "data")

dir_data <- "data"
dir_raw <- file.path(dir_data, "raw")
dir_raw_appended <- file.path(dir_data, "raw_appended")
dir_clean <- file.path(dir_data, "clean")
dir_data_dash <- file.path(dir_data, "dashboard")
dir_shapes <- "shapes"


#===============================================================================




suppressWarnings({
  options(defaultPackages=c(getOption("defaultPackages"),
                            
                            libraries
  )
  )
})

gmdacr::load_functions('functions')
