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

##plot the graph
with(targetData,{plot(Sub_metering_1~exactTime, type="l",
                     ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~exactTime,col='Red')
  lines(Sub_metering_3~exactTime,col='blue')})
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=C("black","red","blue"))
