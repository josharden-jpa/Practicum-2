# ------------------------------------------------------------
# File:    00_setup.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: filter county shape ile to NYS counties and plot
# Inputs:  cb_2024_us_county_500k.shp , nyshighpoints.csv
# Outputs: map 
# ------------------------------------------------------------

# Question 1 -
# Create the base New York county map
ny_map <- ggplot(data = ny_counties) +
  geom_sf(fill = "gray95", color = "gray40", linewidth = 0.3) +
  theme_void() +
  labs(
    title = "New York State Counties",
    caption = "Source: U.S. Census Bureau (2024)"
  )

# Print the map to the RStudio Plots pane
print(ny_map)

# Save a high-res copy to your output folder
ggsave(
  filename = file.path(output_dir, "ny_counties_map.png"),
  plot = ny_map,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)

# Question 2 - 
# Find the largest and smallest county by land area (ALAND is in square meters)
biggest <- ny_counties |>
  st_drop_geometry() |>
  slice_max(ALAND, n = 1)

smallest <- ny_counties |>
  st_drop_geometry() |>
  slice_min(ALAND, n = 1)

# Convert square meters to square miles for readability
sq_miles_big <- round(biggest$ALAND / 2589988.11, 1)
sq_miles_small <- round(smallest$ALAND / 2589988.11, 1)

# Question 9 -

# Total population
most_pop <- ny_counties |>
  slice_max(population, n = 1)

least_pop <- ny_counties |>
  slice_min(population, n = 1)

# Population density
most_dense <- ny_counties |>
  slice_max(pop_density, n = 1)

least_dense <- ny_counties |>
  slice_min(pop_density, n = 1)