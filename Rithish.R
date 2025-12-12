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

# printing structure after cleaning
str(water_clean)

# grouping data and calculating summary statistics
summary_solids <- water_clean %>% group_by(Potability) %>% summarise(
    n = n(), mean_Solids = mean(Solids), sd_Solids   = sd(Solids), median_Solids = median(Solids),
    min_Solids  = min(Solids), max_Solids  = max(Solids))

# printing summary statistics
summary_solids

# Plotting histogram of Total Dissolved Solids
ggplot(water_clean, aes(x = Solids)) +
  geom_histogram(binwidth = 1000, colour = "black", fill = "grey80") +
  labs(
    title = "Histogram of Total Dissolved Solids (All Samples)",
    x     = "Total Dissolved Solids (mg/L)",
    y     = "Frequency"
  ) +
  theme_minimal()
 
# Plotting boxplot of Solids by Potability
ggplot(water_clean, aes(x = Potability, y = Solids)) +
  geom_boxplot() +                                    
  labs(
    title = "Boxplot of Total Dissolved Solids by Water Drinkability",
    x     = "Water Drinkability Status",
    y     = "Total Dissolved Solids (mg/L)"
  ) +
  theme_minimal()

# Plotting density curves to inspect the distribution
ggplot(water_clean, aes(x = Solids, fill = Potability)) +
  geom_density(alpha = 0.4) + 
  labs(
    title = "Density Plot of TDS for Drinkable vs Non-drinkable Water",
    x     = "Total Dissolved Solids (mg/L)",
    y     = "Density",
    fill  = "Potability"
  ) +
  theme_minimal()


# Running Levene’s Test for homogeneity of variance 
leveneTest(Solids ~ Potability, data = water_clean)

# performing Welch two-sample t-test for any difference in means
t.test(Solids ~ Potability, data = water_clean, alternative = "two.sided")

# extracting group-wise statistics again for effect size calculation
summary_effect <- water_clean %>% group_by(Potability) %>% summarise(
    n   = n(),                  # calculating sample size
    M   = mean(Solids),         # calculating mean
    SD  = sd(Solids))           # calculating standard deviation

# Printing group-wise statistics
summary_effect

# separating statistics
n0  <- summary_effect$n[summary_effect$Potability == "Non-drinkable"]
n1  <- summary_effect$n[summary_effect$Potability == "Drinkable"]
M0  <- summary_effect$M[summary_effect$Potability == "Non-drinkable"]
M1  <- summary_effect$M[summary_effect$Potability == "Drinkable"]
SD0 <- summary_effect$SD[summary_effect$Potability == "Non-drinkable"]
SD1 <- summary_effect$SD[summary_effect$Potability == "Drinkable"]

# calculating pooled standard deviation
SD_pooled <- sqrt(((n0 - 1) * SD0^2 + (n1 - 1) * SD1^2) / (n0 + n1 - 2))

# calculating Cohen's d (mean difference divided by pooled SD)
cohen_d <- (M1 - M0) / SD_pooled

# printing effect size
cohen_d

# Printing final results of t-test and effect size
if (t_test_result$p.value < 0.05) {
  print("The p-value is below 0.05, so we are rejecting the null hypothesis.")
} else {
  print("The p-value is greater than or equal to 0.05, so we are not rejecting the null hypothesis.")
}