## coursera Plot4 for ExData - Script 01/08/2015

##This Script will read data from the household power consumption and display
##4 plots on a subset of dates 2007-02-01 and 2007-02-02 for below
##1 - global active power by days
##2 - voltage by days
##3 - 3 sub metering values by dates
##4 - global active power by days

##This script assumes the data was already downloaded from the link below near
##the read and unzipped into a data directory off of the working directory

## Required Libraries
library("datasets")

##Read into dataframe the household power comsumption data
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
hpc <- read.table(file="data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)  ##main data

## merge Date and time into datetime field - little help from discussion group (my way was not as clean,lol)
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S") 

##filter out the date required
hpcsub = subset(hpc, datetime >= '2007-02-01' & 
                     datetime <= '2007-02-03')
##convert character to numeric for all graph required cols
hpcsub$Sub_metering_1 <- as.numeric(hpcsub$Sub_metering_1)
hpcsub$Sub_metering_2 <- as.numeric(hpcsub$Sub_metering_2)
hpcsub$Sub_metering_3 <- as.numeric(hpcsub$Sub_metering_3)
hpcsub$Global_active_power <- as.numeric(hpcsub$Global_active_power)
hpcsub$Global_reactive_power <- as.numeric(hpcsub$Global_reactive_power)
hpcsub$Voltage <- as.numeric(hpcsub$Voltage)

## Open PNG device; create 'plot4.png' in my working directory 480x480
png(file = "plot4.png", bg='transparent', width = 480, height = 480) 

##display 4 graphs on page 2X2
par(mfrow = c(2, 2))

##plot 1
##plot a line type for global actove power by datetime
with(hpcsub, plot(datetime, Global_active_power, 
                  type="l", 
                  xlab = NA, 
                  ylab="Global Active Power"))
##plot 2
##plot a line type for global actove power by datetime
with(hpcsub, plot(datetime, Voltage, 
                  type="l", 
                  xlab = "datetime", 
                  ylab="Voltage"))
##plot 3
##plot a line type for three lines
with(hpcsub, plot(datetime, Sub_metering_1, 
                  type="l", 
                  xlab = NA, 
                  ylab="Energy sub metering"))
with(hpcsub, lines(datetime, Sub_metering_2, 
                   type="l",
                   col = "red"))
with(hpcsub, lines(datetime, Sub_metering_3, 
                   type="l",
                   col = "blue"))
legend("topright", 
       lwd = 1, 
       bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##plot 4
##plot a line type for global actove power by datetime
with(hpcsub, plot(datetime, Global_reactive_power, 
                  type="l",
                  xlab = "datetime", 
                  ylab="Global_reactive_power"))

dev.off()
