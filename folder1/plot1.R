##load data

data <- read.table("household_power_consumption", header = TRUE, stringsAsFactors = FALSE, sep = ";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

##select a specific subset 

targetData <- data[which(data$Date %in% as.Date(c("2007-02-01","2007-02-02"))),]
targetData$Global_active_power <- as.numeric(targetData$Global_active_power)

##plot the histogram

png(filename = "plot1.png")
par(las=1)
hist(Global_active_power, xlab="Global Active Power (kilowatts)", ylab = "Frequency",
     main="Global Active Power", col="red")
dev.off()

