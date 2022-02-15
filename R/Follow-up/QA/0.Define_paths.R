



#define directories -------------------------------------------------------------
dir_downloads <- file.path("data/Follow-up/0.downloads")
dir_raw <- file.path("data/Follow-up/1.raw")
dir_clean <- file.path("data/Follow-up/2.clean")
dir_dashboard <- file.path("data/Follow-up/3.dashboard")


#read reference data ------------------------------------------------------------
infile <- function(geo){file.path(dir_fp_sample, glue::glue('Sampled_{geo}.rds'))}
sample <- import(file.path(dir_fp_sample, "sample.rds"))
sample_provs <- infile("provincias")
sample_cidades <- infile("cidades")
sample_bairros <- infile("bairros")