data <- read.csv("water_potability.csv")
selected <- data[, c("ph","Hardness","Solids","Chloramines", "Potability")]
head(selected, 5)
nrow(data)
data$Drinkable <- ifelse(data$Potability == 1,"Drinkable","Non-drinkable")
data$Drinkable <- factor(data$Drinkable,levels = c("Non-drinkable", "Drinkable"))
data_RQ <- data.frame(Drinkable = data$Drinkable,TDS = data$Solids)
data_RQ <- subset(data_rq, !is.na(TDS))
table(data_rq$Drinkable)
summary(data_rq$TDS)
summary(data_rq$TDS[data_rq$Drinkable == "Non-drinkable"])
summary(data_rq$TDS[data_rq$Drinkable == "Drinkable"])
mean_non <- mean(data_rq$TDS[data_rq$Drinkable == "Non-drinkable"],na.rm = TRUE)
mean_drink <- mean(data_rq$TDS[data_rq$Drinkable == "Drinkable"],na.rm = TRUE)
mean_non
mean_drink