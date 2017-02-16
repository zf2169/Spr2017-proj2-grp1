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
  return(neighborhood_geocode_df)
}
