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

##plot the line graph.
png(filename = "plot2.png")
targetData$exactTime <- as.POSIXct(exactTime)
with(targetData,plot(Global_active_power~exactTime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
