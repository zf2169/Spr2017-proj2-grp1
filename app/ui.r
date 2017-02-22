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
          selectInput("Places to Open Stores", "For Small Business Owners...",
                      choices=c("Ideal Place to Open a Store"=1,
                                   "Re-consider the Location Plz"=2,
                                   "Maybe a Good Place to Open a Store"=3))),
         mainPanel(
          h1("Where should Small Business Owners to Open a Store?")
          #textOutput("text")
          #plotOutput("map")
        )
       
      )
  ),
    
  
  #Page 3 - Result Tab
  tabPanel("Results - Customer Side",
           sidebarLayout(
             sidebarPanel(
               selectInput("Places to go for Wi-Fi", "For Customers...",
                           choices=c("Ideal Place to go for Wi-Fi"=1,
                                     "Never Go for Wi-Fi"=2,
                                     "Maybe OK to Go for Wi-Fi"=3))),
             mainPanel(
               h1("Where should we go when need Wi-Fi connections")
               #textOutput("text") - 
               #plotOutput("map")
             )
             
           )
  )
  
)



))

