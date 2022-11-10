


# Hotspots eggs
deneggs::eggs_hotspots(path_lect = "C:/Users/HOME/Dropbox/cenaprece_datasets/2022/14_jalisco",
                       cve_ent = "14",
                       locality  = c("Guadalajara", "Zapopan",
                                     "Tlaquepaque", "Tonala"),
                       path_coord = "C:/Users/HOME/Dropbox/cenaprece_datasets/2022/14_jalisco/DescargaOvitrampasMesFco.txt",
                       longitude  = "Pocision_X",
                       latitude =  "Pocision_Y",
                       aproximation = "gaussian",
                       integration = "eb",
                       fam = "zeroinflatednbinomial1",
                       k = 40,
                       palette_vir  = "magma",
                       leg_title = "Huevos",
                       plot = FALSE,
                       hist_dataset = FALSE,
                       sem = 40,
                       var = "eggs",
                       cell_size = 2000,
                       alpha = .99)