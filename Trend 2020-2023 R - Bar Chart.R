# Convert 'date' column to Date format
layoffs_clean$date <- as.Date(layoffs_clean$date)

# Filter the data for the years 2020 to 2023
layoffs_filtered <- layoffs_clean %>%
  filter(year(date) >= 2020 & year(date) <= 2023)

# Convert 'total_laid_off' to numeric (if it may be in text/str format)
layoffs_filtered$total_laid_off <- as.numeric(layoffs_filtered$total_laid_off)

# Aggregate total layoffs by year
layoffs_aggregated <- layoffs_filtered %>%
  group_by(year = year(date)) %>%
  summarise(total_laid_off = sum(total_laid_off, na.rm = TRUE))

# Create a bar chart
ggplot(data = layoffs_aggregated, aes(x = factor(year), y = total_laid_off, fill = factor(year))) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Trends of Total Layoffs (2020 - 2023)",
       x = "Year",
       y = "Total Layoffs") +
  theme_minimal() +
  theme(plot.title = element_text(size = 20, hjust = 0.5),
        axis.title = element_text(size = 16),
        axis.text = element_text(size = 14),
        panel.grid.major = element_line(color = "lightgray"),
        panel.grid.minor = element_blank())
