### CREATING NEW VARIABLES

## creating cathegorical variables
if (!file.exists(("./data")))
  dir.create("./data")

url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
#download.file(url, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

head(restData , n=10)

# we can create a cathegorical group for example with cut
restData$zipGroups <- cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

# now we could display how many zipcodes are there for every cathegorical group 
# and every zip code 
table(restData$zipGroups, restData$zipCode)

## easy cutting with Hmisc
# install.packages("Hmisc")
library(Hmisc)

restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)

## common transforms
# abs(x)
# sqrt(x)
# ceiling(x)
# floor(x)
# round(x, digits=n)
# signif(x, digits=n)
# cos(x), sin(x)...
# log(x)
# log2(x), log10(x)
# exp(x)

### RESHAPING DATA

## the goal is tidy data : 
# each variable forms a column
# each observation forms a row
# each table/file stores data about one kind of observation (e.g. people, hospitals...)

# we will use reshape2 now
library(reshape2)
head(mtcars) 
# first we add a row called carname to store the car names
mtcars$carname <- rownames(mtcars)
# now we melt data frames, transforming columns into rows for every car
# so if we have cyl = 1,2,3,1,2,1,4,2 will be transformed into 
# (variable, value) = [('cyl', 1), ('cyl', 2), ('cyl', 3), ... ]
carMelt <- melt(mtcars, id=c("carname", "gear", "cyl"), measure.vars=c("mpg", "hp"))
head(carMelt, n=5)
tail(carMelt, n=5)

## gouping by sum
# ddply(InsectSprays, .(spray), summarize, sum=sum(count))
# this one last is not working
# but we can make
aggregate(InsectSprays$count, list( spray = InsectSprays$spray), sum)
# or 
tapply(InsectSprays$count, InsectSprays$spray, sum)

