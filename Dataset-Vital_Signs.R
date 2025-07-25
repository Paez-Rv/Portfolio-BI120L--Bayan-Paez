# Load necessary libraries
library(ggplot2)
library(readr)
library(dplyr)

# Load the dataset
df <- read_csv("1_Vital_signs_diagnosis_data_Group_001.csv")

#Checking for Missing values
colSums(is.na(df))

#Computing for Missing BMI
df$BMI <- ifelse(is.na(df$BMI), df$Weight_kg / (df$Height_cm/100)^2, df$BMI)

#Descriptive Statistics
summary(df)

#Correlation Test
cor.test(df$Weight_kg, df$BMI, method = "pearson")

#Visualizing Output
plot(df$Weight_kg, df$BMI,
     main = "BMI vs Weight_kg",
     xlab = "Weight_kg",
     ylab = "BMI")
