# Importing packages
library(ggplot2)
library(ggthemes)
library(patchwork)
library(tidyr)

devtools::install("PlotFunction")
library(PlotFunction)

# Regional differences
## Creating a table summarizing regional differences in three indices
region_dif_table <- merged_dt[, lapply(.("Urban Population" = urban_share, "Literacy Rates" = 1 - illiterate_share,
 "Christian Minorities" = chr_minority_share), mean), by = Region] |>
 melt(id.vars = "Region", variable.name = "Indices")

## Plotting the figure
region_dif_plot <- region_dif_table |>
ggplot(aes(x = Region, y = value, fill = Indices)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.65) +
  scale_fill_manual(values = c("Urban Population" = "#2c0f50", "Literacy Rates" = "#97a218", "Christian Minorities" = "#831616")) +
  labs(x = "Region", title = "Regional Differences") +
  theme_economist() +
  theme(axis.text.x = element_text(size = 8))

ggsave("Output/regional_differences.pdf", region_dif_plot, width = 18, height = 10, units = "cm")

# Upper-tale HC occupations
## Correlation with urbanization
hc_urban_male_plt <- create_hc_plt("urban_share", "high_hc_occupation_male", "Region", "Upper-tale HC Occupations and Urbanization (male)",
"Urban Share")
hc_urban_female_plt <- create_hc_plt("urban_share", "high_hc_occupation_female", "Region", "Upper-tale HC Occupations and Urbanization (female)",
"Urban Share")

## Correlation with industrialization
hc_indus_male_plt <- create_hc_plt("modern_indus_optput_pc", "high_hc_occupation_male", "Region", "Upper-tale HC Occupations and Industrialization (male)",
"Industrial Output pc")
hc_indus_female_plt <- create_hc_plt("modern_indus_optput_pc", "high_hc_occupation_female", "Region", "Upper-tale HC Occupations and Industrialization (female)",
"Industrial Output pc")

## Stacking the plots
hc_comb_plt <- (hc_urban_male_plt | hc_urban_female_plt) / (hc_indus_male_plt | hc_indus_female_plt)
ggsave("Output/hc_plot.pdf", hc_comb_plt, width = 40, height = 24, units = "cm")