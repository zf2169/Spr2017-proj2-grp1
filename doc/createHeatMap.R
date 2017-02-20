createHeatMap <- function(neighborhood="empty", borough, data, mapColor="blue"){
  
  nbh <- read.csv("../data/neighborhoods.csv", header=TRUE)
  centroidLocations <- read.csv("../output/neighborhood_centroid.csv", header=TRUE)
  
  listOfNeigh <- nbh[,eval(borough)]
  idx <- which(listOfNeigh == neighborhood)
  
  listOfLats <- centroidLocations[,eval(paste0(borough, ".lat"))]
  listOfLons <- centroidLocations[,eval(paste0(borough, ".lon"))]
  centroidLAT <- listOfLats[idx]
  centroidLON <- listOfLons[idx]
  
  if (neighborhood == "empty") {
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 11)
  } else {
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 15)
  }
  
  
  heatmap <- ggmap(initMap, extent = "device") + stat_density2d(data = data[(data$neighborhood == neighborhood) & (data$borough == borough),], aes(x = LON, y = LAT, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = "polygon") + scale_fill_gradient(low = mapColor, high = paste0(mapColor, "4")) + scale_alpha(range = c(0, 0.5), guide = FALSE)
  
  return(heatmap)
}