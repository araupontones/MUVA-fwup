#create reference data for dashboard


#read data -------------------------------------------------------------------
infile <- file.path(dir_fp_sample, "sample.rds")
sample <- import(infile)


names(sample)
#function to group by geo


count_sample <- function(.data,
                         ...){
  
  geo_data <- .data %>%
    group_by(...) %>%
    summarise(sampled = n(), .groups = 'drop') 
  
  
  }

exfile <- function(geo){file.path(dir_fp_sample, glue::glue('Sampled_{geo}.rds'))}


sample %>% count_sample(provincia) %>% export(., exfile("provincias"))
sample %>% count_sample(provincia, cidade) %>% export(., exfile("cidades"))
sample %>% count_sample(provincia, cidade, bairro) %>% export(., exfile("bairros"))



