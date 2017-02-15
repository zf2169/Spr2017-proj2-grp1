library(dismo)
library(sp)
library(geosphere)
library(ggplot2)
library(ggmap)
library(rgeos)
library(scales)

require(httr)
require(httpuv)
require(jsonlite)
require(base64enc)

consumerKey = "l_rSuqvu8nD49nJ7Y3uGKw"
consumerSecret = "AZA-PdWtTt2PCTK5SFp792LGHUI"
token = "tzJ8ZyDR2jeAm4SAEMOkJJe5gFPOkwBl"
token_secret = "e89np3uLyLE5ffunidczgL_HpRY"

# All of these other functions are used in the main function at the bottom, "readYelpData". That is the main function.

yelp_query <- function(path, query_args) {
  # Use OAuth to authorize your request.
  myapp <- oauth_app("YELP", key=consumerKey, secret=consumerSecret)
  sig <- sign_oauth1.0(myapp, token=token, token_secret=token_secret)
  
  # Build Yelp API URL.
  scheme <- "https"
  host <- "api.yelp.com"
  yelpurl <- paste0(scheme, "://", host, path)
  
  # Make request.
  results <- GET(yelpurl, sig, query=query_args)
  
  # If status is not success, print some debugging output.
  HTTP_SUCCESS <- 200
  if (results$status != HTTP_SUCCESS) {
    print(results)
  }
  return(results)
}

yelp_search <- function(term, location, limit=10, offset = 0) {
  # Search term and location go in the query string.
  path <- "/v2/search"
  query_args <- list(term=term, location=location, limit=limit, offset = offset)
  
  
  # Make request.
  results <- yelp_query(path, query_args)
  return(results)
}

yelp_business <- function(business_id) {
  # Business ID goes in the path.
  path <- paste0("/v2/business/", business_id)
  query_args <- list()
  
  # Make request.
  results <- yelp_query(path, query_args)
  return(results)
}

print_search_results <- function(yelp_search_result) {
  print("=== Search Results ===")
  # Load data.  Flip it around to get an easy-to-handle list.
  locationdataContent = content(yelp_search_result)
  locationdataList=jsonlite::fromJSON(toJSON(locationdataContent))
  
  # Print output.
  print(head(data.frame(locationdataList)))
}

print_business_results <- function(yelp_business_result) {
  print("=== Business ===")
  print(content(yelp_business_result))
}

demo <- function(searchTerm, neighborhood, borough, limit) {
  
  ### THIS ONLY RETURNS FIRST 40. We will have to implement the built in "offset" to acquire ALL results.
  
  lat <- vector()
  lon <- vector()
  businessName <- vector()
  
  # Query Yelp API, print results.
  yelp_search_result <- yelp_search(term=tolower(searchTerm), location=paste0(neighborhood, ", " , borough,", NY"), limit=limit)
  
  # Pick the top search result, get more info about it.
  # Find Yelp business ID, such as "giacomos-ristorante-boston".
  #business_id = content(yelp_search_result)$businesses[[39]]$id
  #yelp_business_result <- yelp_business(business_id)
  
  numResults <- length(content(yelp_search_result)$businesses)
  offset_num = 0
  for (i in 1:numResults){
    lat[i] <- content(yelp_search_result)$businesses[[i]]$location$coordinate$latitude
    lon[i] <- content(yelp_search_result)$businesses[[i]]$location$coordinate$longitude
    businessName[i] <- content(yelp_search_result)$businesses[[i]]$name
  }
  while(numResults == limit)
  {
    offset_num = offset_num + limit
    yelp_search_result <- yelp_search(term=tolower(searchTerm), location=paste0(neighborhood, ", " , borough,", NY"), limit=limit, offset = offset_num)
    numResults <- length(content(yelp_search_result)$businesses)
    for (i in ((offset_num+1):(offset_num + numResults))){
      if(length(content(yelp_search_result)$businesses[[(i-offset_num)]]$location$coordinate$latitude) == 0)
      {
        lat[i] = NA
      }
      else
      {
        lat[i] <- content(yelp_search_result)$businesses[[(i-offset_num)]]$location$coordinate$latitude
      }
      if(length(content(yelp_search_result)$businesses[[(i-offset_num)]]$location$coordinate$longitude) == 0)
      {
        lon[i] = NA
      }
      else
      {
        lon[i] <- content(yelp_search_result)$businesses[[(i-offset_num)]]$location$coordinate$longitude
      }
      if(length(content(yelp_search_result)$businesses[[i-offset_num]]$name) == 0)
      {
        businessName[i] = NA
      }
      else
      {
        businessName[i] <- content(yelp_search_result)$businesses[[i-offset_num]]$name
      }
    }
  }
  
  df <- as.data.frame(cbind(lon, lat, businessName))
  colnames(df) <- c("LON", "LAT", "name")
  
  return(df)
  
  
}

readYelpData = function()
{
  nbh <- read.csv("../data/neighborhoods.csv", header=TRUE)
  
  allStarbucks <- allMcDonalds <- otherWifi <- vector()
  
  for (borough in 1:dim(nbh)[2]){
    borough_name <- colnames(nbh)[borough]
    for (neigh in 1:dim(nbh)[1]){
      
      neigh_name <- nbh[neigh, borough]
      if (neigh_name != ""){
        allStarbucks <- rbind(allStarbucks, demo("Starbucks", neigh_name, borough_name, 40))
        allMcDonalds <- rbind(allMcDonalds, demo("McDonalds", neigh_name, borough_name, 40))
        otherWifi <- rbind(otherWifi, demo("free wifi", neigh_name, borough_name, 40))
      }
      
    }
  }
  
  allStarbucks <- unique(allStarbucks)
  allMcDonalds <- unique(allMcDonalds)
  otherWifi <- unique(otherWifi)
  allStarbucks <- allStarbucks[allStarbucks$name == "Starbucks",]
  allMcDonalds <- allMcDonalds[allMcDonalds$name == "McDonald's",]
  row.names(allStarbucks) <- 1:nrow(allStarbucks)
  row.names(allMcDonalds) <- 1:nrow(allMcDonalds)
  row.names(otherWifi) <- 1:nrow(otherWifi)
  
  rest_pubWifi <- rbind(allStarbucks,allMcDonalds,otherWifi)
  colnames(rest_pubWifi) <- c("LON", "LAT", "network")
  
  return(rest_pubWifi)
}