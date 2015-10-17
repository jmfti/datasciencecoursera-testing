library(dplyr)

data <- read.csv("w4oc.csv")

head(data)
strsplit(names(data), "wgtp")[[123]]


data2 <- read.csv("w4oc2.csv", colClasses=c("character"))
data2$X.3 <- as.numeric(gsub(",", "", data2$X.3))
data3 <- read.csv("w4oc3.csv", colClasses=c("character"))

# simple way using sqldf
sqldf("select count(*) from data2 d2 inner join data3 d3 on d2.X = d3.CountryCode where \"Special.Notes\" like '%Fiscal year end: June%'")

# another way
data4 <- left_join(data2, data3, by=c("X" = "CountryCode"))
head(data4)

data4 %>% select(Special.Notes) %>% filter(grepl("Fiscal year end: June", Special.Notes)) %>% summarize(count=n())


# another one
nrow(data4[which(grepl("Fiscal year end: June", data4$Special.Notes)),])


library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 