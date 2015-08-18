### subsetting and sorting

library(datasets)

# which deals with NA values

head(iris[which(iris$Sepal.Width > 3.1),])


sort(iris$Sepal.Length)

sort(iris$Sepal.Length, decreasing=T)

# we can make NA values to be the last

sort(iris$Sepal.Length, decreasing=T, na.last = T)

# we can get data ordered by doing

iris[order(iris$Sepal.Length),]

# if we want to order by 2 variables 

iris[order(iris$Sepal.Length, iris$Sepal.Width),]

## PLYR library
library(plyr)

arrange(iris, Sepal.Length)
# ordering (ascending, descending)
arrange(iris, desc(Sepal.Length))

## adding rows and columns
iris$randomdata <- rnorm(nrow(iris))

iris

### summarizing data

if (!file.exists(("./data")))
  dir.create("./data")

url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
#download.file(url, destfile="./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

head(restData , n=10)

# lets see quantiles for councilDistrict
quantile(restData$councilDistrict, na.rm=TRUE)
# getting the quantiles we want
quantile(restData$councilDistrict, na.rm=TRUE, probs=c(0.5,0.75,0.9))

## making a table with 2 variables
table(restData$councilDistrict, restData$zipCode)

## checking for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

# theres some zipcodes under 0?
restData[which(restData$zipCode < 0),]

# we can make tests over all columns with colSums for example
colSums(is.na(restData))

table(restData$zipCode %in% c("21212", "21213"))

## cross tabs
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)

# to create a cross tab we use xtabs
xt <- xtabs(Freq ~ Gender + Admit, data=df)
xt
# when specifying the relationship in the function call, here Freq (left side of the relatio)
# is what we want to display in the table. in this table we want to display Freq variable
# Gender + Admit (right side of the relation) will be the the variables we will use as 
# columns and rows to summarize the data

# now, if we want to make cross tabs for all variables in columns and rows but displaying 
# 1 variable we can use '.' in the relationship to specify that we want all possible combinations

warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks ~ . , data=warpbreaks)
xt

# but this is hard to analize so one possible os to flat this crosstabs with ftable

ftable(xt)