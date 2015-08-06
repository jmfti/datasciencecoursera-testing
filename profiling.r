
## STR function

# compactly displays internal structur of an object
# we can use

library(datasets)
head(airquality)

# we can see internal structure of airquality if we do
str(airquality)

## generating random numbers

#rnorm generates random Normal variates for given mean and std
# dnorm evaluates normal probability DENSITY for a given mean and std at some point
# p norm evaluates the cumulative distribution function for normal distribution 
# rpois generate random Poisson distributed variates with a given rate 

# d density
# r random number generation
# p cumulative distribution
# q for quantile function 

# so there should be rpois, ppois, qpois....

# in d, p, q we have an argument lower.tail = TRUE|FALSE 
# it's used to specify which tail we want to compute, lower tail or higher tail

# example : q percentile 25 lower.tail = FALSE would give us the value 
# above 25% of observations fall

# this will return the value above 75% of observations will fall (starting from the
# right tail) 
qnorm(0.75, 1000, 15, lower.tail=FALSE)

qnorm(0.25, 1000, 15) # should to the same thing 


# we have pois and binom
rpois(10, 1) # 10 observations, frequency = 1 
ppois(4,2) # P( x <= 4 ) for x ~ Poisson with frequency = 4

## Simulating linear models

# if we want to simulate y = B_0 + B_1x + e 
# where e ~ N(0,2), B_0 = 0.5 and B_1 = 2 and x ~ N(0,1)
# so it should be something like y = 0.5 + 2*x + e 

set.seed(2)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 + 2*x + e 
summary(y)

plot(x,y)


# if x was binary we could use rbinom(n, 1, p) n for length or observations and
# p for probability. 

set.seed(10)
x <- rbinom(100,1,0.5) # should make a vector of equal distributed 0 and 1 values 
y <- 0.5 + 2*x + e 
summary(y)

plot(x,y)


# if we want to simulate a poisson model y ~ Poisson(mu)
# where log(mu) = B_0 + B_1x and B_0 = 0.5 and B_1 = 0.3 
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3*x
y <- rpois(100, exp(log.mu) ) # exp is because e^log(mu) = mu
summary(y)

plot(x,y)


## RANDOM SAMPLING

# sample function allows us to sample from arbitrary distributions 

set.seed(1) 
sample(1:10, 4) # (it will get 4 samples from a vector [1,2,3,...,10]
sample(1:10) # it will do a permutation

sample(1:10, replace = TRUE) # sample with replacement so it takes observations
# without removing them

## R profiler 

# optimizing the code depends knowing where the code spends most of its time
## general principles of optimization 
# * design first, then optimize (if needed)
# * don't do premature optimization 
# * measure (or estimate) collected data, don't guess 

# using system.time()
# system.time accepts an expression as input and returns a proc_time object 
# specifying user time and elapsed time 
# usually user time and elapsed time are relatively close
# elapsed time may be greater than user time if the cpu spends a lot of time waiting
# elapsed time may be smaller than the user time if our machine has 
# multiple cores/processors 

# setInternet2() # if we have a proxy configured on IE

system.time(readLines("https://www.google.es"))

hilbert <- function(n) {
	i <- 1:n
	1 / outer(i - 1, i, "+")
}

x <- hilbert(1000)
system.time(svd(x))

# outer would be like cartesian product specifying a function 
# to be executed between pairs of elements, so 
# outer(letters[1:4], letters[1:4], paste, sep="") will produce { {aa}, {ab}, ..., {dd}}
# outer(1:4,1:4, "^") will produce { {1,1,1,1},{2,4,8,16}, {3,9,27,81}...}



## The R Profiler

#Rprof function starts the profiler
# the summaryRprof() function summarizes the output from Rprof() 
# Rprof keeps track of the functino call stack at regularly sampled intervals and 
# tabulates how much time is spend in each function
# default sampling is 0.02 seconds

## Using summaryRprof()
# 2 methos for normalizing data produced by Rpof
# by.total divides the time spent in each function by the total run time
# by.self does the same but first subtracts out time spent in functions ABOVE in
# the call stack 

# by.self is usually the most interesting method of normalizing data 
# if we call lm using by.total we will se that spent time in lm was 100%
# a disadvantage of Rprof is that C and fortran code is not profiled

