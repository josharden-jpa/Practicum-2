# ------------------------------------------------------------
# File:    03_census.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: plot county population statistics
# Inputs:
# Outputs: map 
# ------------------------------------------------------------

# plot ny counties, shaded by population

ny_pop_map <- ggplot(data = ny_counties) +
  geom_sf(aes(fill = population), color = "white", linewidth = 0.25) +
  scale_fill_gradient(
    low = "#ffffcc",       # Light yellow
    high = "#d95f0e",      # Dark orange 
    labels = scales::comma,
    name = "Population"
  ) +
  theme_void() +
  labs(
    title = "New York State Population by County",
    caption = "Source: U.S. Census Bureau"
  )

print(ny_pop_map)


ggsave(
  filename = file.path(output_dir, "nys_county_population_map.png"),
  plot = ny_pop_map,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)

# plot NY counties shaded by population density
# use log scale since Manhattan is ~70,000/sq mi vs ~3/sq mi in Hamilton County

ny_density_map <- ggplot(data = ny_counties) +
  geom_sf(aes(fill = pop_density), color = "gray40", linewidth = 0.25) +
  scale_fill_gradient(
    low = "#f3e5f5",       # Light lavender
    high = "#4a148c",      # Dark purple
    trans = "log10",       
    labels = scales::comma,
    name = "People / Sq. Mile"
  ) +
  theme_void() +
  labs(
    title = "New York State Population Density by County",
    caption = "Source: U.S. Census Bureau"
  )

print(ny_density_map)

ggsave(
  filename = file.path(output_dir, "ny_pop_density_map.png"),
  plot = ny_density_map,
  width = 8,
  height = 6,
  dpi = 300,
  bg = "white"
)
