#explore data for contacting people
cli::cli_alert_info("Check for duplicates in clean data")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_clean, "duplicados_clean.xlsx")


c <-muva_follow_up_clean


dups <- c %>% get_dupes(nome, projecto) %>%
  select(nome, projecto, idade, ciclo) %>%
  arrange(nome, projecto, idade) %>%
  group_by(nome, projecto) %>%
  mutate(duplicacado = n()) %>%
  ungroup() 




rio::export(dups,exfile, overwrite =T)
