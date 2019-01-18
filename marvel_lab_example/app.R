library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# Now we'll get our data:

marvel <- read_csv("marvel-wikia-data.csv")

marvel$SEX[is.na(marvel$SEX)] <- "Not Specified"

# Create the user interface
ui <- fluidPage(
  
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side", # stored in R's brain
                   "Choose a side", # button title
                   c("Good Characters", # choices
                     "Bad Characters",
                     "Neutral Characters"))
    ), 
    
    mainPanel(
      plotOutput(outputId = "marvelplot") # we're going to create something called marvelplot eventually
    )
  )
  
  
)

# Create the server (brains of the operation)
server <- function(input, outputs) {
  
  output$marvelplot <- renderPlot({ # made a reactive plot that will be stored as marvelplot as output
    
    ggplot(filter(marvel, ALIGN == input$side), aes(x = Year)) + # include subset of data used for radio buttons
      geom_bar(aes(fill = SEX), position = "fill") +
      theme_dark()
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

