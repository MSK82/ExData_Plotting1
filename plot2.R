
library(dplyr)
library(lubridate)

filename="data.zip"

if(!file.exists(filename))
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",filename,method = "curl")

if(!file.exists("household_power_consumption.txt"))
  unzip(filename)

alldata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
alldata <- alldata[alldata$Date %in% c("1/2/2007","2/2/2007") ,]

#str(subSetData)
datetime <- strptime(paste(alldata$Date, alldata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(alldata$Global_active_power)

plot.window(xlim = c(0,600),ylim = c(0,480))
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
#axis(side = 1,at=datetime,labels = weekdays(datetime))
dev.copy(png,"plot2.png")
dev.off()