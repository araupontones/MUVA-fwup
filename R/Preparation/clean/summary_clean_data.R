#explore data for contacting people
cli::cli_alert_info("Creating summary of appended clean data")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_clean, "comments_follow_up.xlsx")


#export
c <- rio::import(infile)


#Summry
s <- c %>%
  group_by(nome, project) |>
  #count duplicates
  mutate(dup = n()>1) |>
  ungroup() |>
  group_by(project) %>%
  summarise(records = n(),
            duplicados = sum(dup),
            have_telefone = sum(telefone!="Sem Contacto"),
            have_cidade = sum(!is.na(cidade)),
            have_provincia = sum(!is.na(provincia)),
           
            .groups = 'drop') %>%
  adorn_totals("row") %>%
  mutate(across(contains("have"), function(x) x/records),
         across(contains("have"), function(x)paste0(round(x *100,1), "%")),
         records = prettyNum(records, big.mark = ",")
  )


export(s, exfile, overwrite = T)
