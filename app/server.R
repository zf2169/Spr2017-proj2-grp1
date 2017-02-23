library(shiny)

shinyServer(function(input, output) {
  
  # sub-selection box
  output$wifineighborhood <- renderUI({
    
    # Create the selectbox
    selectInput("wifineighborhoodname", 
                label = "Choose the neighborhood for Wi-Fi", 
                choices  = as.list(wifi[[input$borough]]),
                selected = 1)
  })
  
  output$taxineighborhood <- renderUI({
    
    # Create the selectbox
    selectInput("taxineighborhoodname", 
                label = "Choose the neighborhood for taxi", 
                choices  = as.list(taxi[input$borough]),
                selected = 1)
  })
  
  output$map <- renderPlot({
    if (length(input$mapstyle)==1) {    
      if (input$mapstyle=="Wifi map") {
        createHeatMap(neighborhood = input$wifineighborhoodname,
                      borough = input$borough, 
                      wifiData, 
                      "blue")
      }
      if (input$mapstyle=="Google map") {
        createHeatMap(neighborhood = input$taxineighborhoodname,
                      borough = input$borough,
                      taxiData,
                      "red")}
    }
    else {
      if (input$wifineighborhoodname==input$taxineighborhoodname)
      {
        createComboHeatMap(input$wifineighborhoodname, 
                           borough=input$borough, 
                           wifiData, 
                           taxiData, 
                           "blue", "red")}
      else {
        createComboHeatMap("None", 
                           borough=input$borough, 
                           wifiData, 
                           taxiData, 
                           "blue", "red")
      }
    }
  })
  
  output$map2<-renderPlot({
    if (input$Places2=="Ideal Place to Open a Store")
    {
      createComboHeatMap("Flushing",borough="Queens", wifiData, taxiData, "green", "red")
    }
 # })
  
#  output$map3<-renderPlot({
    if (input$Places2=="Re-consider the Location Plz")
    {
      createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")
    }
#  })
  
 # output$map4<-renderPlot({
  #  if (input$Places1=="Maybe a Good Place to Open a Store")
  else 
   {
      createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "orange", "red")
    }
  })
  
  output$map3<-renderPlot({
    if (input$Places3==1)
    {
      createComboHeatMap("Flushing", borough="Queens", wifiData, taxiData, "green", "red")
    }
    
    if (input$Places3==2)
    {
      createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")
    }
    
    #else 
    if (input$Places3==3)
    {
      createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "orange", "red")
    }
  })
})

