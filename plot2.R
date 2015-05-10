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

## Creating plot2
plot(data$Global_active_power ~ data$date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    
#Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()