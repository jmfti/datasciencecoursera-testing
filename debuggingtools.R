## DEBUGGING TOOLS

# types of message : warning, error, message, condition

# condition is a concept for indicating that something could happen

# example of warning
log(-1) # will produce a NaN and it will warn us

# invisible(x) is used to return a variable that we don't want to print out

printmessage <- function(x){
  if (x > 0){
    print("asdansd")
  }
  else
    print("as9dhas98dh")
  invisible(x)
}

a <- printmessage(23)

a


# debugging tools 

# traceback prints the function call stack AFTER an error happened

lm(y ~ x)
traceback()

# debug flags a function for debug mode which allows to step through the execution of a function one line at a time

# an example
debug(lm) 
lm(y ~ x)

# browser suspends the execution of a function wherever it is called and it puts the function in debug mode


# trace allows to insert debugging code into a function in specific places


# recover allows to modify the error behavior so we can browse the function call stack


