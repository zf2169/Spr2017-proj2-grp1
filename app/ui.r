library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(tabsetPanel(

  # page 1- map plotout page
  tabPanel("Discussion",
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
        
        # selectInput("time", label="Choose Time",
        #             choices = list("111"=1,
        #                            "222"=2,
        #                            "333"=3),
        #             selected = 1),
        
        checkboxGroupInput("mapstyle", label = "View Maps",
                           choices = list("Heat map"=1,
                                          "Google map"=2))
      ),
      # the main panel of page 1
      mainPanel(
        # main title
        h1("Wifi Spots/Heat Map throughout New York City"),
        plotOutput("map")
      ))),
  
  tabPanel("Result",
      sidebarLayout(
        sidebarPanel(
          selectInput("Places to Open Stores", Label="For Small Business Owners...",
                      choices=list("Ideal Place to Open a Store"=1,
                                   "Re-consider the Location Plz"=2,
                                   "Maybe a Good Place to Open a Store"=3),
                      selected = 1),
            
        
          
          #radioButtons("Results", label = "Places to",
          
          #             choices  = list("Place 1"=1,
          #                               "Place 2"=2,
          #                               "Place 3"=3),
          #              selected = 1)
         #),
        mainPanel(
          h1("Conclusion"),
          textOutput("text"),
          plotOutput("placemap")
        )
       )
    )
))))

