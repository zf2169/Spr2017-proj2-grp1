#Create actually heat map

library("ggmap")
createComboHeatMap
c(neighborhood="empty", borough, wifiData, taxiData, mapColor1="blue", mapColor2="red")

setwd("/Users/xuehan/Desktop/Spr2017-proj2-grp1/data/")

borough<-c("Manhattan","Bronx","Queens","Brooklyn","Staten_Island")
  
borough_centroids<-read.csv("neighborhoods.csv")
head(borough_centroids)

cabdata<-read.csv("cabneighborhood.csv")
head(cabdata)

wifidata<-read.csv("ManhattanHousing.csv")
head(wifidata)

NYC_location<-read.csv("LinkNYC_Locations.csv")
head(NYC_location)

createComboHeatMap(neighborhood="empty",borough,wifidata,cabdata)
