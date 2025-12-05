data <- read.csv("water_potability.csv")
selected <- data[, c("ph","Hardness","Solids","Chloramines", "Potability")]
head(selected, 5)
nrow(data)