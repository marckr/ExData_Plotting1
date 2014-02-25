## Load data set
if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile = "./data/household_power_consumption.zip", method="curl")
  unzip("./data/household_power_consumption.zip", exdir = "./data")
  rm("./data/household_power_consumption.zip")
  
}

## Getting dataset
data_full <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 1
png(filename = "plot1.png", 
      width = 480, height = 480, 
      units = "px")
hist(data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     breaks = 12, ylim = c(0, 1200))
dev.off()
