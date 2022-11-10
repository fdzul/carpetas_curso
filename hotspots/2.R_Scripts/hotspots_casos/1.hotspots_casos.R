# Step 1. load the dengue geocoded dataset ####
load("C:/Users/HOME/OneDrive/proyects/priority_research_projects/hotspots_high_risk_localities_138/8.RData/geocoded_dataset.RData")


# Step 2. extract the locality #####
x <- rgeomex::extract_ageb(locality = c("Guadalajara", "Zapopan", 
                                        "Tlaquepaque", "Tonalá"), 
                           cve_geo = "14")


# Step 3. cases by ageb ####
library(magrittr)
z <- denhotspots::point_to_polygons(x = y,
                                    y = x$ageb,
                                    ids = names(x$ageb)[-10],
                                    time = ANO,
                                    coords = c("long", "lat"),
                                    crs = 4326,
                                    dis = "DENV")

# Step 4. calculate the hotspots ####
hotspots <- denhotspots::gihi(x = z,
                              id = names(z)[c(1:9)], 
                              time = "year",
                              dis = "DENV",
                              gi_hi = "gi",
                              alpha = 0.95)



# Step 1. static map
denhotspots::staticmap_intensity(x = hotspots,
                                 pal = rcartocolor::carto_pal,
                                 pal_name = TRUE,
                                 name = "OrYel",
                                 breaks = 1,
                                 dir_pal = -1,
                                 x_leg = 0.5,
                                 y_leg = 0.1,
                                 ageb = TRUE)

# Step 2. interactive map 

source("C:/Users/HOME/Desktop/hotspots/3.Functions/hotspots_map.R")
hotspots_map(cve_ent = "14",
             locality = c("Guadalajara", "Zapopan", 
                          "Tlaquepaque", "Tonalá"),
             hotspots = hotspots,
             static_map = FALSE)

hotspots$intensity <- factor(hotspots$intensity_gi)
mapview::mapview(hotspots, 
                 zcol = "intensity",
                 layer.name = "Intensidad",
                 color = "white",
                 col.regions = rcartocolor::carto_pal(n = 9, 
                                                      name = "OrYel"))

