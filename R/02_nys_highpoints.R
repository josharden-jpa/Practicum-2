# ------------------------------------------------------------
# File:    02_nys_highpoints.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: find and plot high points in each nys county
# Inputs:  cb_2024_us_county_500k.shp , nyshighpoints.csv
# Outputs: map 
# ------------------------------------------------------------

# Question 3 -
# Convert the plain CSV data frame into a spatial sf object
highpoints_sf <- st_as_sf(
  highpoint_data, 
  coords = c("Longitude", "Latitude"),
  crs = 4269
)

# Plot all county highpoints
nys_highpoints_map <- ggplot() +
  geom_sf(data = ny_counties, fill = "gray95", color = "gray40") +
  geom_sf(data = highpoints_sf, color = "red", size = 2) +
  theme_void() +
  labs(
    title = "New York State Highpoints by County",
    caption = "Source: U.S. Census Bureau & NYS High Points Data"
  )

print(nys_highpoints_map)

ggsave(
  filename = file.path(output_dir, "nys_highpoints_map.png"),
  plot = nys_highpoints_map,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)

# Question 4 - 
# Apply cartographer elevation scale
highpoints_elev_map_scaled <- ggplot() +
  geom_sf(data = ny_counties, fill = "gray85", color = "gray60", linewidth = 0.3) +
  geom_sf(data = highpoints_sf, aes(color = Elevation_Feet), size = 3) +
  scale_color_gradientn(
    colors = c("#2b7a3d", "#8cc665", "#f7e07f", "#b57c46", "#8c2d19", "#ffffff"),
    name = "Elevation (ft)"
  ) +
  theme_void() +
  labs(
    title = "New York State County High Points by Elevation",
    caption = "Source: U.S. Census Bureau & NYS High Points Data"
  )

# Fixed typo here to match the object name above
print(highpoints_elev_map_scaled)

ggsave(
  filename = file.path(output_dir, "nys_highpoints_map_scaled.png"),
  plot = highpoints_elev_map_scaled,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)

# Question 5 - 
# high and low points
highest <- highpoints_sf |>
  dplyr::filter(Elevation_Feet == max(Elevation_Feet, na.rm = TRUE))

elevation_high <- highest$Elevation_Feet

lowest <- highpoints_sf |>
  dplyr::filter(Elevation_Feet == min(Elevation_Feet, na.rm = TRUE))

elevation_low <- lowest$Elevation_Feet

# Lowest point (keeps geometry)
lowest <- highpoints_sf |>
  dplyr::filter(Elevation_Feet == min(Elevation_Feet, na.rm = TRUE))

elevation_low <- lowest$Elevation_Feet

# Question 6 -
# Label the highest high point on a map
nys_highest_point_map <- ggplot() +
  geom_sf(data = ny_counties, fill = "gray95", color = "gray40") +
  geom_sf(data = highest, color = "red", size = 3) +
  geom_sf_text(
    data = highest,
    aes(label = paste0(High_Point_Name, " (", Elevation_Feet, " ft)")),
    nudge_y = 0.25,
    fontface = "bold",
    size = 3.5
  ) +
  theme_void() +
  labs(
    title = "New York State's Highest Highpoint",
    caption = "Source: U.S. Census Bureau & NYS High Points Data"
  )

print(nys_highest_point_map)

ggsave(
  filename = file.path(output_dir, "nys_highest_point_map.png"),
  plot = nys_highest_point_map,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)
