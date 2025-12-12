# DS082: water_potability.csv

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