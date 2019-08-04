rm(list = ls()) 
setwd("C:/Users/nicolelin/Desktop/Coursera_Data Science/exdata_data_household_power_consumption")

'preview the original data
Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
16/12/2006;17:27:00;5.388;0.502;233.740;23.000;0.000;1.000;17.000'


#1>> load data from the dates 2007-02-01 and 2007-02-02
fname <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fname), value = TRUE),
                   col.names = c("Date", "Time", "Global_active_power",
                                 "Global_reactive_power", "Voltage", 
                                 "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"),
                   sep = ";",
                   na.strings = "?")

#2.1>> plot1 Global Avtive Power: histogram
hist(data$Global_active_power,
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col ="red")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

#2.2>> plot2 Global Avtive Power: curve
stime <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
plot(stime, data$Global_active_power,
     type = "l", 
     xlab = " ",
     ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

#2.3>> plot3 Energy submetering: line
tlegend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
clegend <- c("black", "red", "blue")
# define the dim of the figure first to avoid legend cutoff
png("plot3.png", width = 480, height = 480)
plot(stime, data$Sub_metering_1,
     type = "l", 
     xlab = " ",
     ylab = "Energy sub metering")
lines(stime, data$Sub_metering_2, col = "red")
lines(stime, data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = tlegend, 
       col = clegend,
       lty = "solid")
dev.off()

#2.4>> plot4 combining plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data,{
        plot(stime, Global_active_power,
             type = "l", xlab = " ", ylab = "Global Active Power")
        plot(stime, Voltage, 
             type = "l", xlab = "datetime", ylab="Voltage")
        plot(stime, Sub_metering_1, 
             type = "l", xlab=" ", ylab="Energy sub metering")
        lines(stime, Sub_metering_2, col = "red")
        lines(stime, Sub_metering_3, col = "blue")
        legend("topright", tlegend, col = clegend, lty = 1, bty = "n")
        plot(stime, Global_reactive_power,
             type = "l", xlab = "datetime", ylab ="Global_reactive_power")
})
dev.off()
