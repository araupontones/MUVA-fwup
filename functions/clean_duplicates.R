# correct duplicates
clean_duplicates <- function(.data){

.data |>
group_by(nome)|>
  mutate(count = n()) |>
  mutate(telefone_2 = case_when(nome == "CACILDA LIGIA PARRUQUE" ~ lead(telefone_1,1),
                                nome == "JOÃO DE DEUS MANGUMO JÚNIOR" ~ lead(telefone_1,1),
                                
                                T ~ telefone_2)) |>
  mutate(out = case_when(nome == "EMELDINA MATIAS MUNGUAMBE" & is.na(telefone_2) ~ TRUE,
                         nome == "ROSTALINA DINIS SAGUATE" & is.na(telefone_2) ~ TRUE,
                         nome == "VALENTE SALVADOR CHIVANGUE" & is.na(telefone_2) ~ TRUE,
                         nome == "CACILDA LIGIA PARRUQUE" & is.na(telefone_2) ~ TRUE,
                         nome == "JOÃO DE DEUS MANGUMO JÚNIOR" & is.na(telefone_2) ~ TRUE,
                         nome == "RITA INACIO MASSANGO" & is.na(telefone_2) ~ TRUE,
                         nome == "CLEMENTINA ISABEL TEMBE" & is.na(telefone_2) ~ TRUE,
                         nome == "JOAQUINA ANASTÁNCIO NTIKAMA" & telefone_1 == "Sem contacto" ~ TRUE,
                         nome == "SUZANA ANANIAS MABASSO" & row_number() == 2 ~ TRUE,
                         T ~ FALSE)) |>
  
  filter(!out) |>
  ungroup()
  
}
