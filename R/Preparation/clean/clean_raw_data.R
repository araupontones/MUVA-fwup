#clean raw data
cli::cli_alert_info("cleaning raw data")

infile <- file.path(dir_prep_raw_appended, "muva_follow_up_raw.rds")
exfile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile_xlsx <- file.path(dir_prep_clean, "muva_follow_up_clean.xlsx")


#import ----------------------------------------------------------------------
r <- import(infile)

#inspect -----------------------------------------------------------------------




#clean -------------------------------------------------------------------------

c <- r %>%
  rename_all(function(x){str_to_lower(x)}) %>%
  rename(escolaridade = nivel_escolaridade) |>
  mutate(nome = str_to_upper(nome),
         #idade has many inconsitencies
         #some times the dob or the yob was reported
         dob = case_when(str_detect(idade, "-") ~ ymd(idade),
                         T ~ NA_Date_),
         #get yob
         yob = case_when(nchar(idade) == 4 ~ as.character(idade),
                         !is.na(dob) ~ as.character(year(dob)),
                         T ~ as.character(2021 -as.numeric(idade))
         ),
         idade = case_when(!is.na(dob) ~ as.numeric(difftime(Sys.Date(), dob)/365),
                           is.na(dob) ~ 2021 - as.numeric(yob)
         ),
         
         #Sexo was reported in capitals, lower, both, and some typos
         sexo = str_to_sentence(sexo),
         sexo = str_replace(sexo, "Femenino", "Feminino"),
         
         #some records of project were missing
         projecto = case_when(is.na(projecto) ~ project,
                              T ~ projecto) ,
         
         #there are typos with ciclo
         ciclo = str_extract(ciclo, "[0-9]"),
         #problems with ano participacao, some m-Y, others only year
         ano_p = as.numeric(ano_participacao),
         ano_p = case_when(ano_p > 2021 ~ as.Date(ano_p, origin = "1899-12-30"),
                           between(ano_p, 2015, 2021) ~ as.Date(glue("{ano_p}-01-01"))),
         ano_participacao = year(ano_p),
         
         
         
         
  ) |>
  #I created a function to clan the below: see functions
  clean_classe(escolaridade) |> 
  clean_telefone() |>
  clean_cidade() |>
  clean_provincia() |>#see functions
  select(-telefone_1, telefone_2,dob, yob, ano_p) #drop vars used for cleaning



#export=========================================================================
rio::export(c, exfile)
rio::export(c, exfile_xlsx, overwrite = T)


