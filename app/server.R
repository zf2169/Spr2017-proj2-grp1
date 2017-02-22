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
})

