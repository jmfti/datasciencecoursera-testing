## LOOP FUNCTIONS

# lapply (loop over a list and evaluate a function on each element)
# sapply (like lapply but trying to simplify result)
# apply (apply a function over the margins of an array)
# tapply (apply a function over SUBSETS of a vector)
# mapply (multivariate version of lapply)

# split is very used specially with lapply

# tapply it executes a function over the subsets of a vector

# lapply always return a list, example

x <- list(a=1:5, b=rnorm(10))
lapply(x, mean)
x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x, mean)

# runif generates a vector of random numbers, the argument is the number of elements to be created

x <- 1:4
lapply(x, runif)

# additional arguments can be passed to lapply to pass to our function, example

lapply(x, runif, min=0, max=10)

# anonymous functions can be passed as argument to lapply

# an example trying to extract the first column of a list of matrices

x <- list(a=matrix(1:4, 2,2), b=matrix(1:6, 3, 2))

x

lapply(x, function(elt) elt[,1])  # extract all elements from first column for each element (each matrix)

# sapply
# if the result is a list where every element is length 1, then a vector is returned
# if the result is a list where every element is a vector OF THE SAME LENGTH (length > 1) a matrix is returned
# if it can't figure out it will return a list

x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
sapply(x, mean)


## APPLY FUNCTION
# it is most often used to apply a function to the rows or columns of a matrix
# can be used with general arrays, example : taking the average of an array of matrices
# internally it does a loop so it's not faster than writing a loop, but easier as it is 1 line long

# in apply you must specify the dimension that you want to preserve
# in a matrix of 20 x 10 elements we have dimension = 2.
# if we pass 2 to apply we will collapse the second dimension (the rows) applying the specified function
# if we pass 1 to apply we will collapse the first dimension applying the specified function

x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) # we will use columns, so 10 elements will be printed
apply(x, 1, mean) # we will use rows, so 20 elements will be printed

# we can get quantiles of the rows of a matrix

apply(x, 1, quantile, probs=c(0.25, 0.75)) # we will use rows so 20 elements 
#will be printed and it will get quantiles 0.25 and 0.75 (percentiles 25 and 75 or 1st and 3rd quartile) for each row

## mapply function
# rep repeats a function n times with rep(fun, n)

list(rep(1,4), rep(2,3), rep(3,2), rep(4,1)) # is tedious to write
# mapply is easier
mapply(rep, 1:4, 4:1)

# if we have a noise function that returns noise for a specified mean and std
noise <- function(n, mean, sd){
  rnorm(n, mean,sd)
  
}

# if we make 
noise(1:5, 1:5, 2) # waiting for it to return a list of noises 
# whose first element is a vector of length 1 with mean 1 
# second element is a vector of length 2 with mean 2
# third element is a vector of length 3 with mean 3...
# so, we want a list like ( N(1,2)[1], N(2,2)[2], N(3,2)[3], N(4,2)[4], N(5,2)[5])
# we are wrong
# the correct way to do this is by using mapply

mapply(noise, 1:5, 1:5, 2)

# tapply function

# if we have a vector of 30 elements and we know elements [1,10] are from group A or 1, [11,20] are from 
# group B or 2, and [21,30] are from group C or 3
# we can use tapply to get subsets of vectors passing a vector that identifies every element of the vector
# in this example we will use gl(3,10) that will generate a vector with 10 elements of value 1, 10 elements
# of value 2 and 10 elements of value 3 (this will identify our groups)

# and we have, for example, a sample of heights of 30 values, first 10 are from spaniards, 
# next 10 are from french people and next 10 are from german people

hspaniards <- rnorm(10, 1.75, 0.1)
hfrench <- rnorm(10, 1.78, 0.08)
hgerman <- rnorm(10, 1.83, 0.15)

# our set of heights is
x <- c(hspaniards, hfrench, hgerman)
setids <- gl(3,10) # [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2...]

tapply(x, setids, mean)

## SPLITTING A DATAFRAME

library(datasets)

s <- split(airquality, airquality$Month)
# and we can lapply to s 
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
