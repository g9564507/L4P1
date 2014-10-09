library(data.table)


#file<-"household_power_consumption.txt"
#householdPower <- read.table(file, sep = ";", header = TRUE)

householdPower <- fread("household_power_consumption.txt")



hPower2D<- householdPower[householdPower$Date=="1/2/2007"| householdPower$Date=="2/2/2007"]

## Eliminate "?""
## na.omit can omnit NA
hPower2D[hPower2D=="?"]<- NA
hPower2DNoNA <-na.omit(hPower2D)


DateTime <- paste(hPower2DNoNA $Date, hPower2DNoNA $Time)

DateTime1 <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")

DateTime2<- as.POSIXct(DateTime1) ## become double


#GAP <- as.numeric(hPower2DNoNA$Global_active_power)
#"Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3" 

Sub_metering_1 <- as.numeric(hPower2DNoNA$Sub_metering_1)
Sub_metering_2 <- as.numeric(hPower2DNoNA$Sub_metering_2)
Sub_metering_3 <- as.numeric(hPower2DNoNA$Sub_metering_3)

par(mar=c(5,4,3,2))

plot(DateTime2,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(DateTime2,Sub_metering_1, pch=46,type = "l", col="black")
lines(DateTime2,Sub_metering_2, pch=46,type = "l", col="red")
lines(DateTime2,Sub_metering_3, pch=46,type = "l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c(1,4,2),lty=1,lwd=2, pch=46, seg.len = 1.5,cex=1.2, xjust=0.5)



dev.copy(png, file = "plot3.png") 
dev.off()