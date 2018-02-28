library(shiny)
library(ggplot2)

load(file = "data/data.RData")


# custom ggplot theme to drop the axes and ticks but leave the guides and legends
ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank(),
  panel.background = element_blank()
)

# Define server logic required to draw the scatterplot
server <- function(input, output) {

  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = heating_cooling_degree_days, 
           aes_string(x = heating_cooling_degree_days$year, y = input$var)) +
      geom_point(color= ifelse (input$var == "heating_days", "red", "blue"), shape = 1, alpha = 1) +
      geom_smooth(color= ifelse (input$var == "heating_days", "red", "blue")) +
      xlab("Year") + 
      ylab(ifelse (input$var == "heating_days", "Heating Days", "Cooling Days")) +
      labs(title = "Heating and Cooling Degree Days in lower 48", 
           subtitle = "(1895–2015)",
           caption = "Data source: NOAA, 2016") +
      theme(legend.title = element_text(size = 10),
            legend.text = element_text(size = 12),
            plot.title = element_text(size=20),
            axis.title=element_text(size=14,face="bold"),
            axis.text.x = element_text(angle = 0, hjust = 1)) +
      theme_classic()
  })
  
  
        output$US_map <- renderPlot({
          
        # generating data for US_map
        Lyme_map_data <-  Lyme_State %>% 
          select(region, cases = as.character(input$year)) %>% 
          mutate(region = tolower(region))
        Lyme_map_data <- 
          merge(us_state_map, Lyme_map_data, by='region', all=T)
        
        ggplot(data = Lyme_map_data, aes(x=long, y=lat, group=group, fill=cases)) +
          scale_fill_gradientn("",colours=brewer.pal(n=4, "YlOrRd"))+
          geom_polygon()+coord_map()+
          labs(title=paste(input$year,"Lyme disease incidence rates by state"),
                           subtitle="(confirmed cases per 100,000 persons)",
               caption = "Data source: CDC, 2016",
               fill = "Incidence")+
          theme(legend.title = element_text(size = 10),
                legend.text = element_text(size = 12),
                plot.title = element_text(size=20)
                ) +
          ditch_the_axes

    }
  )
}