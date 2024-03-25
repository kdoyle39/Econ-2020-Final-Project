# Run the code for the final project.

## Get, clean, and merge the datasets.
source("The dataset.r")

## Add ne variables
source("New Variables.r")

## Present summary statistics and run regressions
source("Summary stats and regressions.r")

## Make plots
source("Graphs.r")

## Run Tests
testthat::local_edition(3)
testthat::test_dir("PlotFunction/tests")