library(shiny)
library(ggplot2)

load(file = "data/data.RData")

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
      labs(title = "Heating and Cooling Degree Days in the Contiguous 48 States, 1895–2015", 
           caption = "Data source: NOAA, 2016") +
      theme_bw()
  })
  
}