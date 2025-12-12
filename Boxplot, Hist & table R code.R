View(water_potability)
> boxplot(Solids ~ Potability, 
          +         data = water_potability,
          +         main = "Total Dissolved Solids by Water Potability",
          +         xlab = "Potability (0 = Non-drinkable, 1 = Drinkable)",
          +         ylab = "TDS (mg/L)",
          +         col = c("lightblue", "lightgreen"),
          +         names = c("Non-drinkable", "Drinkable"))
> hist(water_potability$Solids,
       +      main = "Distribution of Total Dissolved Solids",
       +      xlab = "TDS (mg/L)",
       +      ylab = "Frequency",
       +      col = "gray", border = "black")
>  table(water_potability$Potability)

0    1 
1998 1278 
> 