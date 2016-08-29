# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 

install.packages(c("Rcpp", "readr"))

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function

# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory

setwd("/Users/Julien/Documents/github/airplane-crashes/")
# system("ls ../input")

# Any results you write to the current directory are saved as output.
library(ggplot2)

crash_data = read.csv("3-Airplane_Crashes_Since_1908.csv")

# Create a utility function to get the crash year
extractCrashYear <- function(date) {
  date <- as.character(date)
  
  # Get the Year from the date
  year = gsub("([0-9]{2})/([0-9]{2})/", "", date)
  
  return(year)
}

# Obtain some new features (focused on US crashes), namely:
# 1. Country in which crash occured
# 2. City in which crash occured
# 3. State in which crash occured
Crash_Year <- NULL
for (i in 1:nrow(crash_data)) {
  Crash_Year <- c(Crash_Year, extractCrashYear(crash_data[i,"Date"]))
}
crash_data$Crash_Year <- as.factor(Crash_Year)

# Add the year and factors in the data.
crash_data$Crash_Year <-as.factor(crash_data$Crash_Year)

# Plot the total number of crashes in each year
ggplot(subset(crash_data,Crash_Year != ""), aes(x = as.numeric(as.character(Crash_Year)))) +
  stat_count(width = 0.5) +
  scale_x_continuous(breaks=c(1:1000)*10) +
  theme(axis.text.x=element_text(angle=0,hjust=0.5,vjust=0)) +
  ggtitle("Crashes per Year") +
  xlab("Year") +
  ylab("Total Crashes")

