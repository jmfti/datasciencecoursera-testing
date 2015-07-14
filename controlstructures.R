
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
