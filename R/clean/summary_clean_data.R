#explore data for contacting people

infile <- file.path(dir_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_clean, "comments_follow_up.xlsx")


#export
c <- rio::import(infile)


#Summry
s <- c |>
  group_by(project) %>%
  summarise(records = n(),
            have_telefone = sum(telefone!="Sem Contacto"),
            have_cidade = sum(!is.na(cidade)),
            have_provincia = sum(!is.na(provincia)),
            .groups = 'drop') %>%
  adorn_totals("row") %>%
  mutate(across(contains("have"), function(x) x/records),
         across(contains("have"), function(x)paste0(round(x *100,1), "%"))
  )


export(s, exfile)
