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

par(mfrow = c(2, 2), mar = c(5, 4, 4, 2))


with(householdEnergyUsage, { 
	## Plotting - Plot 1
	plot(DateTime, Global_active_power, 
		type = "l", 
		xlab = "",
		ylab = "Global Active Power")

	## Plotting - Plot 2
	plot(DateTime, Voltage, 
		type = "l", 
		xlab = "datetime",
		ylab = "Voltage")

	## Plotting - Plot 3
	plot(DateTime, Sub_metering_1, 
		type = "l",
		xlab = "",
		ylab = "Energy submetering",
		col = "black")

	lines(DateTime, Sub_metering_2, 
		col = "red")
	lines(DateTime, Sub_metering_3, 
		col = "blue")

	legend("topright", 
		lwd = 2,
		col = c("black", "red", "blue"), 
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	## Plotting - Plot 4

	plot(DateTime, 
		Global_reactive_power,
		type = "l",
		xlab = "datetime")
	}
)


## Save Plots
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()




