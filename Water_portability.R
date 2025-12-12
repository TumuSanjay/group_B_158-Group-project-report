#Data preparation
data <- read.csv("water_potability.csv")

# Create Drinkable variable (Nominal: Drinkable vs Non-drinkable)
data$Drinkable <- ifelse(data$Potability == 1,"Drinkable","Non-drinkable")
data$Drinkable <- factor(data$Drinkable,levels = c("Non-drinkable", "Drinkable"))

# Create dataset for the research question
data_rq <- data.frame(Drinkable = data$Drinkable,TDS = data$Solids)

data_rq <- subset(data_rq, !is.na(TDS)) #remove rows with missing values

table(data_rq$Drinkable) #Number of observations in each group

summary(data_rq$TDS) #Summary of TDS overall

# Summary of TDS by group
summary(data_rq$TDS[data_rq$Drinkable == "Non-drinkable"])
summary(data_rq$TDS[data_rq$Drinkable == "Drinkable"])

# Mean TDS in each group
mean_non <- mean(data_rq$TDS[data_rq$Drinkable == "Non-drinkable"],na.rm = TRUE)
mean_drink <- mean(data_rq$TDS[data_rq$Drinkable == "Drinkable"],na.rm = TRUE)
mean_non
mean_drink


# Boxplot: main plot for the RQ
png("boxplot_TDS_drinkable.png", width = 900, height = 600)
boxplot(TDS ~ Drinkable,
        data = data_rq,
        main = "Total Dissolved Solids in Drinkable vs Non-drinkable Water",
        xlab = "Water type",
        ylab = "Total Dissolved Solids (mg/L)",
        col = c("lightblue", "lightgreen"))
dev.off()

# Histogram: distribution of TDS (dependent variable)
png("histogram_TDS.png", width = 900, height = 600)
hist(data_rq$TDS,
     main = "Distribution of Total Dissolved Solids",
     xlab = "Total Dissolved Solids (mg/L)",
     ylab = "Frequency",
     col = "lightgray",
     breaks = 30)
dev.off()

# Welch Two Sample t-test: Difference in mean TDS
t_result <- t.test(TDS ~ Drinkable,data = data_rq,var.equal = FALSE)
t_result