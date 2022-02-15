#Explore key variables
#explore data for contacting people
cli::cli_alert_info("Plotting nivel de escolaridade")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_plots, "escolaridade.png")


#import data --------------------------------------------------------------------

c <- import(infile)


#plot escolaridade ------------------------------------------------------------
data_eductaion <- c %>%
  group_by(escolaridade) %>%
  summarise(total = n())

escolaridade <- ggplot(data = data_eductaion,
       aes(x = total,
           y = escolaridade)
       )+
  geom_col(fill = aqua) +
  labs(title = "Nível de Escolaridade",
       y = "")+
 theme_muva() +
  theme_col()


#export ----------------------------------------------------------------------
ggsave(exfile,
       escolaridade)
