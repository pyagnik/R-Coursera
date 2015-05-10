# read data from source files
source_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", as.is=TRUE)

# Formatting Date column
source_data$Date <- as.Date(source_data$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(source_data, subset=(Date == "2007-02-01" | Date == "2007-02-02"))

# Remove source_data to free memory
rm(source_data)

# Converting dates
date_time <- paste(as.Date(data$Date), data$Time)
data$date_time <- as.POSIXct(date_time)

# Creating sections in the device
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

# Creating plot4
with(data, {
    plot(Global_active_power ~ date_time, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage ~ date_time, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1 ~ date_time, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2 ~ date_time,col='Red')
    lines(Sub_metering_3 ~ date_time,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", cex=0.4, # bty removes border; cex shrinks legend size
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ date_time, type="l", 
         ylab="Global_Rective_Power",xlab="datetime")
})

# Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
