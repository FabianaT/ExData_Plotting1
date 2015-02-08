#######################################################################
# Read Data
## We will only be using data from the dates 2007-02-01 and 2007-02-02
require(sqldf)
file <- c("household_power_consumption.txt")
householdEnergyUsage <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

## Convert the Date and Time variables to Date/Time

householdEnergyUsage$DateTime <- paste(householdEnergyUsage$Date, householdEnergyUsage$Time)
householdEnergyUsage$DateTime <- strptime(paste(householdEnergyUsage$Date, householdEnergyUsage$Time), format = "%d/%m/%Y %H:%M:%S")
householdEnergyUsage$Date <- as.Date(householdEnergyUsage$Date, format= "%d/%m/%Y")

#######################################################################
# Plot

Sys.setlocale("LC_TIME", "English")

with(householdEnergyUsage, 
	plot(DateTime, Global_active_power, 
		type = "l", 
		xlab = "",
		ylab = "Global Active Power (killowatts)"))

dev.copy(png, file = "plot2.png")
dev.off()



