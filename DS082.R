# DS082: water_potability.csv

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
