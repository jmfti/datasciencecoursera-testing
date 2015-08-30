### MERGING DATA
## its a common task in SQL when we join tables by the id of an entity
## so we are going to do the same thing

url <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
url2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
#download.file(url, destfile="./data/reviews.csv")
#download.file(url2, destfile="./data/solutions.csv")

reviews <- read.csv("./data/reviews.csv") 
solutions <- read.csv("./data/solutions.csv")

head(reviews, 2)
head(solutions, 2)

## mergind our data
# merge accepts parameters { x, y, by, by.x, by.y, all }

# if we do
names(reviews)
names(solutions)
# we see that we have an ID for review but also we have an id_solution in reviews
# so we will join this data frames by solution(id) and reviews(solution_id)
md <- merge(reviews, solutions, by.x="solution_id", by.y="id", all=T)
head(md)
intersect(names(reviews), names(solutions)) # no need to explain
md2 <- merge(reviews, solutions, all=T) # this will merge by common column names (which is not usually correct)

## USING JOIN IN DPLYR PACKAGE
# this is easier, less featured but its ok
# it makes a left join for default
library(dplyr)
# in older versions of dplyr specifying differente column names for common ids was not possible
# now it should be
md2 <- left_join(reviews, solutions, by.x=solution_id, by.y=id)
head(md2)

# more about R merging http://www.statmethods.net/management/merging.html