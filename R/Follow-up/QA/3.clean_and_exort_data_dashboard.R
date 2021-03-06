
#clean and save data ----------------------------------------------------------


#this produces a clean version of the data, drops interviews indicated by the data manager
# and approves interviews (marks as verificada if supervisors asks to)
data_clean <- clean_data(data_field = field_data, 
                         drop_this = drop_interviews,
                         force_approved_this = force_approve)





#this saves clean data, removes drops from rosters and saves all in clean
save_clean_data(clean_database = data_clean,
                dir_clean = dir_clean,
                dir_raw = dir_raw )














#data for dashboard ---------------------------------------------------------
interviews <- data_clean %>% 
  mutate(resultado = susor::susor_get_stata_labels(outcome))%>%
  select(interview__key, ID_participant, 
         provincia, 
         cidade, bairro, 
         inquiridor,
         resultado, status,Management,has__errors, 
         unanswered = n_questions_unanswered,
         duplicated = dup, 
         duration = interview__duration,
         interview__id,
         date, time, url) %>%
  full_join(select(sample,ID, participante, provincia, cidade, bairro), by= c("ID_participant"="ID", "provincia", "cidade", "bairro")) %>%
  mutate(inquiridor = susor::susor_get_stata_labels(inquiridor),
         across(c(resultado, status, interview__key, Management, inquiridor), function(x){if_else(is.na(x), "Sin visitar", as.character(x))})
         )







rio::export(interviews, file.path(dir_dashboard, "interviews.csv"))
cli::cli_alert_success("Dashboard data interviews saved!")

#export summary at the province, cidade, and bairro level (Approved, Rejected, Sim VIsitar, Sampled, Nao conseguidas)
provs_dash <- create_dashGeo(database = interviews, 
               by ="provincias",
               dir_dashboard = dir_dashboard,
               provincia) 
 






cidades_dash <- create_dashGeo(database = interviews, 
               by ="cidades",
               dir_dashboard = dir_dashboard,
               provincia, cidade) 


bairros_dash <- create_dashGeo(database = interviews, 
               by ="bairros",
               dir_dashboard = dir_dashboard,
               provincia, cidade, bairro)










