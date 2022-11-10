#step 1. define the path for the historic dataset ####
path_vect <- "C:/Users/HOME/Dropbox/cenaprece_datasets/2022/31_yucatan"
path_coord <- paste(path_vect, "DescargaOvitrampasMesFco.txt", sep = "/")


# Step 2. run the spde model ####
x <- deneggs::eggs_hotspots_week(cve_mpo = "102",
                                   cve_edo = "31",
                                   year = "2022",
                                   hist_dataset = FALSE,
                                   locality = "Valladolid",
                                   path_vect = path_vect,
                                   path_coord = path_coord,
                                   integration_strategy = "eb",
                                   aproximation_method = "gaussian",
                                   fam_distribution = "zeroinflatednbinomial1",
                                   plot = FALSE,
                                   kvalue = 40,
                                   palette.viridis = "viridis",
                                   cell.size = 500,
                                   alpha.value = .99)

# Step 3. Visualize the hotspots intensity #### 
deneggs::eggs_hotspots_intensity_map(spde_betas = x$betas,
                                     years = 2022,
                                     locality = "Valladolid",
                                     cve_ent = "31",
                                     palette = rcartocolor::carto_pal,
                                     name = "SunsetDark")

