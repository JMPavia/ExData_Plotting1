
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
