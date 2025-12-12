data <- read.csv("water_potability.csv")
data$Drinkable <- ifelse(data$Potability == 1,"Drinkable","Non-drinkable")
data$Drinkable <- factor(data$Drinkable,levels = c("Non-drinkable", "Drinkable"))
data_RQ <- data.frame(Drinkable = data$Drinkable,TDS = data$Solids)
data_RQ <- subset(data_rq, !is.na(TDS))
png("hist_TDS.png", width = 900, height = 600)
hist(data_RQ$TDS,
     main = "Distribution of Total Dissolved Solids",
     xlab = "Total Dissolved Solids (mg/L)",
     ylab = "Frequency",
     col = "lightgray",
     breaks = 30)
dev.off()