
# Step 1. Subir la base de datos de dengue de la semana pasada #####
y  <- denhotspots::read_dengue_dataset() 

# Step 2. Subir la base de datos de la semana actual ####
x  <- denhotspots::read_dengue_dataset() 


# Step 3. extract the ids not geocoded ###
z <- x |>
    dplyr::filter(!VEC_ID %in% c(y$VEC_ID)) |>
    dplyr::arrange(VEC_ID)


# Step 3. save the results ####
write.csv(z, file = "positive_denmx_2022_10_17.csv")
