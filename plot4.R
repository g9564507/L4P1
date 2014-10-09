library(data.table)


#file<-"household_power_consumption.txt"
#householdPower <- read.table(file, sep = ";", header = TRUE)

householdPower <- fread("household_power_consumption.txt")



hPower2D<- householdPower[householdPower$Date=="1/2/2007"| householdPower$Date=="2/2/2007"]

## Eliminate "?""
## na.omit can omnit NA
hPower2D[hPower2D=="?"]<- NA
hPower2DNoNA <-na.omit(hPower2D)





#1
GAP <- as.numeric(hPower2DNoNA$Global_active_power)

DateTime <- paste(hPower2DNoNA $Date, hPower2DNoNA $Time)

DateTime1 <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")

DateTime2<- as.POSIXct(DateTime1) ## become double

#"Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3" 
# "Global_reactive_power" "Voltage" 

#2
Sub_metering_1 <- as.numeric(hPower2DNoNA$Sub_metering_1)
Sub_metering_2 <- as.numeric(hPower2DNoNA$Sub_metering_2)
Sub_metering_3 <- as.numeric(hPower2DNoNA$Sub_metering_3)

#3
Global_reactive_power <- as.numeric(hPower2DNoNA$Global_reactive_power)

#4
Voltage <- as.numeric(hPower2DNoNA$Voltage)

par(mar=c(5,5,3,2),mfcol=c(2,2))


#1
plot(DateTime2,GAP, pch=46,type = "l",xlab="",ylab="Global Active Power (kilowatts)")

#2
plot(DateTime2,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(DateTime2,Sub_metering_1, pch=46,type = "l", col="black")
lines(DateTime2,Sub_metering_2, pch=46,type = "l", col="red")
lines(DateTime2,Sub_metering_3, pch=46,type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c(1,4,2),lty=1,lwd=2, pch=46, seg.len = 1.5,cex=0.8, xjust=0.5,box.lwd=0)

#3
plot(DateTime2,Voltage, pch=46,type = "l",xlab="datetime",ylab="Voltage")


#4
plot(DateTime2,Global_reactive_power, pch=46,type = "l",xlab="datetime",ylab="Global_reactive_power")

dev.copy(png, file = "plot4.png") 
dev.off()