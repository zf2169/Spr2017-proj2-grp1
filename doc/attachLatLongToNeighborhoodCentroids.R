install.packages("tidyr")
require("tidyr")

# download files into R
neighborhood.names <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/data/neighborhoods.csv", header=TRUE)
neighborhood.centroid <- read.csv("/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/neighborhood_centroid.csv", header = TRUE)

# change neighborhood names df by borough into a "long" df
neighborhood.names <- gather(neighborhood.names)
colnames(neighborhood.names) <- c("Borough", "NeighborhoodName")

# change neighborhood centroid's lat/long df into a "long" df
neighborhood.centroid <- reshape(neighborhood.centroid, direction = "long",
        varying = colnames(neighborhood.centroid), 
        timevar = 'borough',
        times = c("Manhattan ", "Bronx ", "Queens ", "Brooklyn ", "Staten Island "),
        v.names = c("lat", "lon")
)

neighborhood.centroid2 <- neighborhood.centroid[, 2:3]

# combine both the df into 1 and remove NAs, adding neighborhood IDs
neighborhood.draft <- cbind(neighborhood.names, neighborhood.centroid2)
neighborhood.draft <- neighborhood.draft[which(!is.na(neighborhood.draft$lat)), ]
neighborhood.draft$NeighborhoodID <- 1:nrow(neighborhood.draft)

# write df into a csv file for use in other files later
write.csv(neighborhood.draft, file = "/Users/xuehan/Desktop/Spr2017-proj2-grp1/output/neighborhood_centroids_latlong.csv", row.names = F)
