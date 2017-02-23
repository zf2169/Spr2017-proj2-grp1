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
                           choices = list("Bronx", "Brooklyn",
                                          "Manhattan",
                                          "Queens",
                                          "Staten Island"
                           ),
                           selected = NULL),
               
        # selectbox to choose the neighborhood based on the borough
        uiOutput("wifineighborhood"),
        uiOutput("taxineighborhood"),        

        checkboxGroupInput("mapstyle", label = "View Maps",
                           choices = c("Wifi map" ,"Google map"))
             ),
        # the main panel of page 1
        mainPanel(
          # main title
          h1("Wifi Spots/Heat Map throughout New York City"),
          plotOutput("map")
        ))),

  
  #Page 2 - Result Tab
  tabPanel("Results - Business Owner Side",
      sidebarLayout(
        sidebarPanel(
          selectInput("Places2", "For Small Business Owners...",
                      choices=list("Ideal Place to Open a Store",
                                   "Re-consider the Location Plz",
                                   "Maybe a Good Place to Open a Store"))),
         mainPanel(
          h1("Where should Small Business Owners to Open a Store?"),
          plotOutput("map2")
        )
       
      )
  ),
    
  
  #Page 3 - Result Tab
  tabPanel("Results - Customer Side",
           sidebarLayout(
             sidebarPanel(
               selectInput("Places3", "For Customers...",
                           choices=c("Ideal place to go for Wi-Fi"=1,
                                     "Never go for Wi-Fi"=2,
                                     "Maybe OK to go for Wi-Fi"=3))),
             mainPanel(
               h1("Where we should go when we need Wi-Fi connections?"),
               plotOutput("map3")
             )
             
           )
  )
  
)



))

