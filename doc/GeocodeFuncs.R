NeighborhoodGeocode = function()
{
  library(ggmap)
  neighborhood_name_df = read.csv("../data/neighborhoods.csv", header=TRUE)
  neighborhood_geocode_df = as.data.frame(matrix(nrow = nrow(neighborhood_name_df), ncol = ncol(neighborhood_name_df)*2))
  for(i in 1:ncol(neighborhood_name_df))
  {
    current_borough = as.character(colnames(neighborhood_name_df)[i])
    for(j in 1:nrow(neighborhood_name_df))
    {
      current_neighborhood = as.character(neighborhood_name_df[j,i])
      if(current_neighborhood != "")
      {
        location_string = paste(current_neighborhood, ",", current_borough, ", NY")
        location_geo_code = geocode(location_string)
        neighborhood_geocode_df[j,(2*i - 1)] = location_geo_code$lat
        neighborhood_geocode_df[j,(2*i)] = location_geo_code$lon
      }
    }
  }
  
  colnames(neighborhood_geocode_df) = c("Manhattan lat", "Manhattan lon", "Bronx lat", "Bronx lon", "Queens lat", "Queens lon", "Brooklyn lat", "Brooklyn lon", "Staten Island lat", "Staten Island long")
  write.csv(neighborhood_geocode_df, "../output/neighborhood_centroid.csv")
  return(neighborhood_geocode_df)
}

CabDataNoNeighborhood = function()
{
  urlGreenCab <-"https://s3.amazonaws.com/nyc-tlc/trip+data/green_tripdata_2016-02.csv"
  urlYellowCab <- "https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2016-02.csv"
  data <- read.csv(urlGreenCab, header=TRUE)
  dataYellow = read.csv(urlYellowCab, header=TRUE)
  cleanGreenData = rbind(cbind(data$Pickup_longitude, data$Pickup_latitude), cbind(data$Dropoff_longitude, data$Dropoff_latitude))
  cleanYellowData =  rbind(cbind(dataYellow$pickup_longitude, dataYellow$pickup_latitude), cbind(dataYellow$dropoff_longitude, dataYellow$dropoff_latitude))
  #cleanGreenData = cbind(cleanGreenData, as.vector(rep("Green", nrow(cleanGreenData))))
  #cleanYellowData = cbind(cleanYellowData, as.vector(rep("Yellow", nrow(cleanYellowData))))
  totalCabData = rbind(cleanGreenData, cleanYellowData)
  totalCabData = cbind(totalCabData, as.vector(rep(NA, nrow(totalCabData))), as.vector(rep(NA, nrow(totalCabData))))
  colnames(totalCabData) = c("LON", "LAT", "borough", "neighborhood")
  write.csv(totalCabData, "../output/cabdata_noneighborhood.csv")
  smallrows = sample(1:nrow(totalCabData), nrow(totalCabData) * .055, replace= FALSE)
  smallCabData = totalCabData[smallrows,]
  return(totalCabData)
}
