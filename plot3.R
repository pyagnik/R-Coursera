# read data from source files
source_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", as.is=TRUE)

# Formatting Date column
source_data$Date <- as.Date(source_data$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(source_data, subset=(Date == "2007-02-01" | Date == "2007-02-02"))

# Remove source_data to free memory
rm(source_data)

## Converting dates
date_time <- paste(as.Date(data$Date), data$Time)
data$date_time <- as.POSIXct(date_time)

## Creating plot3
with(data, {
                plot(Sub_metering_1 ~ date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
                lines(Sub_metering_2 ~ date_time,col='Red')
                lines(Sub_metering_3 ~ date_time,col='Blue')
            })

# Creating Legend
legend ("topright",
            col = c("Black", "red", "blue"), 
        	legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        	cex=0.6,lwd=1)


## Creating png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
