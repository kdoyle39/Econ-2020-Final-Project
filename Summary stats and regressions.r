# Importing packages
library(modelsummary)
library(xtable)
library(estimatr)
library(modelsummary)

# Summary stats
variables <- c("urban_share", "birth_rate", "illiterate_share", "modern_indus_optput_pc",
 "middle_class_share", "upper_class_share", "chr_minority_share", "commerce_share_male", "high_hc_occupation_male")

## Basic summary statistics
sum_stats <- summary(merged_dt[, .SD, .SDcols = variables])
write.csv(sum_stats, file = "Output/summary_statistics.csv")

## Correlation matrix
correlation_matrix <- cor(merged_dt[, ..variables, with = FALSE], use = "pairwise.complete.obs")
write.csv(correlation_matrix, file = "Output/correlation_matrix.csv")

## Averages by region
average_by_region <- merged_dt[, lapply(.SD, mean), by = Region, .SDcols = variables]
write.csv(average_by_region, file = "Output/average_by_region.csv")

# Regressions
## Birth rate and upper-tail human capital
### Birth rate
birth_OLS <- lm_robust(birth_rate ~ illiterate_share + modern_indus_optput_pc + mining_output_pc +
 upper_class_share + middle_class_share + chr_minority_share +
 other_minority_share + urban_share + Region_d, data = merged_dt)

### Upper-tail human capital
hc_OLS <- lm_robust(high_hc_occupation_male ~ illiterate_share + modern_indus_optput_pc + mining_output_pc +
 upper_class_share + middle_class_share + chr_minority_share +
 other_minority_share + urban_share + Region_d, data = merged_dt)

modelsummary(list("Births" = birth_OLS, "Upper-tale HC" = hc_OLS), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/births_hc.tex")
modelsummary(list("Births" = birth_OLS, "Upper-tale HC" = hc_OLS), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/births_hc.md")

## Regional differences
### Literacy
illiteracy_OLS_simple <- lm_robust(illiterate_share ~ Region_d, data = merged_dt)

illiteracy_OLS_controls <- lm_robust(illiterate_share ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + urban_share + Region_d, data = merged_dt)

### High education
high_educ_OLS_simple <- lm_robust(high_educ_share ~ Region_d, data = merged_dt)

high_educ_OLS_controls <- lm_robust(high_educ_share ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + urban_share + Region_d, data = merged_dt)

modelsummary(list("Illiteracy by Regions" = illiteracy_OLS_simple, "Illiteracy with Controls" = illiteracy_OLS_controls, "High Education by Regions" = high_educ_OLS_simple, "High Education with Controls" = high_educ_OLS_controls), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/region_differences.tex" )
modelsummary(list("Illiteracy by Regions" = illiteracy_OLS_simple, "Illiteracy with Controls" = illiteracy_OLS_controls, "High Education by Regions" = high_educ_OLS_simple, "High Education with Controls" = high_educ_OLS_controls), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/region_differences.md" )


## Gender differences
### Literacy
illiteracy_OLS_male <- lm_robust(illiterate_share_male ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + urban_share + Region_d, data = merged_dt)

illiteracy_OLS_female <- lm_robust(illiterate_share_female ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + urban_share + Region_d, data = merged_dt)

### Upper-tail human capital occupations
hc_OLS_male <- lm_robust(high_hc_occupation_male ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + Region_d + urban_share, data = merged_dt)

hc_OLS_female <- lm_robust(high_hc_occupation_female ~ modern_indus_optput_pc + mining_output_pc
+ upper_class_share + middle_class_share + chr_minority_share
+ other_minority_share + Region_d + urban_share, data = merged_dt)

modelsummary(list("Illiteracy Male" = illiteracy_OLS_male, "Illiteracy Female" = illiteracy_OLS_female, "HC Occupations Male" = hc_OLS_male, "HC Occupations Female" = hc_OLS_female), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/gender_gaps.tex" )
modelsummary(list("Illiteracy Male" = illiteracy_OLS_male, "Illiteracy Female" = illiteracy_OLS_female, "HC Occupations Male" = hc_OLS_male, "HC Occupations Female" = hc_OLS_female), gof_map = c("nobs", "r.squared", "adj.r.squared"), stars = TRUE, output = "Output/gender_gaps.md" )