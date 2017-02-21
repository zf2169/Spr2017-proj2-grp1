library(shiny)
library(choroplethr)
library(choroplethrZip)
library(dplyr)

data_sets <- read.csv("../output/neighborhood_centroids_latlong.csv", header = T)
getsubselection<- function(borough) {
  if (borough==0) borough <- "Manhattan"
  if (borough==1) borough <- "Bronx"
  if (borough==2) borough <- "Queens"
  if (borough==3) borough <- "Brooklyn"
  if (borough==4) borough <- "Staten_Island"
  selection<- data_sets%>%
              filter(Borough==borough)%>%
              select(NeighborhoodName)
  l<- vector("list", nrow(selection))
  n<-c()
  for(i in 1:nrow(selection)) {
    c<- as.character(selection$NeighborhoodName[i])
    n<- cbind(n,c)
    l[i]<-i
  }
  names(l)<- n
  return(l)
}

shinyServer(function(input, output) {
  
  # sub-selection box
  output$neighborhood <- renderUI({

    # Get the data set with the appropriate name
    dat <- getsubselection(input$borough)
    
    # Create the selectbox
    selectInput("neighborhoodname", 
                label = h5("Choose the neighborhood"), 
                choices  = dat,
                selected = 1)
  })
  
})