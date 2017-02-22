# must run before shinyapp to get the files we need 
library(choroplethr)
library(choroplethrZip)
library(dplyr)
library(raster)
library(rgeos)
library(ggmap)
library(ggplot2)

source("../doc/identifyNeighborhoodsAndBoroughs.R")
nycShapeFile <- shapefile("../data/nynta_16d/nynta.shp")
source("../doc/createHeatMap.R")

# Wifidata
# Load in and format Public WiFi locations
data1 <- read.csv("../data/Free_WiFi_Hotspots_09042005.csv", header=TRUE)
data2 <- read.csv("../data/LinkNYC_Locations.csv", header=TRUE)
data_c1 <- subset(data1, select=c(LON, LAT, SSID))
data_c2 <- subset(data2, select=c(Longitude, Latitude, CB.Link.ID))
colnames(data_c1) <- colnames(data_c2) <- c("LON", "LAT","network")

# Taxidata
data <- read.csv("../data/yellow_tripdata_2016-02.csv", header = T)
# Clean up taxi data by using both pickup/dropoff, removing empty coordinates, and removing likely erroneous coordinates.
pts <- as.data.frame(cbind(data$pickup_longitude, data$pickup_latitude, data$tpep_pickup_datetime))
colnames(pts) <- c("LON", "LAT", "TIME")
pts2 <- as.data.frame(cbind(data$dropoff_longitude, data$dropoff_latitude, data$tpep_dropoff_datetime))
colnames(pts2) <- c("LON", "LAT", "TIME")
pts3 <- as.data.frame(rbind(pts,pts2))
pts3$LON <- as.numeric(as.character(pts3$LON))
pts3$LAT <- as.numeric(as.character(pts3$LAT))
pts4 <- pts3[(pts3$LAT != 0) & (pts3$LON != 0),]
pts5 <- pts4[(pts4$LAT >= 38) & (pts4$LAT <= 44) & (pts4$LON <= -72) & (pts4$LON >= -76),]
# Remove the following line to use ALL taxi data
pts6 <- pts5[1:500000,]

# Load in shapefile
nycShapeFile <- shapefile("../data/nynta_16d/nynta.shp")

# Tag lat/lon coordinates with their respective neighborhood for taxi data
source("../doc/identifyNeighborhoodsAndBoroughs.R")
taxiData <- identifyNeighborhoodsAndBoroughs(pts6, nycShapeFile)

# Read in yelp data, combine with public wifi data, and then tag with respective neighborhood based on lon/lat
yelpData <- read.csv("../output/yelpdata.csv", header=TRUE)
yelpData <- subset(yelpData, select=-c(X))

wifiData <- as.data.frame(rbind(data_c1, data_c2, yelpData))
wifiData <- identifyNeighborhoodsAndBoroughs(wifiData, nycShapeFile)
wifiData <- subset(wifiData, select=-c(network))
taxiData <- subset(taxiData, select=-c(TIME))

getneighborhood<- function(df) {return(unique(df$neighborhood))}
wifi <- dlply(wifiData, .(borough), getneighborhood)
taxi <- dlply(taxiData, .(borough), getneighborhood)
