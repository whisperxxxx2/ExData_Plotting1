##load data and format the date column
targetData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?",
                         colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
targetData$Date <- as.Date(targetData$Date, "%d/%m/%Y")

## choose a specific subset and remove missing data
targetData <- data[which(data$Date %in% as.Date(c("2007-02-01","2007-02-02"))),]
targetData <- targetData[complete.cases(targetData),]

## combine date and time together
exactTime <- paste(targetData$Date, targetData$Time)
exactTime <- setNames(exactTime, "exactTime")
targetData <- cbind(exactTime, targetData)
targetData$exactTime <- as.POSIXct(exactTime)

## plot4
par(mfrow=c(2,2), mar=c(4,4,1,1), oma=c(0,2,2,0))
with(targetData, {
  plot(Global_active_power~exactTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~exactTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~exactTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~exactTime,col='Red')
  lines(Sub_metering_3~exactTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~exactTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

