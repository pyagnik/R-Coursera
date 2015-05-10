# read data from source files
source_data <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", as.is=TRUE)

# Formatting Date column
source_data$Date <- as.Date(source_data$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(source_data, subset=(Date == "2007-02-01" | Date == "2007-02-02"))

# Remove source_data to free memory
rm(source_data)

## Creating plot1
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()