# Load necessary libraries
library(ggplot2)
library(readr)
library(dplyr)

# Load the dataset
df <- read_csv("NDD.csv")

# Clean column names if needed
colnames(df) <- gsub("[\\s\\\"]", "", colnames(df))

# Combine macronutrient intake into one column
df <- df %>%
  mutate(Total_Intake_g = Protein_intake_g + Fat_intake_g + Carbohydrate_intake_g)

# Map BMI categories to readable labels
df <- df %>%
  mutate(BMI_Category_Label = case_when(
    BMI_category == "(0,18.5]" ~ "Underweight",
    BMI_category == "(18.5,24.9]" ~ "Normal",
    BMI_category == "(24.9,29.9]" ~ "Overweight",
    BMI_category == "(29.9,Inf]" ~ "Obese",
    TRUE ~ "Unknown"
  ))

# Create the bar chart
ggplot(df, aes(x = factor(Patient.ID), y = Total_Intake_g, fill = BMI_Category_Label)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("Underweight" = "blue", "Normal" = "green",
                               "Overweight" = "orange", "Obese" = "red")) +
  labs(title = "Combined Macronutrient Intake per Patient",
       x = "Patient ID",
       y = "Total Intake (grams)",
       fill = "BMI Category") +
  theme_minimal() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())