
#change necessary settings, download file, unzip, and read into data frame called "data"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setInternet2(TRUE)
download.file(fileUrl, destfile = "./household_power_consumption.zip", method = "auto")
unzip("household_power_consumption.zip")
data <-read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#date and time handling
data$Date <- as.character (data$Date)
data$Date <- as.Date (data$Date, "%d/%m/%Y")

#reduce data set size to dates 2007-02-01 and 2007-02-02
my_data <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]

#convert time into R format
my_data$Time<- paste(as.character(my_data$Date), my_data$Time)
my_data$Time <- strptime(my_data$Time, "%Y-%m-%d %H:%M:%S")

#open png device, make line plots
png(filename = "./ExData_Plotting1/Plot3.png", width = 480, 
    height = 480, unit = "px")
with(my_data, plot(Time, Sub_metering_1 , type = "n", 
     xaxp = c(0,length(my_data$Date),3), xlab = "",
     ylab = "Energy sub metering",
     yaxp = c(0,40,4)))
with (my_data, lines (Time, Sub_metering_1, col = "black"))
with (my_data, lines(Time, Sub_metering_2, col = "red"))
with (my_data, lines(Time, Sub_metering_3, col = "blue"))

#make legend
legend("topright", legend = c("Sub_metering_1", 
  "Sub_metering_2", "Sub_metering_3") , lty = rep(1,3), 
  col = c("black", "red", "blue"),xpd = NA, xjust = 0.5, yjust = 0.5)

#turn off device

dev.off()