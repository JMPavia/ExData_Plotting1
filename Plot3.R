# PLOT 3

# COURSE PROJECT Week 1 for coursera course 'Exploratory Data Analysis'

# The code assumes that the file containing the data to be handled in the
# project has been unzipped in the working directory. Otherwise,
# the zip file cointaining the raw data is donwloaded and the file unzipped.

#.....................................................................
# TESTING FILE AVAILABILITY
dirfile2 <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
# Test to know if the raw file is available in the working directory
if (!file.exists("household_power_consumption.txt")) {
       download.file(dirfile2, destfile = "Dataset.zip")
       unzip("Dataset.zip")
}
#----------------------------------------------------------------------

if (!file.exists("power.base.csv")) {
#.....................................................................
# READING THE DATA
 power.base <- read.table('household_power_consumption.txt', header=TRUE,
                        sep=';', na.strings='?', colClasses=
                        c(rep('character', 2), rep('numeric', 7)) )
#----------------------------------------------------------------------

#.....................................................................
# COVERT DATES AND TIMES

# Loading package lubridate
if (!require(lubridate)) {
   install.packages("lubridate")
}
require(lubridate)

power.base$Date <- dmy(power.base$Date)
power.base$Time <- hms(power.base$Time)

# REDUCING DATA FRAME TO FIRST AND SECOND OF FEBRAURY 2007
power.base <- subset(power.base, year(Date) == 2007 &  month(Date) == 2 &
                                 (day(Date) == 1 | day(Date) == 2) )
#----------------------------------------------------------------------

#.....................................................................
# SAVE DATA FOR LATER USE IN FIGURES
write.table(power.base, "power.base.csv", sep=";", row.names=F)
#----------------------------------------------------------------------
}

#.....................................................................
# PLOT 3
# Reading data
power.base <- read.csv("power.base.csv", sep=";")

# File of plot
png("plot3.png", width = 480, height = 480)

# Making the figure
plot(power.base$Global_active_power, ylab='Global Active Power (kilowatts)', xlab='',
     type='l', xaxt = 'n')

axis(1, at=c(1, nrow(power.base)/2, nrow(power.base)) , labels=c("Thu", "Fri", "Sat"))

# Turn off device
dev.off()
#----------------------------------------------------------------------

ylimits = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3))
plot(df$Time, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
par(new = TRUE)
plot(df$Time, df$Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
par(new = TRUE)
plot(df$Time, df$Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       #bg = "transparent",
       #bty = "n",
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
dev.off
