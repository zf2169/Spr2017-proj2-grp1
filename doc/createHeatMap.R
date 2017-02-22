createHeatMap <- function(neighborhood="empty", borough, data, mapColor="blue"){
  
  if (neighborhood == "empty"){
    centroids <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/borough_centroids.csv", header=TRUE)
    centroidLAT <- centroids$LAT[centroids$borough==borough]
    centroidLON <- centroids$LON[centroids$borough==borough]
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 11)
    heatmap <- ggmap(initMap, extent = "device") + stat_density2d(data = data[(data$borough == borough),], aes(x = LON, y = LAT, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = "polygon") + scale_fill_gradient(low = mapColor, high = paste0(mapColor, "4")) + scale_alpha(range = c(0, 0.5), guide = FALSE)
  } else {
    centroids <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/shapefile_neighborhood_centroids.csv", header=TRUE)
    centroidLAT <- centroids$LAT[centroids$neighborhood==neighborhood]
    centroidLON <- centroids$LON[centroids$neighborhood==neighborhood]
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 15)
    heatmap <- ggmap(initMap, extent = "device") + stat_density2d(data = data[(data$neighborhood == neighborhood),], aes(x = LON, y = LAT, fill = ..level.., alpha = ..level..), size = 0.01, bins = 16, geom = "polygon") + scale_fill_gradient(low = mapColor, high = paste0(mapColor, "4")) + scale_alpha(range = c(0, 0.5), guide = FALSE)
  }
  
  return(heatmap)
}

createComboHeatMap <- function(neighborhood="None", borough, wifiData, taxiData, wifiColor="blue", taxiColor="red"){
  
  if (neighborhood == "None"){
    centroids <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/borough_centroids.csv", header=TRUE)
    centroidLAT <- centroids$LAT[centroids$borough==borough]
    centroidLON <- centroids$LON[centroids$borough==borough]
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 12)
    fullData <- rbind(data.frame(taxiData[(taxiData$borough == borough),], group="Foot Traffic"), data.frame(wifiData[(wifiData$borough == borough),], group="WiFi Coverage"))
    heatmap <- ggmap(initMap, extent = "device") +
      stat_density2d(data = fullData,
                     aes(x = LON, y = LAT, fill = group, alpha = ..level..),
                     size = 0.01, bins = 16, geom = "polygon") + 
      scale_fill_manual(values=c("Foot Traffic"=taxiColor, "WiFi Coverage"=wifiColor)) +
      scale_alpha(range = c(0, 0.5))
  } else {
    centroids <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/shapefile_neighborhood_centroids.csv", header=TRUE)
    centroidLAT <- centroids$LAT[centroids$neighborhood==neighborhood]
    centroidLON <- centroids$LON[centroids$neighborhood==neighborhood]
    initMap <- get_map(location = c(lon = centroidLON, lat = centroidLAT), zoom = 15)
    fullData <- rbind(data.frame(taxiData[(taxiData$neighborhood == neighborhood),], group="Foot Traffic"), data.frame(wifiData[(wifiData$neighborhood == neighborhood),], group="WiFi Coverage"))
    heatmap <- ggmap(initMap, extent = "device") +
      stat_density2d(data = fullData,
                     aes(x = LON, y = LAT, fill = group, alpha = ..level..),
                     size = 0.01, bins = 16, geom = "polygon") + 
      scale_fill_manual(values=c("Foot Traffic"=taxiColor, "WiFi Coverage"=wifiColor)) +
      scale_alpha(range = c(0, 0.3))
  }
  
  return(heatmap)
}
