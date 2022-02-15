#input: zoho creator
#outout: file.path(dir_conf_downloads, "confirmation_download.rds")

exfile <- file.path(dir_conf_downloads, "confirmation_download.rds")


library(httr)
library(jsonlite)



#download data ----------------------------------------------------------------
data_raw <-zohor::get_report_bulk( url_app = "https://creator.zoho.com" ,
                                   account_owner_name = "araupontones" ,
                                   app_link_name = "muva-follow-up",
                                   report_link_name = "Download",
                                   #access_token = new_token,
                                   criteria = "ID != 0",
                                   from = 1,
                                   client_id = "1000.V0FA571ML6VV7YFWRC4Q7OKQ32U5PZ",
                                   client_secret = "c551969c7d49a7a945ac2da12d1a3fe5f241b8dae6",
                                   refresh_token = "1000.b11df28b89daaeb2df10fa2c43178db6.6f953944b607f0ff366915cb9a770edc")



#clean names ------------------------------------------------------------------


data_names <- data_raw%>% 
  select(project = Participantes.projects,
         participante = Participantes,
         status = statusCall,
         atendido,
         consent,
         proj_part,
         proj_final,
         estara,
         futuro,
         project = Participantes.projects,
         provincia = provincias,
         cidade = Cidade_onde_vive_actualmente,
         bairro = Bairro_onde_vive_actualmente.bairro,
         quarteirao,
         rua = rua1,
         casa_numero = numero,
         referencia,
         referencia_proxima,
         telefone1 = telefone_principal,
         telefone2 = telefone_alternativo)



#data_names %>% tabyl(estara,futuro)
#data_names %>% tabyl(project)


#export ------------------------------------------------------------------------

rio::export(data_names, exfile)

