# timeline

library(timevis)

events <- c(
  "1904-01-01", NA,
  "Protection of the Marikina Watershed\nReserve (MWR) (25,913.15 ha)",
  "1915-01-01", "1996-01-01",
  "Reduction of MWR: private entities, resettlements, waste disposal",
  "1977-01-01", NA, "Established as National Park, Wildlife and Game Preserve",
  "1990-01-01", NA, "Social Forestry Program (1,430 ha)",
  "2009-01-01", NA, "Typhoon Ondoy",
  "2011-01-01", NA, "Creation of UMRBPL",
  "2018-01-01", NA, "E-NIPAS Act UMRBPL Legislation (26,125.64 ha)"
) |>
  matrix(ncol = 3, byrow = TRUE) |>
  data.frame()
colnames(events) <- c("start", "end", "content")

timevis(events)

# maps
library(sf)
library(ggmap)

setwd("D:/github/marikina_carbon/")
area <- list.files("data/umrbpl/", full.names = TRUE, pattern = "shp$") |>
  st_read() |>
  st_transform(4326)
extent_luzon <- c(120.7, 121.5, 14.2, 15)

ggmap::register_stadiamaps("58592694-cca0-4f51-8e39-b215d7e3f341")
basemap <- get_stadiamap(
  c(
    left = extent_luzon[1], right = extent_luzon[2],
    bottom = extent_luzon[3], top = extent_luzon[4]
  ),
  zoom = 10, maptype = "stamen_terrain"
)
ggmap(basemap) +
  geom_sf(data = area, inherit.aes = FALSE, fill = "#FF000060", color = "red") +
  labs(x = NULL, y = NULL)
