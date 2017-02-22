library(shiny)
library(choroplethr)
library(choroplethrZip)
library(dplyr)

data_sets <- read.csv("../output/neighborhood_centroids_latlong.csv", header = T)
getsubselection<- function(borough) {
  selection<- data_sets%>%
              filter(Borough==borough)%>%
              select(NeighborhoodName)
  l<- vector("list", nrow(selection))
  for(i in 1:nrow(selection)) {
    l[i] <- as.character(selection$NeighborhoodName[i])
  }
  return(l)
}

shinyServer(function(input, output) {
  
  # sub-selection box
  output$neighborhood <- renderUI({

    # Get the data set with the appropriate name
    dat <- getsubselection(input$borough)
    
    # Create the selectbox
    selectInput("neighborhoodname", 
                label = "Choose the neighborhood", 
                choices  = dat,
                selected = 1)
  })
  
})