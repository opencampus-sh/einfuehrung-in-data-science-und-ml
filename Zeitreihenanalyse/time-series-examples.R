
###################################################
### Preparation of the Environment ####

# Clear environment
remove(list = ls())

# Load libraries
library(readr)
library(ggplot2)
library(hrbrthemes)


###################################################
# Reading the data file
# (download from https://hystreet.com/)
pedestrians_hourly<- read_csv2("kiel-holstenstraße (mitte)-20200505-20220103-hour.csv")
pedestrians_daily<- read_csv2("kiel-holstenstraße (mitte)-20200505-20220103-day.csv")


###################################################
# Prepare data
pedestrians_hourly$datetime <- as.POSIXct(pedestrians_hourly$`time of measurement`)
pedestrians_daily$date <- as.Date(pedestrians_daily$`time of measurement`)


###################################################
# Pedestrians hourly

# Basic plot
ggplot(pedestrians_hourly) +
  geom_line(aes(x=datetime, y=`pedestrians count`), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1))

# Time frame specific plot
ggplot(pedestrians_hourly) +
  geom_line(aes(x=datetime, y=`pedestrians count`), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1)) +
  scale_x_datetime(limit=c(as.POSIXct("2021-10-01"),as.POSIXct("2021-11-01")))


###################################################
# Pedestrians daily

# Basic plot
ggplot(pedestrians_daily) +
  geom_line(aes(x=date, y=`pedestrians count`), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1))

# Time frame specific plot
ggplot(pedestrians_daily) +
  geom_line(aes(x=date, y=`pedestrians count`), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1)) +
  scale_x_date(limit=c(as.Date("2021-10-01"),as.Date("2021-11-01")))

# Time frame specific plot
ggplot(pedestrians_daily) +
  geom_line(aes(x=date, y=`pedestrians count`), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1)) +
  scale_x_date(limit=c(as.Date("2021-01-01"),as.Date("2021-12-31")))


###################################################
# Time series including differencing

# casing the count variable into a time series object using the ts() function
# and using the lag() function to obtain the values from 7 days before.
differenced_weekly <- ts(pedestrians_daily$`pedestrians count`) - lag(ts(pedestrians_daily$`pedestrians count`), 7)

# differenced time series
ggplot() +
  geom_line(aes(x=pedestrians_daily$date[8:nrow(pedestrians_daily)], y=differenced_weekly), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1)) +
  scale_x_date(limit=c(as.Date("2021-01-01"),as.Date("2021-12-31")))

# including constrained y-scale
ggplot() +
  geom_line(aes(x=pedestrians_daily$date[8:nrow(pedestrians_daily)], y=differenced_weekly), color="#69b3a2") + 
  xlab("") +
  theme_ipsum() +
  theme(axis.text.x=element_text(angle=60, hjust=1)) +
  scale_x_date(limit=c(as.Date("2021-01-01"),as.Date("2021-12-31"))) +
  ylim(-10000, 10000)
