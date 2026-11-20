# ------------------------------------------------------------
# File:    master.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: runs all scripts for Practicum 2
# Inputs:  cb_2024_us_county_500k.shp , nyshighpoints.csv
# Outputs: map
# ------------------------------------------------------------

# Load Packages - load once so every sourced script can use them.
library(sf)
library(dplyr)
library(ggplot2) 
library(tidycensus)

# Project folder found by here, so no hardcoded paths.
project_root <- here::here()

# Folder paths
raw_dir    <- file.path(project_root, "data", "raw")
script_dir <- file.path(project_root, "R") # Remove if scripts are in root
output_dir <- file.path(project_root, "output")
dir.create(output_dir, showWarnings = FALSE)

# Run scripts in order
source(file.path(script_dir, "00_setup.R"))
source(file.path(script_dir, "01_nys_counties.R"))
source(file.path(script_dir, "02_nys_highpoints.R"))
source(file.path(script_dir, "03_census.R"))
source(file.path(script_dir, "0X_analysis.R"))
