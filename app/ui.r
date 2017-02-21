library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(tabsetPanel(

  # page 1- map plotout page
  tabPanel("layout",
    sidebarLayout(
      sidebarPanel(
        selectInput("borough", label = h5("Choose a Borough"), 
                           choices = list("Manhattan"=0,
                                          "Bronx"=1, 
                                          "Queens"=2,
                                          "Brooklyn"=3,
                                          "Staten Island"=4
                                          ),
                           selected = 0),
        uiOutput("neighborhood"),
        selectInput("time", label=h5("Choose Time"),
                    choices = list("111"=1,
                                   "222"=2,
                                   "333"=3),
                    selected = 1),
        checkboxGroupInput("mapstyle", label = "View Maps",
                           choices = list("Heat map"=1,
                                          "Google map"=2))
      ),
      # the main panel of page 1
      mainPanel(
        # main title
        h1("Wifi Spots/Heat map throughout New York"),
        plotOutput("map")
      ))),
  
  tabPanel("Result","xxx")
)))

