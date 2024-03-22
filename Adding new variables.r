# Generating variables
## Population
merged_dt[, tot_pop := Rural_Female + Rural_Male + Urban_Female + Urban_Male]
merged_dt[, urban_pop := Urban_Female + Urban_Male]
merged_dt[, male := Urban_Male + Rural_Male]
merged_dt[, urban_share := urban_pop / tot_pop]
merged_dt[, birth_rate := 1000 * n_births / tot_pop]
merged_dt[, kids_less_six_urban_share := (Up_to_six_years_Female_Urban + Up_to_six_years_Male_Urban) / urban_pop]
merged_dt[, kids_less_six_rural_share := (Up_to_six_years_Female_Rural + Up_to_six_years_Male_Rural) / (tot_pop - urban_pop)]

## Education
merged_dt[, illiterate_share := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = patterns("^Illiterate_")]
merged_dt[, illiterate_share_male := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = patterns("^Illiterate_Male_")]
merged_dt[, illiterate_share_female := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = patterns("^Illiterate_Female_")]

merged_dt[, high_educ_share := rowSums(.SD) / tot_pop,
 .SDcols = patterns("^Literate_studying_at_universities_and_other_higher_educational_institutions_")]


## Industry
merged_dt[, modern_indus_optput_pc := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
  "Manufacture_of_basic_metals",
  "Manufacture_of_chemicals_and_chemical_products",
  "Manufacture_of_coke_refined_petroleum_products_and_nuclear_fuel",
  "Manufacture_of_electrical_machinery_and_apparatus_n.e.c.",
  "Manufacture_of_fabricated_metal_products_except_machinery_and_equipment",
  "Manufacture_of_machinery_and_equipment_n.e.c.",
  "Manufacture_of_medical_precision_and_optical_instruments_watches_and_clocks",
  "Manufacture_of_other_transport_equipment",
  "Manufacture_of_pulp_paper_and_paper_products",
  "Manufacture_of_rubber_and_plastic_products"
)]

merged_dt[, mining_output_pc := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
  "Extraction_of_crude_petroleum_and_natural_gas_service_activities_incidental_to_oil_and_gas_extraction_excluding_surveying",
  "Mining_of_coal_and_lignite_extraction_of_peat",
  "Mining_of_metal_ores",
  "Other_mining_and_quarrying"
)]

## Estates
merged_dt[, upper_class_share := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
"Clergy_of_all_Christian_faiths_and_their_families_Male",
"Clergy_of_all_Christian_faiths_and_their_families_Female",
"Hereditary_and_personal_honorary_citizens_and_their_families_Male",
"Hereditary_and_personal_honorary_citizens_and_their_families_Female",
"Hereditary_nobility_and_their_families_Male",
"Hereditary_nobility_and_their_families_Female",
"Personal_nobility_officials_not_from_nobility_and_their_families_Male",
"Personal_nobility_officials_not_from_nobility_and_their_families_Female"
)]

merged_dt[, middle_class_share := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
"Merchants_and_their_families_Male",
"Merchants_and_their_families_Female",
"Urban_commoners_Male",
"Urban_commoners_Female"
)]

## Religion
merged_dt[, chr_minority_share := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
  "Catholics", "Old_Believers", "Other_Christians", "Protestants"
)]

merged_dt[, other_minority_share := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
  "Buddhists", "Other_confessions", "Jews", "Muslims"
)]

## Occupations
merged_dt[, commerce_share_male := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
"Carrier_trade_Male",
"Commercial_brokerage_services_Male",
"Credit_and_public_commercial_institutions_Male",
"Subsisting_at_expense_of_public_treasury_social_institutions_and_private_individuals_Male",
"Trade_in_articles_of_luxury_science_art_culture_etc._Male",
"Trade_in_construction_materials_and_fuels_Male",
"Trade_in_fabrics_and_garments_Male",
"Trade_in_grain_products_Male",
"Trade_in_household_articles_Male",
"Trade_in_leather_fur_etc._Male",
"Trade_in_live_livestock_Male",
"Trade_in_metal_goods_machines_and_weapons_Male",
"Trade_in_other_agricultural_products_Male",
"Trade_in_other_articles_Male",
"Trade_overall_Male"
)]

