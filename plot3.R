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

## Preparing Data To Plot 
dataPlot1 <- householdEnergyUsage[, c("DateTime", "Sub_metering_1")]
dataPlot2 <- householdEnergyUsage[, c("DateTime", "Sub_metering_2")]
dataPlot3 <- householdEnergyUsage[, c("DateTime", "Sub_metering_3")]
colnames(dataPlot1) <- c("DateTime", "Sub_metering")
colnames(dataPlot2) <- c("DateTime", "Sub_metering")
colnames(dataPlot3) <- c("DateTime", "Sub_metering")
dataPlot1$Label <- "Sub_metering_1"
dataPlot2$Label <- "Sub_metering_2"
dataPlot3$Label <- "Sub_metering_3"

dataPlot <- dataPlot1[, c("DateTime", "Sub_metering")]
dataPlot <- rbind(dataPlot , dataPlot2[, c("DateTime", "Sub_metering")])
dataPlot <- rbind(dataPlot , dataPlot3[, c("DateTime", "Sub_metering")])

plotLabels <- dataPlot1$Label
plotLabels <- append(plotLabels, values = dataPlot2$Label, after = length(plotLabels))
plotLabels <- append(plotLabels, values = dataPlot3$Label, after = length(plotLabels))

## Plotting
Sys.setlocale("LC_TIME", "English")

plot(dataPlot$DateTime, dataPlot$Sub_metering, 
	type = "n",
	xlab = "",
	ylab = "Energy sub metering")

lines(dataPlot[(plotLabels == "Sub_metering_1"), "DateTime"], 
	dataPlot[(plotLabels == "Sub_metering_1"), "Sub_metering"],
	col = "black")
lines(dataPlot[(plotLabels == "Sub_metering_2"), "DateTime"], 
	dataPlot[(plotLabels == "Sub_metering_2"), "Sub_metering"],
	col = "red")
lines(dataPlot[(plotLabels == "Sub_metering_3"), "DateTime"], 
	dataPlot[(plotLabels == "Sub_metering_3"), "Sub_metering"],
	col = "blue")

legend("topright", 
	lwd = 2,
	col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()




