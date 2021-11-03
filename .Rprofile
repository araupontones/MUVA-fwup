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

#preparation: data to create the sample frame ---------------------------------
dir_data_prep <- file.path(dir_data, "Preparation")

    dir_prep_raw <- file.path(dir_data_prep, "raw")
    dir_prep_raw_appended <- file.path(dir_data_prep, "raw_appended")
    dir_prep_clean <- file.path(dir_data_prep, "clean")

#follow-up: data collected in the follow up-------------------------------------

    
#plots ************************************************************************
    dir_plots <- "plots"
    dir_prep_plots <- file.path(dir_plots, "Preparation")
    
#shapes ------------------------------------------------------------------------
dir_shapes <- "shapes"


#===============================================================================




suppressWarnings({
  options(defaultPackages=c(getOption("defaultPackages"),
                            
                            libraries
  )
  )
})

gmdacr::load_functions('functions')
gmdacr::load_functions('functions_plots')
