library(shiny)

shinyServer(function(input, output) {

  # produce the selectbox
  output$neighborhood <- renderUI({
       selectInput("neighborhoodname", 
                label = "Choose the neighborhood", 
                choices  = as.list(c("All neighborhoods",common[[input$borough]])),
                selected = NULL)
    })
  
  # plot the maps
  output$map <- renderPlot({
     if (input$mapstyle=="Wifi Coverage") {
        if(input$neighborhoodname=="All neighborhoods"){
          createHeatMap(neighborhood = "empty",
                        borough = input$borough, 
                        wifiData, 
                        "blue")}
        else{
        createHeatMap(neighborhood = input$neighborhoodname,
                      borough = input$borough, 
                      wifiData, 
                      "blue")}}
      else {
        if (input$mapstyle=="Foot Traffic") {
          if (input$neighborhoodname=="All neighborhoods"){
            createHeatMap(neighborhood = "empty",
                          borough = input$borough, 
                          taxiData, 
                          "red")}
          else{
            createHeatMap(neighborhood = input$neighborhoodname,
                          borough = input$borough,
                          taxiData,
                          "red")}}
        else {
            if(input$neighborhoodname=="All neighborhoods"){
                createComboHeatMap(neighborhood = "None",
                               borough = input$borough, 
                               wifiData,
                               taxiData, 
                              "blue","red")}
            else {
                createComboHeatMap(input$neighborhoodname, 
                                   borough=input$borough, 
                                   wifiData, 
                                   taxiData, 
                                   "blue", "red")}}}
  })
  
  output$map2<-renderPlot({
    if (input$Places2=="Ideal place to open a resturant") {
      createComboHeatMap("Flushing",borough="Queens", wifiData, taxiData, "blue", "red")}
    else {
      if (input$Places2=="Re-consider the location Please") {
        createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")}
      else {
        if (input$Places2=="Maybe a good place"){
          createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "blue", "red")}
      }}  
  })
  
  output$map3<-renderPlot({
    if (input$Places3=="Ideal place to go for Wi-Fi"){
      createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")}
    else {
      if (input$Places3=="Never go for Wi-Fi") {
        createComboHeatMap("Flushing", borough="Queens", wifiData, taxiData, "blue", "red")}
      else {
        if (input$Places3=="Maybe OK to go for Wi-Fi") {
          createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "blue", "red")}
   }}
   })
  })
#})
