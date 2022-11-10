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
loc <- rgeomex::extract_locality(cve_edo = 31,
                                 locality = "Mérida")


# Step 4. extract the dengue cases of the locality 
geocoded_dataset <- geocoded_dataset[loc,] |>
    sf::st_drop_geometry()


# Step 5. map of lgcp 
library(magrittr)
library(ggplot2)
library(sf)
library(sp)
library(plotly)
library(htmlwidgets)

X <- denhotspots::spatial_lgcp(dataset = geocoded_dataset,
                           locality = "Merida",
                           cve_edo = "31",
                           longitude = "x",
                           latitude = "y",
                           k = 30,
                           plot = FALSE,
                           aproximation = "gaussian",
                           integration = "laplace",
                           resolution = 0.015,
                           approach = "lattice",
                           cell_size = 1500,
                           name = "YlGnBu")


