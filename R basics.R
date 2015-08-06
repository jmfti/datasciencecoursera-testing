# ranges

9:29 # range from 9 to 29

# casting data to another type

x <- 0:6
as.numeric(x) # it will print x as a vector of integers
as.character(x) # it will print x as a vector of characters

# lists

x <- list(1, "a", TRUE, 1+4i)
# accessing elements of list x is made by double [], just like [[]]

x[[2]]
x[[3]]

# in R, elements indexes starts in 1 as opposed to C, for example

x[-1] # this will print x minus the first element of x | x - {1}
x[-2] # this will print x minus the second element of x | x - {a}

# matrix in R

m <- matrix(nrow=2, ncol=3) # this will generate a 2x3 matrix of NAs
attributes(m) # will print dim property, the dimension of our matrix
m <- matrix(1:6, nrow=2, ncol=3) # R will populate the matrix top to bottom one column each

# vectors can be transformed into matrix by specifying their dimension

m <- 1:10 # this will be a vector
dim(m) <- c(2,5) # it will turn m into a matrix

m

# cbinding and rbinding (stands for column binding and row binding)
# this is just another way of creating matrix 
x <- 1:3
y <- 10:12

# using cbinding will create a matrix that will store every set into columns
cbind(x, y) # first column of matrix will be x vector
rbind(x, y) # first row of matrix will be x vector

# factors
x <- factor(c("yes", "no", "no", "yes", "yes"))
table(x) # will convert x into something like { yes : 3, no : 2 }
# so it will count how many times appear each distinct element

# we can specify factors order by telling it to the function factor

x <- factor(c("yes", "yes", "no"), levels=c("yes", "no"))

# missing values
NA
NaN

# data frames
# it stores tabular data

# row.names can be used to retrieve header names of a row

# read.table() and read.csv() are typical functions that will produce data frames

x <- data.frame(foo=1:4, bar=c(T,T,F,F))

# foo will be a column and bar another one
# more important is that we can access foo by using x$foo

x
x$foo

# object names can be given by using names(x) function

x <- 1:3
names(x) <- c("foo", "bar", "norf")

# lists can be created with names
x <- list(a=1, b=2, c=3)

# reading data
# read.csv is equal to read.table except for the fact that read.csv default separator is comma


############ using help

# help can be used to see online documentation for some functions

# help(read.table) # this will open an url with reference of read.table

# reading large datasets 

# colClasses must be used to accelerate reading of a file
# if we know that our file will have just 1 column of type numeric we can set colClasses = "numeric"

# dirty way to figure classes of each one

# initial <- read.table("datatable.txt", nrows=100)
# classes <- sapply(initial, class)
# taball <- read.table("datatable.txt", colClasses=classes)

# if we know how many rows will be on our dataset we can specify to R 
# so it won't have to alloc and realloc memory heaps over and over again, so it will 
# improve overall performance

x <- data.frame(foo=1:3, bar=10:12)

dput(x)

# dump y dput are functions that output data.frames with metadata
# we can read from input with metadata with equivalent functions like source and dget

dget(dput(x))

# dput can be used to store that text based data in files

dput(x, file="e.r")

# and we can restore that data using dget

m <- dget("e.r")

m

# files, streams...

# file opens a 'connection' to a file
# gzfile opens a connection to a gzip file
# bzfile opens a connection to a bzip2 file
# url opens a connection to a web page

## file connections
# str(file) shows the parameters of the function file
# description is the name of the file
# open is the mode = {r, w, a, rb, wb, ab}
# blocking if we want to block the file
# encoding (use utf-8 or whatever u like)

con <- file("e.r", "r")
readLines(con)
close(con)

# example of reading a compressed file
# con <- gzfile("words.gz")
# x <- readLines(con, 10)
# x # will print data

