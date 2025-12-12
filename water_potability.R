# DS082: water_potability.csv

# loading tidyverse for data handling and plotting
if (!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

# loading car package for variance tests
if (!require(car)) install.packages("car")
library(car)

# loading the CSV dataset
water_raw <- read.csv("water_potability.csv", header = TRUE)

# printing the column names
colnames(water_raw)

# printing first few rows for a quick check
head(water_raw)

# printing structure of the dataset
str(water_raw)

# checking missing values per column
colSums(is.na(water_raw))

# filtering rows with Solids and Potability values
water_clean <- water_raw %>% filter(!is.na(Solids), !is.na(Potability))

# converting Potability to a factor with labels
water_clean <- water_clean %>%
  mutate(Potability = factor(Potability,
                             levels = c(0, 1),
                             labels = c("Non-drinkable", "Drinkable")))
