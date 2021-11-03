#Explore key variables
#explore data for contacting people
cli::cli_alert_info("Plotting provincias")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_plots, "provincias.png")


#import data --------------------------------------------------------------------

c <- import(infile)




#plot escolaridade ------------------------------------------------------------
data_prov <- c |>
  group_by(provincia) |>
  summarise(total = n())

provs <- ggplot(data = data_prov,
                aes(x = total,
                    y = reorder(provincia, total))
)+
  geom_col(fill = aqua,
                 color=orange) +
  labs(title = "Provincias",
       y = "")+
  theme_muva() +
  theme_col()


provs
#export ----------------------------------------------------------------------
ggsave(exfile,
       provs)
