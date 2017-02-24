### GU4243/GR5243 Spring 2017 Applied Data Science
### Project 2 Shiny App Development: Busy Signal
### - for [data.gov](https://www.data.gov/) open data

The objective of our project is to map out the areas which have high human traffic (and consequently high demand for wifi) and the areas with free wifi hotspots provided. By overlaying both heat maps, we can get an intuitive sense of the areas which are adequately covered with or not. Using this information, business owners can decide if there is potential for them to gain a "competitive advantage" by providing wifi to their customers. 

To implement the project, we used 3 main sources of data: Yelp API, LinkNYC (data.gov datasets on free wifi hotspots) and yellow cab data. Using the Yelp and LinkNYC data, we mapped out the "supply" of wifi locations. On the other hand, we used yellow cab data as a proxy for how much human traffic there are at any spot.

The heat maps are also categorized by boroughs and neighborhoods. We did this by checking every wifi hotspot or yellow cab pick-up/drop-off's latitude and longtitude coordinates against the "shapefile" of NYC which holds all neighborhood and borough information.



