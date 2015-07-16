
## CONTROL STRUCTURES

x <- 5
if (x > 3){
  y <- 10
}else if (x < 3){
  y <- 20
}else{
  y <- 0.5
  
}

y



# this one is correct too

y <- if (x > 3){
  2
}else{
  10
}

y


## LOOPS

for (i in 1:10){
  print(i)
}


# many things can be indexed
# we can map a number to an array element with seq_along

for (i in 1:4){
  print(x[i])
}


x <- c("a","b","c","d")

for (i in seq_along(x)){
  print(x[i])
}

for (letter in x){
  print(letter)
}

## iterating over a matrix
# seq_len generates a sequence : seq(from=1, to=1, by, length.out, along.with,...)
# seq(from=1, to=10, length.out=80) will return 80 equidistant points from 1 to 10
# nrow returns number of rows for a matrix
# first by rows

x <- matrix(1:6, 2, 3)

for (i in seq_len(nrow(x)))
  for (j in seq_len(ncol(x))){
    print(x[i,j])
  }


# while loop

x <- 10

while (x > 0 ) {
  print(x)
  x <- x - 1
}

# repeat loop
# repeat keeps doing the same until a break sentence is found

x0 <- 1
to <- 1e-2

require(stats)

repeat{
  x1 <- rnorm(n=1)
  
  if (abs(x1-x0) < to){
    break
  } else{
    print(x0)
    x0 <- x1
  }
  
}

# skipping iterations
# in C or Java we have continue statement to get to the next iteration, here we use next

for (i in 1:1000){
  if (i <= 20){
    next
  }
  ## do stuff here
}


## FUNCTIONS IN R

# like any other languages out there functions can be implemented 
# the difference is that R will return the last expression

#example
add <- function(x, y){
  x+y
}


add(c(1,2,3), c(4,5,6))


# getting the numbers of a vector above 10

above10 <- function(x){
  e <- x > 10
  # e has a logical vector that tells if the expression is true for that element
  x[e] # will return elements of x greater than 10
}

above10(c(8,9,10,11,12,13,14))

# elements can be pushed into a vector with c function like c( c(1,2), 3) or append(c(1,2), 1)

columnmean <- function(mat){
  result <- numeric()
  for(i in seq_len(ncol(mat))){
    result <- c(result, mean(mat[,i]))
  }
  result
}

columnmean(matrix(1:6, 2,3))


# its better to initialize the vector if we know how many elements will be stored

columnmean2 <- function(mat){
  nc <- ncol(mat)
  result <- numeric(nc)
  for(i in 1:nc){
    result[i] <- mean(mat[,i])
  }
  result
}

columnmean(matrix(1:6, 2,3))

## sometimes data has NA elements. to remove it automatically we can pass na.rm=[TRUE|FALSE] to mean() function

columnmean3 <- function(mat, removeNA = TRUE){
  nc <- ncol(mat)
  result <- numeric(nc)
  for(i in 1:nc){
    result[i] <- mean(mat[,i], na.rm = TRUE)
  }
  result
  
}

# arguments for functions
# functions can be passed as arguments to another functions, just like Python or some other 
# scripting languages

# functions can also be nested, so a function can be defined inside another function
# arguments can be matched positionally or by name

data <- rnorm(100) # 100 elements with normal distribution N(0,1)
sd(data) # standar deviation
sd(x=data) # equivalent
sd(x=data, na.rm=FALSE)
sd(na.rm=FALSE, x=data)
sd(na.rm=FALSE, data)

# all those function calls are equivalent


## more aboute functions

# free variables will be searched in the parent's environment 
# so it will be like an inverse in-depth search in the environment tree

make.power <- function(n){
  pow <- function(x){
    x^n
    # n will be searched in the parent's environment
  }
  pow
  
}

square <- make.power(2)
cube <- make.power(3)

square(5) # 5^2
cube(3)   # 3^3



## OPTIMIZATION IN R

# optim and nlm are the functions used to optimize functions
# if you want to maximize or minimize with some restrictions on variables it is
# what has to be used

# the idea in R is to make something like in javascript
# we can set environment variables to keep data that we need

# using ls(environment(function)) we can get the environment variables for the specified function

ls(environment(square))


## dates and times in R

# Dates are represented by the Date class
# Times are represented by POSIXct or the POSIXlt class
# Dates are stored internally as the number of days since 1970-1-1
# times are stored internally as the number of seconds 1970-1-1 (unix timestamp)

x <- as.Date("1970-01-01")
x

unclass(x) # it will print the internal representation of the date

unclass(as.Date("1970-01-05"))

weekdays(x)
months(x)
quarters(x)

x <- Sys.time()
x
unclass(x)

p <- as.POSIXlt(x)
p
unclass(p)

names(unclass(p))
names(unclass(x))

# strptime is to get a date formatted 

?strptime # for help

y <- strptime("2001-01-05 14:24:31","%Y-%m-%d %H:%M:%S")

x-y
