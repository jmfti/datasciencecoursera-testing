## ranking hospitals

## rankhospital takes 3 arguments, name of state, an outcome 
# and the ranking of am hospital in that state for that outcome
# it reads the outcome-of-care-measures.csv and returns a character vector
# with the name of the hospital that has the ranking specified by the num argument 

rankhospital <- function(state, outcome, num="best"){
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
	# order first by outcome and later by hospital name 
	ods <- NULL
	if (num == "best" || is.numeric(num)){
		ods <- ss[ order(ss[,idx], ss[,2]), ]
	}
	else{	# if worst make 
		ods <- ss[ order(-ss[,idx], ss[,2]), ]
	}
	result <- cbind(ods, seq_len(nrow(ods)))
	result <- result[seq_len(nrow(result)), c(2, idx, 47)]
	colnames(result)[3] <- "rank"
	colnames(result)[2] <- "rate"
	# now we check if num is numeric and if true then subtract only the specified
	# rows 
	if (is.character(num)){
		result[1,1]
	}
	else{
		result[num,1]
	}
}