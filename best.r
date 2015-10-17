

## best function has 2 arguments : state and outcome name.
# this function reads outcome-of-care-measures.csv file and returns
# a character vector with the name of the hospital that has the best 30-day mortality
# for the specified outcome and the specified state 

best <- function(state, outcome) {
	## Read outcome data 
	oc <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	#check that state and outcome are valid 
	states <- unique(oc[,7])
	if (!state %in% states)
		stop("invalid state")
		
	# outcomes and column indexes 
	outcomes <- c("heart attack", "heart failure","pneumonia")
	idxoutcomes <- c(11, 17, 23)
	if (!outcome %in% outcomes)
		stop("invalid outcome")
	
	# get the column index for the specified outcome 
	idx <- idxoutcomes[match(outcome, outcomes)]
	
	# get subset of data for specified state 
	ss <- oc[ oc[,7] == state, ]
	ss[,idx] <- as.numeric(ss[,idx])
	ss[ which(ss[,idx] == min(ss[,idx], na.rm=T)) ,2]
	
}