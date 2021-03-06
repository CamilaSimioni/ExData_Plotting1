#Set a file

setwd("C:/Users/Hand 07/Desktop/Curso/Curso_4/Week_1/ExData_Plotting2")

arquivo <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(arquivo, destfile = "./arquivozip.zip", method="curl")

unzip(zipfile = "./arquivozip.zip", exdir = "./Pasta_2")

#Set a path

path_rf <- file.path("./Pasta_2" , "household_power_consumption")

files<-list.files(path_rf, recursive=TRUE)

#Power consumption data - reading, give name and subsett dataset:

data_power_con <- read.table("./Pasta_2/household_power_consumption.txt",skip=1,sep=";")
names(data_power_con) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(data_power_con,data_power_con$Date=="1/2/2007" | data_power_con$Date =="2/2/2007")



#Transforming the Date and Time vars from characters into objects of type Date and POSIXlt alike:
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#Composite plot with many graphs
par(mfrow=c(2,2))

#Calling the basic plot function
with(subpower,{
  plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subpower$Time,as.numeric(as.character(subpower$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subpower$Time,as.numeric(as.character(subpower$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

#Print in PNG
png("plot4.png", width=480, height=480)
#save
dev.off()


