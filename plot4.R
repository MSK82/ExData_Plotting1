
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
globalActivePower<-as.numeric(alldata$Global_active_power)
globalReactivePower<-as.numeric(alldata$Global_reactive_power)
submeter1<-as.numeric(alldata$Sub_metering_1)
submeter2<-as.numeric(alldata$Sub_metering_2)
submeter3<-as.numeric(alldata$Sub_metering_3)
voltage<-as.numeric(alldata$Voltage)
dates<-as.Date(alldata$Date)

plot.window(xlim = c(0,600),ylim = c(0,480))
par(mfrow=c(2,2))
plot(datetime,globalActivePower,type = "l",xlab = "",ylab = "Global Active Power")
plot(datetime,voltage,type = "l",xlab = "datetime",ylab = "Voltage")
plot(datetime, submeter1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, submeter2, type="l",col="blue")
lines(datetime,submeter3,type="l",col="red")
legend("topright",c("sub_metering_1","sub_metering_2","sub_metering_3"),lty = 1,lwd = 2,col=c("black","blue","red"),bty = "o")
plot(datetime,globalReactivePower,type = "l",xlab = "datetime",ylab = "Global Reactive Power")

#axis(side = 1,at=as.Date(alldata$Date),labels = weekdays(as.Date(alldata$Date)),line = 2)
dev.copy(png,"plot4.png")
dev.off()