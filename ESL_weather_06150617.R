##### 7/17/17
### Weather Station Data -ESL (Lower Moro Trail) from June 01, 2015 - June 01, 2017
### CEB-UCI

setwd("C:/Users/Sally/Desktop/UCI/")

weather=read.csv("ESL_weather_06150617.csv", header = T)
## can use read.table instead of read.csv for reading in txt files so you can skip the excel step!

names(weather)
colnames(weather) <- c("timestamp", "temp", "RH", "wind_spd", "wind_dir", "solar", "precip")
weather$date <- as.Date(weather[,1], format = '%m/%d/%Y')
str(weather)

#tested as.Date 
#weather[1,1]
#as.Date(weather[1,1], format = '%m/%d/%Y')

#Failed MAx function
#MAX <- function (x) {max (x,na.rm = T)}
#Tdmax<-tapply(weather$temp1, list(weather$date), max, na.rm = T)
##Warning message:
  ##In FUN(X[[i]], ...) : no non-missing arguments to max; returning -Inf
### Tdmax<-aggregate(x = weather$temp1, list(weather$date), MAX, na.action = NULL)
###Error in FUN(X[[i]], ...) : unused argument (na.action = NULL)
##Called from: (function () 
##{
  ##.rs.breakOnError(TRUE)
##})()

#created new column for numeric temp
weather$temp1 <- as.numeric(as.character(weather$temp))

Totdmax<- aggregate(temp1~date, data = weather, max, na.rm =T)

Totdmin<- aggregate(temp1~date, data = weather,  min, na.rm = T)

Totdprecip<- aggregate(precip~date, data = weather, sum, na.rm = T)

#average daily max and min per mo.
#tried to obtain monly averages but stopped
weather$MoYr <- format(as.Date(weather$date), "%Y/%m")
head(weather$MoYr)

##sum total precip
Totmprecip<- aggregate(precip~MoYr, data = weather, sum, na.rm = T)

## Greg's Code from R Workshop
daymaxmin <- data%>%
  group_by( day = floor_date(Date, "day")) %>%
  summarize(N = n(), Tmax = max(Temp.F), Tmin = min)....

