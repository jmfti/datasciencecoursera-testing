## week 3 work obtaining and cleaning data
library(dplyr)

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="w3oc.csv")
data <- read.csv("w3oc.csv")

head(data)

data$agricultureLogical <- data$ACR == 2 & data$AGS == 6

data[which(data$agricultureLogical == T),]

# install.packages("jpeg")
library(jpeg)
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="testfile.jpg")
img <- readJPEG("testjeff.jpg", native=T)
# now get quantiles for 30 and 80%
quantile(img, c(0.3,0.8))


#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="w3oc2.csv")
data2 <- read.csv("w3oc2.csv", colClasses=c("character"))
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="w3oc3.csv")
data3 <- read.csv("w3oc3.csv", colClasses=c("character"))

# Match the data based on the country shortcode. How many of the IDs match? 
#Sort the data frame in descending order by GDP rank (so United States is last). 
#What is the 13th country in the resulting data frame? 
data4 <- left_join(data2, data3, by=c("X" = "CountryCode"))
names(data4)[2] <- "ranking"
data4$X.3 <- as.numeric(gsub(",","",data4$X.3))
data4$ranking <- as.numeric(data4$ranking)
data4 %>% filter(!is.na(ranking)) %>% arrange(desc(X.3)) %>% slice(13) 

## What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

data5 <- data4 %>% filter(!is.na(ranking)) %>% group_by(Income.Group) %>% summarize(meangroup = mean(ranking))

# Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. How many countries are 
#Lower middle income but among the 38 nations with highest GDP?

#data6 <- filter(data4, !is.na(ranking))
#library(Hmisc)
#cut2(data6$ranking, g=5)

