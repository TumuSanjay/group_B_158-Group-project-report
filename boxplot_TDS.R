data <- read.csv("water_potability.csv")
selected <- data[, c("ph","Hardness","Solids","Chloramines", "Potability")]
head(selected, 5)
nrow(data)
data$Drinkable <- ifelse(data$Potability == 1,"Drinkable","Non-drinkable")
data$Drinkable <- factor(data$Drinkable,levels = c("Non-drinkable", "Drinkable"))
data_RQ <- data.frame(Drinkable = data$Drinkable,TDS = data$Solids)
data_RQ <- subset(data_rq, !is.na(TDS))
png("boxplot_TDS.png", width = 900, height = 600)
boxplot(TDS ~ Drinkable,
        data = data_rq,
        main = "Total Dissolved Solids in Drinkable vs Non-drinkable Water",
        xlab = "Water type",
        ylab = "Total Dissolved Solids (mg/L)",
        col = c("lightblue", "lightgreen"))
dev.off()