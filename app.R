library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Some custom CSS for a smaller font for preformatted text
  tags$head(
    tags$style(HTML("
      pre, table.table {
        font-size: smaller;
      }
    "))
  ),
  
  # Application title
  titlePanel("Heating and Cooling Days in USA"),
  
  # Creates a sidebar panel containing input controls 
  sidebarPanel(
          helpText("Explore the changing climate in USA"),
          
     # select data for Y axis:
  selectInput("var", 
              label = "Choose a variable to display",
              choices = c("Heating Days" = 'heating_days', 
                          "Cooling Days" = "cooling_days"),
              selected = "Heating Days")
    ),
  
  # provide x-axis
  # selectInput(inputId = "year",
  #             label = "Year",
  #             choices = c("year"), 
  #             selected = ""),
  

  # Outputs
  mainPanel(
    plotOutput(outputId = "scatterplot")
  )
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
      labs(title = "Heating and Cooling Degree Days in the Contiguous 48 States, 1895–2015", 
           caption = "Data source: NOAA, 2016") +
      theme_bw()
  })
 
}

# Run the application 
shinyApp(ui = ui, server = server)

