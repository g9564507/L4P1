library(data.table)




householdPower <- fread("household_power_consumption.txt")
## head(householdPower,2)  # default print 6 rows

##typeof(householdPower[1])

##names(householdPower)


hPower2D<- householdPower[householdPower$Date=="1/2/2007"| householdPower$Date=="2/2/2007"]

## Eliminate "?""
## na.omit can omnit NA
hPower2D[hPower2D=="?"]<- NA
hPower2DNoNA <-na.omit(hPower2D)


hist( as.numeric(hPower2DNoNA$Global_active_power), col="red",main="Global Active Power" ,xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.copy(png, file = "plot1.png") 
dev.off()



#file<-"household_power_consumption.txt"
#householdPower <- read.table(file, sep = ";", header = TRUE)


#con <- file("foo.txt", "r") 
#data <- read.csv(con) 
#close(con) 