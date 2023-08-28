
library(dplyr)
library(lubridate)

filename="data.zip"

if(!file.exists(filename))
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",filename,method = "curl")

if(!file.exists("household_power_consumption.txt"))
  unzip(filename)

#alldata<-read.table("household_power_consumption.txt",col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),sep = ";")
alldata<-read.table("household_power_consumption.txt",header = TRUE,sep = ";")

alldata$Date=as.Date(alldata$Date,format='%d/%m/%Y')
alldata$Time<-strptime(alldata$Time,format='%H:%M:%S')

alldata<-alldata[alldata$Date=="2007-02-01" | alldata$Date=="2007-02-02",]

alldata$Global_active_power<-as.numeric(alldata$Global_active_power)

hist(alldata$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts",col = "red")

dev.copy(png,"plot1.png")

dev.off()