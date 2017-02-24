library(shiny)

shinyServer(function(input, output) {
  
  # sub-selection box
  #output$neighborhood <- renderUI({
    
    # Create the selectbox
  #   selectInput("wifineighborhoodname", 
  #               label = "Choose the neighborhood for Wi-Fi", 
  #               choices  = as.list(wifi[[input$borough]]),
  #               selected = 1)
  # })
  output$neighborhood <- renderUI({
    # Create the selectbox
     #if (input$borough!="All Boroughs"){
       selectInput("neighborhoodname", 
                label = "Choose the neighborhood", 
                choices  = as.list(common[input$borough]),
                selected = 1)#}
    else{
      selectInput("noneighborhoodname",
                  label = "Choose the neighborhood",
                  choices = "None", selected = NULL)
    }
    })

  output$map <- renderPlot({
     if (length(input$mapstyle)==1) { 
      if (input$mapstyle=="Wifi Coverage") {
        if(input$borough=="All Boroughs"){
          createHeatMap(neighborhood = "None",
                        borough = input$borough, 
                        wifiData, 
                        "blue")
        }
        else{
          
        createHeatMap(neighborhood = input$neighborhoodname,
                      borough = input$borough, 
                      wifiData, 
                      "blue")
        }
      }
      if (input$mapstyle=="Foot Traffic") {
        if (input$borough=="All Boroughs"){
          createHeatMap(neighborhood = "None",
                        borough = input$borough, 
                        taxiData, 
                        "blue")
        }
        createHeatMap(neighborhood = input$neighborhoodname,
                      borough = input$borough,
                      taxiData,
                      "red")}
    }
    else {
      # if (input$wifineighborhoodname==input$taxineighborhoodname)
       if(input$borough=="All Boroughs"){
         createHeatMap(neighborhood = "None",
                       borough = input$borough, 
                       wifiData, 
                       "blue")
       }
       
       else
        createComboHeatMap(input$wifineighborhoodname, 
                           borough=input$borough, 
                           wifiData, 
                           taxiData, 
                           "blue", "red")
      #else {
       # createComboHeatMap("None", 
        #                   borough=input$borough, 
        #                   wifiData, 
        #                   taxiData, 
        #                   "blue", "red")
      
      #}
    }
  })
  
  output$map2<-renderPlot({
    if (input$Places2=="Ideal place to open a resturant")
    {
      createComboHeatMap("Flushing",borough="Queens", wifiData, taxiData, "blue", "red")
    }

    
    if (input$Places2=="Re-consider the location Please")
    {
      createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")
    }

    
   if (input$Places2=="Maybe a good place")
   {
      createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "blue", "red")
   }
    
  })
  
  output$map3<-renderPlot({
    if (input$Places3=="Ideal place to go for Wi-Fi")
    {
      createComboHeatMap("None",borough="Brooklyn", wifiData, taxiData, "blue", "red")
    }
    
    if (input$Places3=="Never go for Wi-Fi")
    {
      createComboHeatMap("Flushing", borough="Queens", wifiData, taxiData, "blue", "red")
    }
    
    if (input$Places3=="Maybe OK to go for Wi-Fi")
  
    {
      createComboHeatMap("Clinton",borough="Manhattan", wifiData, taxiData, "blue", "red")
    }
   })
  })
#})
