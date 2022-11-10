
# Step 1. apply the vector addreses ####
addresses <- denhotspots::data_geocoden(infile = "positive_denmx_2022_10_17",
                                        data = FALSE,
                                        sinave_new = TRUE)

# Step 2. text manipulation ####
stringr::str_subset(addresses, "(?<=Colonia ).+(?= CENTRO)")
addresses <- stringr::str_replace_all(addresses,
                                      pattern = " VER,",
                                      replacement = " ,")


# Step 3. geocoding ###
library(ggmap)
denhotspots::geocoden(infile = "positive_denmx_2022_10_17")


# Step 4. load the dengue geocoded & dengue dataset #####
z <- readRDS("C:/Users/HOME/OneDrive/proyects/geocoding_mex/2022/positive_denmx_2022_10_17_temp_geocoded.rds")
data <- denhotspots::data_geocoden(infile = "positive_denmx_2022_10_17", 
                                   data = TRUE,
                                   sinave_new = TRUE)

# Step 5. save the results #####
denhotspots::save_geocoden(x = z,
                           y = data,
                           directory = "9.RData_geocoded",
                           loc = "positive_denmx_2022_10_17")

