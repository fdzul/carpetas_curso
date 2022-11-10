# Step 1. load the dengue geocoded dataset ####
load("C:/Users/HOME/OneDrive/proyects/geocoding_mex/2022/9.RData_geocoded/den2022_positivos.RData")



# Step 2. extract the dengue cases #####
geocoded_dataset <- z |>
    dplyr::filter(ESTATUS_CASO == 2) |>
    dplyr::mutate(onset = FEC_INI_SIGNOS_SINT,
                  date = as.character(onset),
                  id = VEC_ID) |>
    dplyr::mutate(x = long,
                  y = lat) |>
    sf::st_as_sf(coords = c("long", "lat"),
                 crs = 4326) |>
    dplyr::select(x, y, onset) 

# Step 3. extract the locality ####
loc <- rgeomex::extract_locality(cve_edo = 26,
                                 locality = "Navojoa")


# Step 4. extract the dengue cases of the locality 
geocoded_dataset <- geocoded_dataset[loc,] |>
    sf::st_drop_geometry()

save(geocoded_dataset, 
     file = "8.RData/geocoded_dataset.RData")



# 2. aplicar la prueba de knox
library(magrittr)
knox_res <- denhotspots::knox(x = geocoded_dataset, 
                              crs = "+proj=eqc", 
                              ds = 400, 
                              dt = 20, 
                              sym = 1000, 
                              sp_link = FALSE,
                              planar_coord = FALSE)
# Mapa estatico
plotly::ggplotly(
    denhotspots::space_time_link_map(x = knox_res,
                                     locality = "Navojoa",
                                     cve_edo = "26",
                                     maptype = "staticmap",
                                     facetmap = FALSE))

denhotspots::space_time_link_map(x = knox_res,
                                 locality = "Hermosillo",
                                 cve_edo = "26",
                                 maptype = "staticmap",
                                 facetmap = FALSE)

# Mapa estático
denhotspots::space_time_link_map(x = knox_res,
                                 locality = "Hermosillo",
                                 cve_edo = "26",
                                 maptype = "staticmap",
                                 facetmap = TRUE)
# Mapa interactivo
denhotspots::space_time_link_map(x = knox_res,
                                 locality = "Hermosillo",
                                 cve_edo = "26",
                                 maptype = "interactive_map",
                                 facetmap = FALSE)



