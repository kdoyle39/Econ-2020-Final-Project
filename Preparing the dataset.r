# Importing packages
library(data.table)
library(readxl)

# Reading in the data files and converting into data.table objects
pop_dt <- read_excel("Data/1897/Population (Gender, Settlement).xlsx")
educ_dt <- read_excel("Data/1897/Education (Gender, Settlement).xlsx")
indus_dt <- read_excel("Data/1897/Industrial output (Field, in Roubles).xlsx")
estates_dt <- read_excel("Data/1897/Population (Estates).xlsx")
births_dt <- read_excel("Data/1897/Population (Births).xlsx")
denomination_dt <- read_excel("Data/1897/Population (Denomination).xlsx")
dem_dist_dt <- read_excel("Data/1897/Population (Gender, Age, Settlement).xlsx")
profession_dt <- read_excel("Data/1897/Profession (Gender).xlsx")

dt_names <- c("pop_dt", "educ_dt", "indus_dt", "estates_dt", "births_dt", "denomination_dt", "dem_dist_dt",
"profession_dt")

for(dt_name in dt_names) {
  assign(dt_name, as.data.table(get(dt_name)))
}

# Selecting columns, cleaning and reshaping to wide: Population settlement and gender
pop_dt <- pop_dt[,.(Territory = TERRITORY, Value = VALUE, Settlement = CLASS1, Gender = CLASS3)]
pop_dt$Value <- as.numeric(pop_dt$Value)

pop_dt <- dcast(pop_dt, Territory ~ Settlement + Gender, value.var = "Value", fun.aggregate = mean)

# Selecting columns, cleaning and reshaping to wide: Education
educ_dt <- educ_dt[,.(Territory = TERRITORY, Value = VALUE, Education = HISTCLASS1, Gender = HISTCLASS2, Settlement = CLASS3)]
educ_dt[, Education := gsub(" ", "_", Education)]
educ_dt[, Education := gsub(",", "", Education)]
educ_dt$Value <- as.numeric(educ_dt$Value)

educ_dt <- dcast(educ_dt, Territory ~ Education + Gender + Settlement, value.var = "Value", fun.aggregate = mean)

# Selecting columns, cleaning and reshaping to wide: Industrial output
indus_dt <- indus_dt[,.(Territory = TERRITORY, Value = VALUE, Industry = CLASS3)]
indus_dt[, Industry := substr(Industry, 6, nchar(Industry))]
indus_dt[, Industry := gsub(" ", "_", Industry)]
indus_dt[, Industry := gsub(";", "", Industry)]
indus_dt[, Industry := gsub(",", "", Industry)]
indus_dt$Value <- as.numeric(indus_dt$Value)

indus_dt <- dcast(indus_dt, Territory ~ Industry, value.var = "Value", fun.aggregate = mean)

# Selecting columns, cleaning and reshaping to wide: Estates
estates_dt <- estates_dt[,.(Territory = TERRITORY, Value = VALUE, Estate = HISTCLASS1, Gender = HISTCLASS2)]
estates_dt[, Estate := gsub(" ", "_", Estate)]
estates_dt[, Estate := gsub(",", "", Estate)]
estates_dt[, Estate := gsub("-", "", Estate)]
estates_dt$Value <- as.numeric(estates_dt$Value)

estates_dt <- dcast(estates_dt, Territory ~ Estate + Gender, value.var = "Value", fun.aggregate = mean)

# Selecting columns and cleaning: Birth
births_dt <- births_dt[,.(Territory = TERRITORY, n_births = VALUE)]
births_dt$n_births <- as.numeric(births_dt$n_births)

# Selecting columns, cleaning and reshaping to wide: Denominations
denomination_dt <- denomination_dt[,.(Territory = TERRITORY, Value = VALUE, Denomination = CLASS1)]
denomination_dt[, Denomination := gsub(" ", "_", Denomination)]
denomination_dt$Value <- as.numeric(denomination_dt$Value)

denomination_dt <- dcast(denomination_dt, Territory ~ Denomination, value.var = "Value", fun.aggregate = mean)

# Selecting columns, cleaning and reshaping to wide: Demographic distribution
dem_dist_dt <- dem_dist_dt[,.(Territory = TERRITORY, Value = VALUE, Age = CLASS1, Gender = CLASS3, Settlement = CLASS4)]
dem_dist_dt[, Age := gsub(" ", "_", Age)]
dem_dist_dt[, Age := gsub("100> years", "110", Age)]
dem_dist_dt[, Age := gsub("Age unknown", "unknown", Age)]
dem_dist_dt[, Settlement := gsub("No rural-urban breakdown", "unknown", Settlement)]
dem_dist_dt$Value <- as.numeric(dem_dist_dt$Value)

dem_dist_dt <- dcast(dem_dist_dt, Territory ~ Age + Gender + Settlement, value.var = "Value", fun.aggregate = mean)

# Selecting columns, cleaning and reshaping to wide: Occupations
profession_dt <- profession_dt[,.(Territory = TERRITORY, Value = VALUE, Occupation = HISTCLASS1, Gender = HISTCLASS3)]
profession_dt[, Occupation := substr(Occupation, 3, nchar(Occupation))]
profession_dt[, Occupation := gsub(" ", "_", Occupation)]
profession_dt[, Occupation := gsub(",", "", Occupation)]
profession_dt[, Occupation := gsub(";", "", Occupation)]
profession_dt[, Occupation := gsub("-", "", Occupation)]
profession_dt$Value <- as.numeric(profession_dt$Value)

profession_dt <- dcast(profession_dt, Territory ~ Occupation + Gender, value.var = "Value", fun.aggregate = mean)

# Merging the data tables
data_tables <- list(
  pop_dt, educ_dt, indus_dt, estates_dt, births_dt, denomination_dt, dem_dist_dt, profession_dt
)
merged_dt <- data_tables[[1]]

for (i in 2:length(data_tables)){
merged_dt <- merged_dt |>
merge(data_tables[[i]], by = "Territory", all = T)
}