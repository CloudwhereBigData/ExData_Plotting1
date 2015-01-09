## coursera Plot1 for ExData - Script 01/08/2015

##This Script will read data from the household power consumption and display
##a histogram for the global active power for a subset of dates
## 2007-02-01 and 2007-02-02
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
##convert character to numeric for active power
hpcsub$Global_active_power <- as.numeric(hpcsub$Global_active_power)

## Open PNG device; create 'plot1.png' in my working directory 480x480
png(file = "plot1.png", bg='transparent', width = 480, height = 480) 

##plot a histogram for global active power
with(hpcsub, hist(Global_active_power,
                  main = "Global Active Power",
                  col = "red", 
                  xlab = "Global Active Power (kilowatts)", 
                  ylab = "Frequency"))
dev.off()
