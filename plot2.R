library(data.table)


#file<-"household_power_consumption.txt"
#householdPower <- read.table(file, sep = ";", header = TRUE)

householdPower <- fread("household_power_consumption.txt")
#head(householdPower,2)  # default print 6 rows

#typeof(householdPower[1])

#names(householdPower)


hPower2D<- householdPower[householdPower$Date=="1/2/2007"| householdPower$Date=="2/2/2007"]

## Eliminate "?""
## na.omit can omnit NA
hPower2D[hPower2D=="?"]<- NA
hPower2DNoNA <-na.omit(hPower2D)




GAP <- as.numeric(hPower2DNoNA$Global_active_power)

 ## typeof(DateTime) is character
DateTime <- paste(hPower2DNoNA $Date, hPower2DNoNA $Time)

 ## class(DateTime1) = POSIXlt
DateTime1 <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")

## class(DateTime2)  "POSIXct" or double
DateTime2<-as.POSIXct(DateTime1)

par(mar=c(5,4,3,2))
plot(DateTime2,GAP, pch=46,type = "l",xlab="",ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png") 
dev.off()