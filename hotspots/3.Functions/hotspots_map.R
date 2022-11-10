hotspots_map <- function(cve_ent, locality, hotspots, static_map){
    if(static_map == TRUE){
        
    } else{
        
        # Step 1. extract the locality ####
        loc <- rgeomex::loc_inegi19_mx|>
            dplyr::filter(CVE_ENT %in% c(cve_ent)) |>
            dplyr::filter(NOMGEO %in% c(rgeomex::find_most_similar_string(locality, unique(NOMGEO)))) |>
            sf::st_make_valid()
        
        # Step 2. Extract the hotspots ####
        hotspots <- hotspots[loc,]
        
        
        # Step 3. define the palette ####
        pal <- leaflet::colorFactor(palette = rcartocolor::carto_pal(n = max(hotspots$intensity_gi), 
                                                                     name = "OrYel"), 
                                    domain = hotspots$intensity_gi)
        
        #pal <- leaflet::colorFactor(input$variablespalette, domain = hotspots$intensity_gi)
        
        # Step 4. add the label of each polygon ###
        hotspots$labels <- paste0("<strong> AGEB: </strong> ",
                                  hotspots$CVEGEO, "<br/> ",
                                  "<strong> intensidad: </strong> ",
                                  hotspots$intensity_gi, "<br/> ")  |>
            lapply(htmltools::HTML)
        
        
        # Step 5. leaflet map of hotspots ##### 
        l <- leaflet::leaflet(data = hotspots)  |>
            leaflet::addTiles()  |>
            leaflet::addPolygons(fillColor = ~pal(intensity_gi),
                                 color = "white",
                                 group = "Hotspots",
                                 weight = 1,
                                 fillOpacity = 0.7,
                                 label = ~labels,
                                 highlightOptions = leaflet::highlightOptions(color = "black",
                                                                              bringToFront = TRUE))  |>
            leaflet::addLegend(pal = pal, 
                               values = ~intensity_gi,
                               opacity = 0.7,
                               title = "Intensidad")
        # Add the layer
        esri <- grep("^Esri|CartoDB|OpenStreetMap", leaflet::providers, value = TRUE)
        for (provider in esri) {
            l <- l  |> leaflet::addProviderTiles(provider, 
                                                 group = provider)
        }
        
        
        l  |>
            leaflet::addLayersControl(baseGroups = names(esri),
                                      options = leaflet::layersControlOptions(collapsed = TRUE),
                                      overlayGroups = c("Hotspots"))  |>
            leaflet::addMiniMap(tiles = esri[[1]], 
                                toggleDisplay = TRUE,
                                minimized = TRUE,
                                position = "bottomleft")  |>
            htmlwidgets::onRender("
    function(el, x) {
      var myMap = this;
      myMap.on('baselayerchange',
        function (e) {
          myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
        })
    }")
        
    }
    
}
