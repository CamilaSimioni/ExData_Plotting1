#Set a file

setwd("C:/Users/Hand 07/Desktop/Curso/Curso_4/Week_1/ExData_Plotting2")

arquivo <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(arquivo, destfile = "./arquivozip.zip", method="curl")

unzip(zipfile = "./arquivozip.zip", exdir = "./Pasta_2")

#Set a path

path_rf <- file.path("./Pasta_2" , "household_power_consumption")

files<-list.files(path_rf, recursive=TRUE)

#Power consumption data - reading, give name and subsett dataset
data.power <- read.table("./Pasta_2/household_power_consumption.txt", skip = 1, sep = ";")

names(data.power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower1 <- subset(data.power,data.power$Date=="1/2/2007" | data.power$Date =="2/2/2007")

#Print in PNG
png("plot1.png", width=480, height=480)

#calling the basic plot function
hist(as.numeric(as.character(subpower1$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

#title
title(main="Global Active Power")


#save
dev.off()

