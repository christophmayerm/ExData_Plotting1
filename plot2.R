library(readr)
library(lubridate)

if(!file.exists("./household_power_consumption.txt")){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        download.file(url = url, destfile = "./download.zip")
        
        unzip("./download.zip")
}

if(is.null(data)){
        data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
}

sub_set <- data[dmy(data$Date) >= ymd("2007-02-01") & dmy(data$Date) <= ymd("2007-02-02"), ]

date_time <- as.POSIXct(paste0(sub_set$Date, " ", sub_set$Time), format="%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

plot(x = date_time, 
     y = parse_number(sub_set$Global_active_power), 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
