# ------------------------------------------------------------
# File:    00_setup.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: loads shape file and reads csv
# Inputs:  cb_2024_us_county_500k.shp , nyshighpoints.csv
# Outputs: none (objects are loaded into the session)
# ------------------------------------------------------------

map_data <- st_read(file.path(raw_dir, "cb_2024_us_county_500k.shp"))

ny_counties <- map_data |> 
  filter(STATEFP == "36")

highpoint_data <- read.csv(file.path(raw_dir, "nyshighpoints.csv"))

# Load NY county population (ACS 5-year estimates)
ny_pop <- get_acs(
  geography = "county",
  variables = "B01003_001",
  state = "NY",
  year = 2023,
  geometry = FALSE 
) |>
  dplyr::select(GEOID, NAME, population = estimate)

# join ny_pop onto ny_counties, adding population column
ny_counties <- ny_counties |>
  dplyr::left_join(
    ny_pop |> dplyr::select(GEOID, population),
    by = "GEOID"
  )

# add population density column. convert sq meters to sq miles first
ny_counties <- ny_counties |>
  dplyr::mutate(
    land_sq_miles = ALAND / 2589988.11,
    pop_density   = population / land_sq_miles
  )

