fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "HouseholdPower.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(destfile)) {
        download.file(fileUrl, destfile, method="curl")
        unzip(destfile)
        file.remove(destfile)
}


alldata <- read.table(filename, sep=";", header=TRUE, na.strings = "?",
                      colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric"))
convertdate <- as.Date(alldata$Date, format = "%d/%m/%Y")
daterows <-grep("2007-02-01|2007-02-02",convertdate)

reldata <- alldata[daterows,]
reldata$dtcombo <- paste(reldata$Date, reldata$Time, sep = " ")
reldata$dtcombo <- strptime(reldata$dtcombo, format = "%d/%m/%Y %H:%M:%S")

png("plot3.png")
with(reldata,
     plot(dtcombo, Sub_metering_1, 
          type = "l",
          col="black",
          main="",
          xlab = "",
          ylab = "Energy sub metering")
)
with(reldata,
     points(dtcombo, Sub_metering_2, 
          type = "l",
          col="red")
)
with(reldata,
     points(dtcombo, Sub_metering_3, 
          type = "l",
          col="blue")
)
legend ("topright", 
        lty =1,
        col=c("black","red","blue"), 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)
dev.off()
