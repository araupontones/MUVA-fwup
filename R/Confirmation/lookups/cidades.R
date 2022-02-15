#cidades

infile <- file.path(dir_data_ref, "cidades.xlsx")
infileProvZoho <- file.path(dir_conf_zoholookUps, "provincias_Report.csv")
exfile <- file.path(dir_conf_lookUps, "cidades.xlsx")

exfile

zp <-import(infileProvZoho, encoding = "UTF-8")
ci <- import(infile, encoding = "UTF-8") %>%
  mutate(provincia = case_when( cidade == "Maputo" ~ "Maputo Cidade",
                                provincia == "Maputo" ~ "Maputo Provincia",
                                T ~ provincia
  ))


View(ci)

lp <- ci%>%
  left_join(zp, by = "provincia") %>%
  select(provincias = provincia,
         cidade)



export(lp, exfile, encoding = "UTF-8", overwrite = T)


