
## rankall takes 2 arguments, an outcome and a hospital ranking (num) 
# it reads outcome-of-care-measures.csv file and returns a 2 column data frame
# containing the hospital in each state that has the ranking specified in num 

rankall <- function(outcome, num="best"){
	## Read outcome data 
	oc <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	
	# outcomes and column indexes 
	outcomes <- c("heart attack", "heart failure","pneumonia")
	idxoutcomes <- c(11, 17, 23)
	if (!outcome %in% outcomes)
		stop("invalid outcome")
	
	# get the column index for the specified outcome 
	idx <- idxoutcomes[match(outcome, outcomes)]
	
	# get subset of data for specified state 
	ss <- oc
	ss[,idx] <- as.numeric(ss[,idx])
	# order first by outcome and later by hospital name 
	ods <- NULL
	
	if (num == "best" || is.numeric(num)){	# ascending order 
		ods <- ss[ order(ss[,idx], ss[,2]), ]
	}
	else{	# if not make descending order 
		ods <- ss[ order(-ss[,idx], ss[,2]), ]
	}
	# keep safe groups to join data 
	groups <- ods[,7]
	sd <- split(ods, groups)
	# lets add a column for each subset which will be the rank 
	for(i in names(sd)){
		#print(head(sd[i]))
		sd[[i]] <- cbind(sd[[i]], seq_len(nrow(sd[[i]])))
		colnames(sd[[i]])[47] <- "rank"
	}
	# turn back to normal joining data 
	sd <- unsplit(sd, groups)
	i <- 1 
	if (is.numeric(num)) i <- num 
	r <- sd[ sd[,47] == i, c(2, 7)]
	r[order(r$State),]
	
}