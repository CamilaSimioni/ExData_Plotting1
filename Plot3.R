#Set a file

setwd("C:/Users/Hand 07/Desktop/Curso/Curso_4/Week_1/ExData_Plotting2")

arquivo <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(arquivo, destfile = "./arquivozip.zip", method="curl")

unzip(zipfile = "./arquivozip.zip", exdir = "./Pasta_2")

#Set a path

path_rf <- file.path("./Pasta_2" , "household_power_consumption")

files<-list.files(path_rf, recursive=TRUE)

#Power consumption data - reading, give name and subsett dataset:

data_power <- read.table("./Pasta_2/household_power_consumption.txt",skip=1,sep=";")
names(data_power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data_subpower <- subset(data_power,data_power$Date=="1/2/2007" | data_power$Date =="2/2/2007")

#Print in PNG
png("plot3.png", width=480, height=480)

#Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
data_subpower$Date <- as.Date(data_subpower$Date, format="%d/%m/%Y")
data_subpower$Time <- strptime(data_subpower$Time, format="%H:%M:%S")
data_subpower[1:1440,"Time"] <- format(data_subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_subpower[1441:2880,"Time"] <- format(data_subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


#Basic plot functions
plot(data_subpower$Time,data_subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(data_subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(data_subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data_subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Title
title(main="Energy sub-metering")