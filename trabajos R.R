# POLLUT AND MEAN

library(stringr)

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ids <- str_pad(id, 3, pad="0") # this will produce a vector of strings ['001','002',...]
  
  ids <- paste(ids, ".csv", sep="")
  #print(ids)
  data <- numeric()
  for(i in ids){
    f <- paste(directory, i, sep="/")
    df <- read.csv(f)
    ldata <- df[[pollutant]]
    data <- c(data, ldata)
    
  }
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  mean(data, na.rm=TRUE)
}

pollutantmean("specdata", "sulfate", 1:10)

pollutantmean("specdata", "nitrate", 70:72)


## part 2

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ids <- str_pad(id, 3, pad="0") # this will produce a vector of strings ['001','002',...]
  
  ids <- paste(ids, ".csv", sep="")
  nobs <- numeric()
  
  for (i in ids){
    f <- paste(directory, i, sep="/")
    df <- read.csv(f)
    length <- nrow(df[!is.na(df$sulfate) & !is.na(df$nitrate), ])
    nobs <- c(nobs, length)
  }
  
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  cbind(id, nobs)
}

complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  #ids <- str_pad(id, 3, pad="0") # this will produce a vector of strings ['001','002',...]
  
  #ids <- paste(ids, ".csv", sep="")
  completed <- as.data.frame(complete(directory, id=1:332))
  selected <- completed[completed$nobs > threshold,]
  
  correlations <- numeric(nrow(selected))
  cont <- 1 
  for (i in selected$id){
	idstr <- paste(str_pad(i, 3, pad="0"), ".csv", sep="")
	f <- paste(directory, idstr, sep="/")
	df <- read.csv(f)
	# now we have our data frame 
	data <- df[!is.na(df$nitrate) & !is.na(df$sulfate),]	# complete cases 
	
	correlations[cont] <- cor(data$sulfate, data$nitrate)
	cont <- cont + 1 
  }
  correlations
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
}