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
          selectInput("Places2", "For Resturant Owners...",
                      choices=list("Ideal place to open a resturant",
                                   "Re-consider the location Please",
                                   "Maybe a good place"))),
         mainPanel(
          h1("Where to Open a Resturant in New York?"),
          plotOutput("map2")
        )
       
      )
  ),
    
  
  #Page 3 - Result Tab
  tabPanel("Results - Customer Side",
           sidebarLayout(
             sidebarPanel(
               selectInput("Places3", "For Customers...",
                           choices=list("Ideal place to go for Wi-Fi",
                                     "Never go for Wi-Fi",
                                     "Maybe OK to go for Wi-Fi"))),
             mainPanel(
               h1("Where should we eat if we need Wi-Fi connections?"),
               plotOutput("map3")
             )
             
           )
  )
  
)



))

