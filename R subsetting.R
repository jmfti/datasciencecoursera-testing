
# subsetting in R

# $ used to extract elements of a list or data frame by name

# [[ used to extract elements of a list or a data frame
# [ always returns an object of the same class, it will be the same class

x <- c("a", "b", "c", "d", "e")

x[1]
x[2]
x[[1]]

# extracting a range of elements

x[1:4]

# we can create a subset by specifing rules

x[ x > "a" ]

# we can create logical vectors to see how many of the elements are true for what we specify
u <- x > "b" # this will store c(F,F,T,T,T) in u

## lists subsetting

x <- list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)] # this will return x[1] and x[3]

x <- list(a=list(10,12,14), b=c(3.14, 2.81))

x[[c(1,3)]] # will print x[1][3] 

x[[1]][[3]] # will print x[1][3]

x[[c(2,1)]] # will print x[2][1]

## matrices subsetting

x <- matrix(1:6, 2, 3)

x

x[1, 2]

x[2, 1]

# to get all the elements from row 1

x[1, ]

# to get all the elements from column 2

x[, 2]

# by default when a single element is retrieved it is returned as a vector of length 1 rather than a matrix of 1x1
# this can be turned off by setting drop = FALSE

x[1,2, drop=FALSE] # will return the element itself

x[1,2] # will return a matrix of 1x1

x[1, , drop=FALSE] # will return a 1x3 matrix


## partial matching

# its allowed with [[ and $

x <- list(aardvark = 1:5)
x$a # will return the first name that matches the name provided

x[["a"]] # will match only exact name 'a', so it won't match with aardvark

x[["a", exact=FALSE]] # will match just like $

## REMOVING NA values

# this is for cleaning out data

x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x) # bad will be a logical vector
x[!bad] # specifies what elements will be retrieved c(F,F,T,F,T,F)

x[complete.cases(x)] # will return the valid numbers

## VECTORIZED OPERATIONS
# R provides ways to make operations with vectors without loops

x <- 1:4; y <- 6:9
x + y # will return { c | c = x_i + y_i }

x > 2 # will return a logical vector just like y == 8

x * y # { c | c = x_i * y_i }

x / y # { c | c = x_i / y_i }

# vectorized matrix operations

x <- matrix(1:4, 2, 2); y <- matrix(rep(10,4), 2, 2)

x * y # { c_i,j | c_i,j = x_i,j * y_i,j } = element-wise operation

x %*% y # is the true matrix product

# some things

1:4 + 2 # will return x_i + 2

x <- c(3,5,1,10,12,6)
x[ x < 6 ] <- 0 # this will set all elements of x less than 6 to 0
x[ x %in% 1:5 ] <- 0 # will do the same 

# reading data

csv <- read.csv("hw1_data.csv") # this will return a data frame
names(csv) # names of data frame
csv[1:4, ] # will return the first 1 to 4 rows with all columns

##################
# exercises with hw1_data.csv
##################

# get mean of Solar.R when Ozone > 31 and Temp > 90
# to get valid values we must first clean the data

matching <- csv$Ozone > 31 & !is.na(csv$Ozone) & csv$Temp > 90 & !is.na(csv$Temp)
mean(csv[matching,]$Solar.R)	# mean of those ones for Solar.R

# get mean of temp when month = 6

mean(csv[ !is.na(csv$Temp) & csv$Month == 6 , ]$Temp )

# get the maximum temp when month was 5

max( csv[ !is.na(csv$Temp) & csv$Month == 5, ]$Temp )

# get the mean of Solar.R when temp > 90 and Ozone > 31

mean(csv[ !is.na(csv$Temp) & !is.na(csv$Ozone) & csv$Temp > 90 & csv$Ozone > 31 , ]$Solar.R)

