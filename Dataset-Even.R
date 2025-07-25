# Load necessary libraries
library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(tibble)  # This is needed for rownames_to_column()

# Load the dataset
df <- read_csv("Dataset_even.csv")

# Select relevant numeric columns
selected_vars <- c("Stress_Level", "Daily_Sleeping_hours", "Physical_Activity_Hours_Week",
                   "BMI", "Glucose_mg/dL", "Cholesterol_mg/dL")

# Convert to numeric (if needed)
df[selected_vars] <- df %>%
  select(all_of(selected_vars)) %>%
  mutate(across(everything(), as.numeric))

# Compute correlation matrix
cor_matrix <- cor(df[selected_vars], use = "complete.obs")

# Convert correlation matrix to long format using tidyr and tibble
cor_long <- as.data.frame(cor_matrix) %>%
  rownames_to_column("Var1") %>%
  pivot_longer(cols = -Var1, names_to = "Var2", values_to = "value")

# Plot the heatmap
ggplot(cor_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "#B2182B", high = "#2166AC", mid = "white",
                       midpoint = 0, limit = c(-1,1), space = "Lab",
                       name = "Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  coord_fixed() +
  labs(title = "Correlation Heatmap of Health and Lifestyle Variables",
       x = "", y = "")
       