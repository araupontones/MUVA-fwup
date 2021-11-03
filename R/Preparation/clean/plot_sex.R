#Explore key variables
#explore data for contacting people
cli::cli_alert_info("Plotting sex")
infile <- file.path(dir_prep_clean, "muva_follow_up_clean.rds")
exfile <- file.path(dir_prep_plots, "sex.png")


#import data --------------------------------------------------------------------

c <- import(infile)

c |> tabyl(sexo)


#plot escolaridade ------------------------------------------------------------
data_sexo <- c |>
  group_by(sexo) |>
  summarise(total = n()) |>
  ungroup()

data_sexo

ggplot(data_sexo, aes(x="", y=total, fill=sexo)) +
  geom_bar(stat="identity", 
           width=1, 
           color="white") +
  coord_polar("y", start=0) +
  scale_fill_manual(values = c(purple, aqua, "gray")) +
  labs(title = "Sexo",
       y = "",
       x = "")+
 theme_muva() +
  theme(panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.text.x = element_blank(),
        legend.title = element_blank(),
        legend.position = "top",
        legend.text = element_text(size = 12))
  


#export ----------------------------------------------------------------------
ggsave(exfile,
       last_plot())
