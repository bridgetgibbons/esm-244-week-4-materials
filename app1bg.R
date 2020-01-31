# Week 4 App Example 1
# Bridget


# Attach packages
library(shiny)
library(tidyverse)

# Get the penguins.csv data

penguins <- read_csv("penguins.csv")

# Create 'ui' = "User Interface"

ui <- fluidPage(
  titlePanel("This is my awesome app title!"),
  sidebarLayout(
    sidebarPanel("Here are my widgets",
                 radioButtons(inputId = "species",
                              label = "Choose penguin species:",
                              choices = c("Adelie", "Gentoo", "Awesome Chinstrap Penguin"="Chinstrap")),
                 selectInput(inputId = "pt_color",
                             label = "Select a point color!",
                             choices = c("Favorite Red!!!"="red", 
                                         "Pretty Purple"="purple", 
                                         "ORANGE"="orange"))),
    mainPanel("Here is my graph",
              plotOutput(outputId = "penguin_plot"))
  )
)

# Create 'server'

server <- function(input, output){
  
  # Created a reactive data frame
  penguin_select <- reactive({
    penguins %>% 
      filter(sp_short == input$species)
  })
  
  output$penguin_plot <- renderPlot({
    
    ggplot(data = penguin_select(), aes(x = flipper_length_mm, y = body_mass_g)) +
      geom_point(color = input$pt_color)
    
  })
  
  
}

# Let R know that you want to combine the ui and the server into an app

shinyApp(ui = ui, server = server)