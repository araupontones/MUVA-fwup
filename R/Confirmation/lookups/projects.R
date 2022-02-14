#' create look ups for provincia

infile <- file.path(dir_prep_clean, "muva_follow_up_clean.xlsx")
exfile <- file.path(dir_conf_lookUps, "projects.xlsx")




c <- import(infile) %>%
  select(project)%>%
  group_by(project)%>%
  slice(1)%>%
  ungroup() %>%
  arrange(project)





export(c, exfile)

