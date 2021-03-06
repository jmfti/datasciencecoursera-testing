### READING FROM THE WEB

# web scraping is programatically extracting data from html code of web pages

con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlcode <- readLines(con)
close(con)
head(htmlcode)

# other way of doing it is using XML

library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@id='col-citedby']", xmlValue)


## GET from httr library
library(httr)

html2 <- GET(url)
content2 <- content(html2, as="text")
parsedHTML <- htmlParse(content2, asText=TRUE)
xpathSApply(parsedHTML, "//title", xmlValue)

## authenticating 
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd")
pg1 # response is 401 as im not able to read without authorization

pg2 <- GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user", "passwd"))
pg2

names(pg2)

# if we want to keep our authentication through navigation we use handles

google <- handle("http://google.com")
pg1 <- GET(handle=google, path="/")
pg2 <- GET(handle=google, path="search")


### READING FROM APIS

myapp <- oauth_app("twitter", 
                   key="***", # customer key
                   secret="***"  # secret customer key
                   )

sig <- sign_oauth1.0(myapp, 
                     token="***", # access token
                     token_secret="****" # access secret token
                     )
hometl <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json <- content(hometl)
json2 <- jsonlite::fromJSON(jsonlite::toJSON(json))
json2[1,1:4]

### reading foreign data
# read.arff - reads weka files
# read.dta - reads Stata files
# read.mtp - reads minitab files
# read.octave - reads octave files
# read.spss - reads SPSS files
# read.xport - reads SAS files

## RPostgreSQL https://cran.r-project.org/web/packages/RPostgreSQL/index.html

## reading images
# jpeg https://cran.r-project.org/web/packages/jpeg/index.html
# readbitmap https://cran.r-project.org/web/packages/readbitmap/index.html
# png https://cran.r-project.org/web/packages/png/index.html
# EBImage (bioconductor) http://bioconductor.org/packages/release/bioc/html/EBImage.html


## GIS data (geographic data)
# rgdal https://cran.r-project.org/web/packages/rgdal/index.html
# rgeos https://cran.r-project.org/web/packages/rgeos/index.html
# raster https://cran.r-project.org/web/packages/raster/index.html

## reading music data
# tuneR https://cran.r-project.org/web/packages/tuneR/index.html
# seewave https://cran.r-project.org/web/packages/seewave/index.html


## sqldf makes possible to send SQL queries to our data frames
# used for working in other formats : install.packages("foreign") includes spss data files