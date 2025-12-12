data <- read.csv("water_potability.csv")
data$Drinkable <- ifelse(data$Potability == 1,"Drinkable","Non-drinkable")
data$Drinkable <- factor(data$Drinkable,levels = c("Non-drinkable", "Drinkable"))
data_RQ <- data.frame(Drinkable = data$Drinkable,TDS = data$Solids)
t_result <- t.test(TDS ~ Drinkable,data = data_rq,var.equal = FALSE)
t_result