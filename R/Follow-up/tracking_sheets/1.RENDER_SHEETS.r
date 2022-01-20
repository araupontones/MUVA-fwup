exdb <- file.path(db, "02 Tracking sheets")


provincias <- c("Cabo Delgado","Gaza", "Maputo Cidade", "Maputo Provincia", "Sofala", "Zambézia")

sapply(provincias, function(x) {
  rmarkdown::render(input = "R/Follow-up/tracking_sheets/tracking_sheets_params.rmd", 
                    output_file = sprintf("%s.docx", x),
                    params = list(selected_provincia = x))
})



#copy to dropbox
fls <- list.files("R/Follow-up/tracking_sheets", full.names = T) 

str_detect(fls, provincias)



for(p in provincias){
  
  from <- fls[str_detect(fls, "Gaza")]
  to <-file.path(exdb, glue("{p}.docx")) 

    file.copy(from, to)
  
  
  
}


