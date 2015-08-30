## working with dates

d1 <- date()
d2 <- Sys.Date()

## formatting dates
format(d2, "%Y-%m-%d")

# if we had a vector of dates we could make
x <- c("1/2/1960", "2/2/1960", "31/3/1960", "30/5/1960")
z <- as.Date(x, "%d/%m/%Y")
z

z[1] - z[2] + 0.2
class(z[2] - z[1])

# date + integer = date + days
# to get the difference as integer do 
as.numeric(z[2] - z[1])

## Converting to Julian
weekdays(d2)
months(d2)
julian(d2)

## Lubridate
library(lubridate)

ymd("20140108") # year month day
mdy("08/04/2013") # month day year
dmy("25/03/2015") # day month year

## dealing with times
ymd_hms("2015-08-03 11:52:01")
ymd_hms("2015-08-03 11:52:01", tz="Europe/Madrid")

wday(ymd("2015-08-30"))
wday(ymd("2015-08-30"), label=TRUE)
wday(ymd("2015-08-31"), label=TRUE)

## more about dates
# http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/
# https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html