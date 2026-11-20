# ------------------------------------------------------------
# File:    0X_analysis.R
# Author:  Josh Arden
# Course:  DWV Fall 2026, Practicum 2 (New York Maps)
# Date:    2026-11-20
# Purpose: analyze outputs
# Inputs:  cb_2024_us_county_500k.shp , nyshighpoints.csv
# Outputs: text file 
# ------------------------------------------------------------


# Write the formatted Q&A directly to a text file
answers <- c(
  "PRACTICUM 2 - DATA ANALYSIS SUMMARY",
  "-----------------------------------",
  paste0("Q2a: What is the largest NY county by land area?"),
  paste0("A2a: ", biggest$NAME, " County (", sq_miles_big, " sq miles)"),
  paste0("Q2b: What is the smallest NY county by land area?"),
  paste0("A2b: ", smallest$NAME, " County (", sq_miles_small, " sq miles)"),
  paste0("Q5a: What is the highest point in the state?"),
  paste0("A5a: The highest point is ", elevation_high, " feet, named ", highest$High_Point_Name),
  paste0("Q5b: What is the lowest high point in the state?"),
  paste0("A5b: The lowest high point is ", elevation_low, " feet, named ", lowest$High_Point_Name),
  paste0("Q9a: Most Populous County: ", most_pop$NAME, " (", scales::comma(most_pop$population), ")"),
  paste0("Q9a: Least Populous County: ", least_pop$NAME, " (", scales::comma(least_pop$population), ")"),
  paste0("Q9b: Most Densely Populated: ", most_dense$NAME, " (", scales::comma(round(most_dense$pop_density, 1)), " / sq mi)"),
  paste0("Q9b: Least Densely Populated: ", least_dense$NAME, " (", scales::comma(round(least_dense$pop_density, 1)), " / sq mi)")
)

writeLines(answers, file.path(output_dir, "analysis_answers.txt"))
