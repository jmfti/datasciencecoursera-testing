### using RMySQL
# install.packages("RMySQL") RTools is needed

library(RMySQL)

# connecting to the database

#db <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu")
db <- dbConnect(MySQL(), user="genome", host="genome-mysql.cse.ucsc.edu", db="hg19")

#result <- dbGetQuery(db, "show databases")

# this will list all tables in the database we are connected
#tables <- dbListTables(db)

# now to get the fields of the table we want to query
#fields <- dbListFields(db, "affyU133Plus2")

# and if we want to make queries to our database
dbGetQuery(db, "select count(*) from affyU133Plus2")

#reading the tables
#data <- dbReadTable(db, "affyU133Plus2")
#head(data)
# this gives us actually a data frame so we dont have to process data when reading from database

# if the data set is really big we may subset results and fetch data so we won't have 
# too much rows on memory
query <- dbSendQuery(db, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
#affyMis
quantile(affyMis$misMatches)

# fetch will fetch all rows from our query
# if the data set is really big we could just fetch a number of rows 
# using fetch(query, n=10)
# once we are clear we must clean our query, to tell the server we are done 
dbClearResult(query)


dbDisconnect(db)


### HDF5 data format (Hierarchical Data Format)
# used for storing large data sets
# heirarchical data format
# groups containing [0,n] data sets and metadata : 
# * have a group header with group name and list of attributes
# * have a group symbol table with a list of objects 
# datasets multidimensional array of data elements with metadata : 
# * have a header with name, datatype, dataspace and storage layout
# * have a data array with the data

#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")

library(rhdf5)
created <- h5createFile("example.h5")
created

created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "baa")
created <- h5createGroup("example.h5", "foo/baa")
h5ls("example.h5")

# we can create a matrix and store it in a group on our hdf file
A <- matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/A") # store it in group foo/A
B <- array(seq(0.1, 2.0, by=0.1, dim=c("5","2","2")))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/baa/B")

h5ls("example.h5")


# data frames can be also stored in hdf 
df <- data.frame(1:5, seq(0,1, length.out=5), c("ab", "cde", "fghi", "a", "s"),
                 stringAsFactors=FALSE)
#h5write(df, "example.h5", "df")
h5ls("example.h5")


## reading data in hdf
readA <- h5read("example.h5", "foo/A")
readB <- h5read("example.h5", "foo/baa/B")
readdf <- h5read("example.h5", "df")
readA

# hdf5 can be used to optimize reading/writing from disc in R

