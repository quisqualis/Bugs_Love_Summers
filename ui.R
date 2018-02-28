library(shiny)
library(ggplot2)

load(file = "data/data.RData")

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
  titlePanel("Climate Change Indicators"),
  
  # adding the description to the sidebar            
  tags$div(class="header", checked=NA,
           tags$a(href="https://www.epa.gov/climate-indicators/climate-change-indicators-heating-and-cooling-degree-days", "description by EPA")
  ),
  
  
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
  
  selectInput("year", 
              label = "Choose a year",
              choices = c("2016","2015","2014","2013","2012",
                          "2011","2010","2009","2008","2007","2006"),
              selected = "2016"),
  
  # provide x-axis
  # selectInput(inputId = "year",
  #             label = "Year",
  #             choices = c("year"), 
  #             selected = ""),
  

  # Outputs
  mainPanel(
    
    #  Desctest
    
    p("A “degree day” is determined by comparing the daily average outdoor temperature 
      with a defined baseline temperature for indoor comfort (in this case, 65°F). 
      If the average temperature on a particular day is 78°F, then that day counts as 13 cooling degree days, as a building’s interior would need to be cooled by 13°F to reach 65°F. 
Conversely, if the average outdoor temperature is 34°F, then that day counts as 31 heating degree days, as a building’s interior would need to be warmed by 31°F to reach 65°F. 
A nationally applied baseline—in this case, 65°F—has certain limitations 
      considering the various climate regimes across the United States."),
    style = "font-family: 'Arial'; font-si16pt"),
    em(strong("Degree Days are indicators of climate change")),
    
    
    plotOutput(outputId = "scatterplot"),
  
  plotOutput(outputId = "US_map")
)

