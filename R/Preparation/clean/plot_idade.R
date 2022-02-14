#Explore key variables
#explore data for contacting people
cli::cli_alert_info("Plotting Idade")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_plots, "idade.png")


#import data --------------------------------------------------------------------

c <- import(infile)

c %>% tabyl(idade)


#plot escolaridade ------------------------------------------------------------
data_idade <- c %>%
  group_by(idade) %>%
  summarise(total = n())

idade <- ggplot(data = c,
                       aes(x = idade)
)+
  geom_histogram(fill = aqua,
                 color=orange) +
  labs(title = "Distribuição Idade",
       y = "Records")+
  theme_muva() +
  theme_col_vertical()


#export ----------------------------------------------------------------------
ggsave(exfile,
       idade)
