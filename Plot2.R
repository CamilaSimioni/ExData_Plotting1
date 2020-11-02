#Set a file

setwd("C:/Users/Hand 07/Desktop/Curso/Curso_4/Week_1/ExData_Plotting2")

arquivo <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(arquivo, destfile = "./arquivozip.zip", method="curl")

unzip(zipfile = "./arquivozip.zip", exdir = "./Pasta_2")

#Set a path

path_rf <- file.path("./Pasta_2" , "household_power_consumption")

files<-list.files(path_rf, recursive=TRUE)

#Power consumption data - reading, give name and subsett dataset
data_power_con <- read.table("./Pasta_2/household_power_consumption.txt",skip=1,sep=";")
names(data_power_con) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data_subpower_con <- subset(data_power_con,data_power_con$Date=="1/2/2007" | data_power_con$Date =="2/2/2007")


#Print in PNG
png("Plot2.png", width=480, height=480)


#Transforming Date and Time variables from characters to objects of type Date and POSIXlt alike
data_subpower_con$Date <- as.Date(data_subpower_con$Date, format="%d/%m/%Y")
data_subpower_con$Time <- strptime(data_subpower_con$Time, format="%H:%M:%S")
data_subpower_con[1:1440,"Time"] <- format(data_subpower_con[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_subpower_con[1441:2880,"Time"] <- format(data_subpower_con[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


#Basic plot function
plot(data_subpower_con$Time,as.numeric(as.character(data_subpower_con$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

#title
title(main="Global Active Power Vs Time")

#save
dev.off()
