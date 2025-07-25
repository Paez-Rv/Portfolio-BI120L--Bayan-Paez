# Load necessary libraries
library(ggplot2)
library(readr)

# Load the dataset
df <- read_csv("Dataset_odd.csv")

# Perform correlation test between Stress Level and Heart Rate
cor.test(df$Stress_Level, df$Heart_rate, method = "pearson")

# Define stress level color mapping
df$Stress_Color <- with(df, ifelse(Stress_Level <= 3, "green",
                                   ifelse(Stress_Level <= 6, "orange", "red")))

# Create the bubble plot
ggplot(df, aes(x = Patient ID, y = Heart_rate)) +
  geom_point(aes(color = Stress_Color), size = 3, alpha = 0.6) +
  scale_color_identity() +
  labs(title = "Heart Rate by Patient with Stress Level Coloring",
       x = "Patient ID",
       y = "Heart Rate") +
  theme_minimal()