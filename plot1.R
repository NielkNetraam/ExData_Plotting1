# save locale and set locale to english
lc_time <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "en_US")

# read dataset
hpc <- read.csv("household_power_consumption.txt", na.strings = "?", sep=";"
, col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#convert to date and time types
hpc <- hpc %>% mutate(Timestamp = dmy_hms(paste(Date, Time))) %>% mutate(Date = dmy(Date)) %>% mutate(Time = hms(Time))

#create subset
hpcs <- subset(hpc, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

png(filename = "plot1.png", height = 480, width = 480)
hist(hpcs$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

# restore original locale
Sys.setlocale("LC_TIME", lc_time)
