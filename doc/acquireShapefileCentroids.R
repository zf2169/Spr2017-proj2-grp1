acquireShapefileCentroids <- function(shapefileDir) {
  
  require("GISTools")
  library(GISTools)
  library(rgeos)
  
  nycShapeFile <- shapefile(shapefileDir)
  sids <- readShapePoly(shapefileDir, 
                        proj4string=CRS("+proj=longlat +datum=WGS84"))
  
  neighNames <- sids$NTAName
  
  trueCentroids <- gCentroid(nycShapeFile,byid=TRUE)
  trueCentroids <- spTransform(trueCentroids, CRS("+proj=longlat +datum=WGS84"))
  centroids <- as.data.frame(coordinates(trueCentroids))
  colnames(centroids) <- c("LON", "LAT")
  centroids$neighborhood <- neighNames
  
  return(centroids)
  
}
