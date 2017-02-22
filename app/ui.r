library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(tabsetPanel(

  # page 1- map plotout page
  tabPanel("Layout",
    sidebarLayout(
        sidebarPanel(
        # selectbox to choose the borough
        selectInput("borough", label = "Choose a Borough", 
                           choices = list("Manhattan", "Bronx", 
                                          "Queens", "Brooklyn",
                                          "Staten Island"="Staten_Island"
                                          ),
                           selected = 0),
        # selectbox to choose the neighborhood based on the borough
        uiOutput("neighborhood"),
        selectInput("time", label="Choose Time",
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
        h1("Wifi Spots/Heat map throughout New York City"),
        plotOutput("map")
      ))),
  
  tabPanel("Conclusion",
      sidebarLayout(
        sidebarPanel(
          radioButtons("result", label = "Places to be explored",
                        choices  = list("Place 1"=1,
                                       "Place 2"=2,
                                       "Place 3"=3),
                        selected = 1)
        ),
        mainPanel(
          h1("Conclusion"),
          textOutput("text"),
          plotOutput("placemap")
        )
       )
    )
)))