merged_dt[, commerce_share_female := rowSums(.SD, na.rm = TRUE) / (tot_pop - male), .SDcols = c(
"Carrier_trade_Female",
"Commercial_brokerage_services_Female",
"Credit_and_public_commercial_institutions_Female",
"Subsisting_at_expense_of_public_treasury_social_institutions_and_private_individuals_Female",
"Trade_in_articles_of_luxury_science_art_culture_etc._Female",
"Trade_in_construction_materials_and_fuels_Female",
"Trade_in_fabrics_and_garments_Female",
"Trade_in_grain_products_Female",
"Trade_in_household_articles_Female",
"Trade_in_leather_fur_etc._Female",
"Trade_in_live_livestock_Female",
"Trade_in_metal_goods_machines_and_weapons_Female",
"Trade_in_other_agricultural_products_Female",
"Trade_in_other_articles_Female",
"Trade_overall_Female"
)]

merged_dt[, high_hc_occupation_male := rowSums(.SD, na.rm = TRUE) / tot_pop, .SDcols = c(
"Carrier_trade_Male",
"Commercial_brokerage_services_Male",
"Credit_and_public_commercial_institutions_Male",
"Education_services_Male",
"Medical_and_health_services_Male",
"Ministry_in_nonChristian_faiths_Male",
"Ministry_in_other_Christian_faiths_Male",
"Ministry_in_the_Orthodox_faith_Male",
"Officials_at_churches_mosques_synagogues_prayer_houses_cemetaries_etc._their_servants_and_caretakers_Male",
"Science_literature_and_art_Male",
"Service_in_charitable_institutions_Male"
)]

merged_dt[, high_hc_occupation_female := rowSums(.SD, na.rm = TRUE) / (tot_pop - male), .SDcols = c(
"Carrier_trade_Female",
"Commercial_brokerage_services_Female",
"Credit_and_public_commercial_institutions_Female",
"Education_services_Female",
"Medical_and_health_services_Female",
"Ministry_in_nonChristian_faiths_Female",
"Ministry_in_other_Christian_faiths_Female",
"Ministry_in_the_Orthodox_faith_Female",
"Officials_at_churches_mosques_synagogues_prayer_houses_cemetaries_etc._their_servants_and_caretakers_Female",
"Science_literature_and_art_Female",
"Service_in_charitable_institutions_Female"
)]

## Regions
merged_dt[, Region := 
            ifelse(Territory %in% c("Kalisz governorate", "Warsaw governorate", "Vilna governorate", "Grodno governorate", "Kovno governorate", "Kurland governorate", "Livonia governorate", "Łomża governorate", "Lublin governorate", "Minsk governorate", "Mogilev governorate", "Podolsk governorate", "Pskov governorate", "Radom governorate", "Suwałki governorate", "Estonia governorate", "Kielce governorate", "Piotrków governorate", "Płock governorate", "Siedlce governorate", "St. Petersburg governorate", "Vitebsk governorate", "Volhynian governorate", "Vyborg governorate"), "Western",
            ifelse(Territory %in% c("Arkhangelsk governorate", "Vladimir governorate", "Vologda governorate", "Yaroslavl governorate", "Moscow governorate", "Nizhny Novgorod governorate", "Novgorod governorate", "Olonets governorate", "Orel governorate", "Penza governorate", "Ryazan governorate", "Smolensk governorate", "Tver governorate", "Tula governorate", "Kaluga governorate", "Kazan governorate", "Kostroma governorate", "Simbirsk governorate", "Ural region", "Samara governorate", "Tambov governorate", "Viatka governorate"), "Central",
            ifelse(Territory %in% c("Elisabethpol governorate", "Ekaterinoslav governorate", "Kharkov governorate", "Kherson governorate", "Kursk governorate", "Odessa governorate", "Poltava governorate", "Saratov governorate", "Stavropol governorate", "Taurida governorate", "Bessarabia governorate", "Chernigov governorate", "Don Cossack host lands", "Kiev governorate", "Voronezh governorate"), "Southern",
            ifelse(Territory %in% c("Amur region", "Irkutsk governorate", "Primorskaya region", "Sakhalin island", "Transbaikal region", "Yakutsk region", "Enisei governorate", "Perm governorate", "Tobolsk governorate", "Orenburg governorate", "Tomsk governorate", "Ufa governorate"), "Eastern",
            ifelse(Territory %in% c("Astrakhan governorate", "Baku governorate", "Akmola region", "Samarkand region", "Syr-Darya region", "Fergana region", "Semipalatinsk region", "Semirechye region", "Turgay region", "Terek region", "Dagestan region", "Erevan governorate", "Kars governorate", "Tiflis governorate incl. Zakatalskii district", "Black Sea governorate", "Kutaisi governorate incl. Sukhumi district", "Transcaspian region", "Kuban region"), "Cental_Asia_Caucasus", NA)))))]

merged_dt$Region_d <- factor(merged_dt$Region)