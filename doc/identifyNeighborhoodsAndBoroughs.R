# Function requires input of a dataframe with at least 2 columns named specifically "LON" and "LAT" (longitude, latitude).
identifyNeighborhoodsAndBoroughs <- function(df, shapefile){
  
  library(raster)
  library(rgeos)
  
  origDf <- df
  coordinates(df) <- ~LON+LAT
  proj4string(df) <- CRS("+proj=longlat +datum=WGS84")
  df <- spTransform(df, proj4string(shapefile))
  shapefile_where <- df %over% shapefile
  origDf$mapped_neighborhood <- shapefile_where$NTAName
  origDf$mapped_borough <- shapefile_where$BoroName
  return(origDf)
}