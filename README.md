# Econ-2020-Final-Project

This project explores various economic and social aspects of Russian industrialization in the late 19th century.

## Main Script: main.r

The `main.r` script conducts the entire analysis in the following sequence:

### 1. Dataset Preparation: dataset.r

- Loads eight datasets.
- Selects relevant columns from each dataset, cleans the data, and reshapes it to a wide format.
- Merges the updated datasets.

### 2. Creation of New Variables: new_variables.r

- Introduces new variables categorized into several groups into the merged dataset.

### 3. Summary Statistics and Regression Analysis

- Provides summary statistics, including a correlation matrix and a table averaging by region.
- Conducts Ordinary Least Squares (OLS) regressions on the following topics:
    1. Factors associated with birth rates and indices of upper-tail human capital occupations.
    2. Regional disparities in literacy rates and higher education.
    3. Factors associated with literacy rates and upper-tail human capital occupations among men and women.
- Utilizes the `modelsummary` function to save all regression results.

### 4. Graphical Representation

- Visualizes regional differences in various indices.
- Utilizes the `create_hc_plt` function from the "PlotFunction" package to generate four scatter plots with linear regression lines.
- Saves all plots in PDF format.

### 5. Testing of PlotFunction

- Executes a test to verify the functionality of the `create_hc_plt` function in generating figures.