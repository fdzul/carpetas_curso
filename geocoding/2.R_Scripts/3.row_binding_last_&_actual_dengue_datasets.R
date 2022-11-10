

# Step 1. load geocoded dengue dataset of the current week ###
load("C:/Users/HOME/OneDrive/proyects/geocoding_mex/2022/9.RData_geocoded/geo_den_mx_26_sonora_2022_09_26.RData")
y <- y[stringr::str_which(y$formatted_address,  " Sonora|Son"),]

# Step 2 load geocoded dengue dataset of the last week ###
load("C:/Users/HOME/OneDrive/proyects/geocoding_mex/2022/9.RData_geocoded/den22_sonora.RData")

# step 3. row binding ####
z <- rbind(z, y)

# Step 4. save the results ####
save(z, file = "9.RData_geocoded/den22_sonora.RData")

