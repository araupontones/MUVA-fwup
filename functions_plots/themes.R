library(grDevices)
library(extrafont)
library(ggplot2)

font_muva <- "Gill Sans MT"

orange <- "#F77333"
aqua <- "#5CD6C7"
purple <-"#A45ED9"


theme_muva <- function(){

    theme_minimal() +
      theme(text = element_text(family = font_muva),
            plot.title.position = "plot",
            plot.title = element_text(size = 24, margin = margin(b = 20)),
            axis.text.y = element_text(hjust = 0),
            axis.text.x = element_text(hjust = 0, margin = margin(t = 20)),
            axis.text = element_text(size = 11)
      )
  
}

#horizontal cols --------------------------------------------------------------
theme_col <- function(){
  theme(
  panel.grid.major.y = element_blank(),
  panel.grid.minor.y = element_blank()
  )
}

#vertical cols ----------------------------------------------------------------
theme_col_vertical <- function(){
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 15))
  )
}
