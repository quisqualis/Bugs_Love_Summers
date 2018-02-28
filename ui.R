library(shiny)
library(ggplot2)

load(file = "data/data.RData")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  tags$style(HTML(".irs-bar {width: 100%; height: 15px; background: black; border-top: 1px solid black; border-bottom: 1px solid black;}")),
  tags$style(HTML(".irs-bar-edge {background: black; border: 1px solid black; height: 15px; border-radius: 5px 5px 5px 5px;}")),
  tags$style(HTML(".irs-line {border: 1px solid black; height: 15px;}")),
  tags$style(HTML(".irs-grid-text {font-family: 'arial'; color: black}")),
  tags$style(HTML(".irs-max {font-family: 'arial'; color: black;}")),
  tags$style(HTML(".irs-min {font-family: 'arial'; color: black;}")),
  tags$style(HTML(".irs-single {color:black; background:#6666ff;}")), 
  
  # Some custom CSS for a smaller font for preformatted text
  tags$head(
    tags$style(HTML("
                    pre, table.table {
                    font-size: smaller;
                    }
                    "))
  ),
  
  # Application title
  titlePanel("Climate Change Indicators"), 
  
  sidebarLayout(position = "left",
  # Creates a sidebar panel containing input controls 
  sidebarPanel("",
  
  
  helpText("Explore the changing climate in USA"),
  
  # select data for Y axis:
  selectInput("var", 
              label = "Choose a variable to display",
              choices = c("Heating Days" = 'heating_days', 
                          "Cooling Days" = "cooling_days"),
              selected = "Heating Days"),
  
  
  
  # selectInput("year",
  #             label = "Choose a year",
  #             choices = c("2016","2015","2014","2013","2012",
  #                         "2011","2010","2009","2008","2007","2006"),
  #             selected = "2016"),
  
  
  sliderInput("year",
              sep="",
              label = "Choose a year",
              min = 2006,
              max = 2016,
              value = 2016,
              step = 1, ticks = FALSE,
              width = "100%"),
  
  # provide x-axis
  # selectInput(inputId = "year",
  #             label = "Year",
  #             choices = c("year"), 
  #             selected = ""),
  
  width = 2
  ), 
  
  
  # Outputs
  mainPanel("",          
            fluidRow(
              
              #     #  Description text
              #     
              #     p("A “degree day” is determined by comparing the daily average outdoor temperature 
              #       with a defined baseline temperature for indoor comfort (in this case, 65°F). 
              #       If the average temperature on a particular day is 78°F, then that day counts as 13 cooling degree days, as a building’s interior would need to be cooled by 13°F to reach 65°F. 
              # Conversely, if the average outdoor temperature is 34°F, then that day counts as 31 heating degree days, as a building’s interior would need to be warmed by 31°F to reach 65°F. 
              # A nationally applied baseline—in this case, 65°F—has certain limitations 
              #       considering the various climate regimes across the United States."),
              #     style = "font-family: 'Arial'; font-si16pt"),
              #     em(strong("Degree Days are indicators of climate change")),
              
              splitLayout(style = "border: 1px solid silver:", cellWidths = c(400,800),
                          plotOutput(outputId = "scatterplot"),
                          plotOutput(outputId = "US_map")
              )
            )
            )
)
)

