# download files into R
neighborhoods <- read.csv("../output/neighborhood_centroids_latlong.csv", header=TRUE)

## comment out the dataset depending on the size/name of file which we are using
cabdata <- read.csv("../data/smallcabdata_noneighborhood.csv", header = TRUE)
# cabdata <- read.csv("../data/cabdata_noneighborhood.csv", header = TRUE)

# only use 100 rows of data to test for other parts of projs. comment out after not needed
cabdata <- cabdata[1:100, ]

# to select the columns needed, and also to flip lat and long columns
cabdata2 <- cabdata[, c(2, 4, 3)]


## sample functions from online which clusters cab data by neighborhoods:

distances <- outer(
  1:nrow(cabdata2),
  1:nrow(neighborhoods),
  Vectorize( function(i,j) {
    sum( (cabdata2[i,(2:3)] - neighborhoods[j,(3:4)])^2 )
  } )
)

# Find the nearest cluster
clusters <- apply(distances, 1, which.min)

# attach neighborhood to cab data
cabdata2$borough <- neighborhoods[clusters, "Borough"]
cabdata2$neighborhood <- neighborhoods[clusters, "NeighborhoodName"]

# write df into a csv file for use in other files later
write.csv(cabdata2, file = "../output/cab_neighborhood.csv", row.names = F)