
library(dplyr)
library(lubridate)

filename="data.zip"

if(!file.exists(filename))
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",filename,method = "curl")

if(!file.exists("household_power_consumption.txt"))
  unzip(filename)

alldata <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
alldata <- alldata[alldata$Date %in% c("1/2/2007","2/2/2007") ,]

datetime <- strptime(paste(alldata$Date, alldata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

submeter1<-as.numeric(alldata$Sub_metering_1)
submeter2<-as.numeric(alldata$Sub_metering_2)
submeter3<-as.numeric(alldata$Sub_metering_3)

par(mfrow=c(1,1))
plot.window(xlim = c(0,600),ylim = c(0,480))
plot(datetime, submeter1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, submeter2, type="l",col="blue")
lines(datetime,submeter3,type="l",col="red")
legend("topright",c("sub_metering_1","sub_metering_2","sub_metering_3"),lty = 1,lwd = 2,col=c("black","blue","red"))
#axis(side = 1,at=weekdays(datetime), labels = weekdays(datetime))
dev.copy(png,"plot3.png")
dev.off()