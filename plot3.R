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

dataPlot <- householdEnergyUsage[, c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

#######################################################################
# Plot

## Plotting
Sys.setlocale("LC_TIME", "English")

plot(dataPlot$DateTime, dataPlot$Sub_metering_1, 
	type = "l",
	xlab = "",
	ylab = "Energy sub metering",
	col = "black")

lines(dataPlot$DateTime, dataPlot$Sub_metering_2, 
	col = "red")
lines(dataPlot$DateTime, dataPlot$Sub_metering_3, 
	col = "blue")

legend("topright", 
	lwd = 2,
	col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()




