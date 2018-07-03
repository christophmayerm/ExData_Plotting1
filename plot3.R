library(readr)
library(lubridate)

# make sure that weekdays are presented in English
Sys.setlocale("LC_TIME", "C")

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

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

plot(x = date_time, 
     y = parse_number(sub_set$Sub_metering_1), 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = date_time, y = parse_number(sub_set$Sub_metering_2), col = "red")
lines(x = date_time, y = parse_number(sub_set$Sub_metering_3), col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue")
       )

dev.off()
