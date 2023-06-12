library(ggplot2)
library(dplyr)

# Create some example data
ts_data <- data.frame(date = seq(from = as.Date("2022-01-01"), to = as.Date("2022-12-31"), by = "day"),
                               product = 1,
                               value = rnorm(365, mean = 100, sd = 10))

# Plot the data using ggplot
ggplot(ts_data, aes(x = date, y = value)) +
  geom_line() +
  ggtitle("Time Series Data") +
  xlab("Date") +
  ylab("Value")


# Add variable including the value of the day before
ts_data_with_lag <- ts_data %>%
  arrange(date) %>%
  mutate(value_prev_day = lag(value, default = NA))



# Example data, in which several values (labels) are given for each day
multiple_ts_data <- ts_data %>% 
  rbind(data.frame(date = seq(from = as.Date("2022-01-01"), to = as.Date("2022-12-31"), by = "day"),
                               product=2,
                               value = rnorm(365, mean = 100, sd = 10)))


multiple_ts_data_with_lag <- multiple_ts_data %>%
  arrange(date, product) %>%
  group_by(product) %>%
  mutate(value_prev_within_day = lag(value, default = NA)) %>%
  ungroup()
