# Load necessary libraries
library(ggplot2)
library(readr)
library(dplyr)

# Load the dataset
df <- read_csv("2_Demographic_Behavioral_data_Group_001.csv")

#Descriptive Statistics
summary(df)

#Make a Contingency Table
table <- table(df$Socioeconomic...8, df$Health_Literacy_Score)
print(table)

#Performing Chi-Square Test
results <- chisq.test(table)
print(results)

#Visualizing Output
barplot(table, beside = TRUE,
        col = c("red", "blue", "plum"),
        xlab = "Health_Literacy_Score",
        ylab = "Population per Socioeconomic Status")

legend("topleft", inset = .01, box.lty=0, 
       legend = c("Low Class", "Middle Class", "Upper Class"), 
       fill = c("red", "blue","plum"))

