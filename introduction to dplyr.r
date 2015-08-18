### Introduction to dplyr package
# this packages simplifies the use of R by using the functions
# select - return a subset of the columns of a data frame
# filter - extract a subset of rows from a data frame based on logical conditions
# arrange - reorder rows of data
# rename - rename variables in a data frame
# mutate - add new variables / columns or transform existing variables
# summarise / summarize - generate summary statistics of different variables 
# in the data frame, possibly within data

# so it is just like SQL, where we construct select statements 
# select ... as ...(rename) from table where(filter) ... group by ...(summarise) having ...(nothing?)

library(dplyr)
# we will get a subset that has only the columns Ozone, Solar.R and Wind
head(select(airquality, Ozone:Wind))
# now the subset which does not have Ozone, Solar.R and Wind
head(select(airquality, -(Ozone:Wind)))
# now we can get the subset of rows whose month is 5
filter(airquality, Month == 5)
# we can put more conditions on our filter
filter(airquality, Month=5 & Wind < 13)
# we could reorder airquality by day of month for example using arrange
arrange(airquality, Day)
# or by day and temperature
arrange(airquality, Day, Temp)
# or by day ascending and temperature descending order
arrange(airquality, Day, desc(Temp))
#renaming
rename(airquality, SolarR = Solar.R)

# adding columns 
# we could want to add a column, for example, to see how far a temperature is from the mean
mutate(airquality, deviation = Temp - mean(Temp))
# now we could cathegorize every day as cold or hot by adding a column using factors
mydata <- mutate(airquality, tempcat = factor( 1 * (Temp > 80) , labels=c("cold", "hot")))
# and we can group by our factor
group_by(mydata, tempcat)

# if we want to know the mean and maximum temperature for the group by selection we can use summarize
summarize(group_by(mydata, tempcat), meantemp = mean(Temp), max(Temp))

# dplyr package has a special operator that makes possible to chain operations like filter and group by
# i want to add a column to airquality which has the difference of Ozone with mean(Ozone) and then 
# i want to group by month and get the mean temperature for every month
airquality %>% mutate(difozone = Ozone-mean(Ozone)) %>% group_by(Month) %>% summarize(meantemp = mean(Temp), difozone)