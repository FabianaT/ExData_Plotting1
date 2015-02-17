#######################################################################
# Download Data

# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileURL, destfile = "project.zip")
# unzip("project.zip")

#######################################################################
# Read Data
## We will only be using data from the dates 2007-02-01 and 2007-02-02
require(sqldf)
file <- c("household_power_consumption.txt")
householdEnergyUsage <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

#######################################################################
# Plot

hist(householdEnergyUsage$Global_active_power, col = "red", main = "Global Active Power",  xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()



