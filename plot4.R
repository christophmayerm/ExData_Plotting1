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

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

par(mfrow = c(2,2))
plot(x = date_time, 
     y = parse_number(sub_set$Global_active_power), 
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     lwd = 0.8)

plot(x = date_time, 
     y = parse_number(sub_set$Voltage), 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     lwd = 0.8)

plot(x = date_time, 
     y = parse_number(sub_set$Sub_metering_1), 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     lwd = 0.8)
lines(x = date_time, y = parse_number(sub_set$Sub_metering_2), col = "red")
lines(x = date_time, y = parse_number(sub_set$Sub_metering_3), col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"),
       lty = 1,
       box.lty = 0,
       inset = 0.02,
       col = c("black", "red", "blue")
)

plot(x = date_time, 
     y = parse_number(sub_set$Global_reactive_power), 
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     lwd = 0.5)

dev.off()

