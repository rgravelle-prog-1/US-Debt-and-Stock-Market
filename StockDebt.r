# Load the readxl package
library(readxl)

# Specify data source
excel_file_path <- "HistoricalPrices.xlsx"

# Read the Excel file into a data frame
stockmarkethistorydata <- read_excel(excel_file_path)



# Load ggplot2 if not already loaded
library(ggplot2)

# Create a line plot
ggplot(stockmarkethistorydata, aes(x = Date, y = Close)) +
  geom_line() +
  labs(title = "Closing Prices Over Time", x = "Date", y = "Closing Price")


# Now load debt data into r 

library(ggplot2)
library(dplyr)
library(lubridate)
library(readxl)
library(janitor)

# Load the data from Excel
qbqdebtdata <- read_excel("qbqdebt.xlsx") %>%
  clean_names()

# Display the structure of the data
str(qbqdebtdata)

# Convert 'date' column to Date class
qbqdebtdata$date <- as.Date(qbqdebtdata$date)

# Create a line plot with years at a 45-degree angle
ggplot(qbqdebtdata, aes(x = date, y = total)) +
  geom_line() +
  labs(title = "Total Debt Over Time", x = "Date", y = "Total Debt") +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 year") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# correlation


# Merge datasets based on the 'date' column
merged_data <- inner_join(qbqdebtdata, stockmarkethistorydata, by = c("date" = "Date"))

# Calculate the correlation between 'Close' and 'total'
correlation <- cor(merged_data$Close, merged_data$total)

# Print the correlation
print(correlation)

# Create a scatter plot with a correlation line
ggplot(merged_data, aes(x = total, y = Close)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add a linear regression line
  labs(title = "Scatter Plot of Total Debt vs. Closing Price",
       x = "Total Debt",
       y = "Closing Price") +
  theme_minimal()




