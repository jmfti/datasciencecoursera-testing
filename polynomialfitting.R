## polynomial model fitting

x <- seq(from=-10,to=10, length.out=200)
y <- dnorm(x) + dnorm(x, mean=6, sd=2)

plot(x,y)

# now we must fit with a non linear model
fit1 <- lm(y ~ poly(x, 7, raw=T)) # raw=T is important
fit2 <- lm(y ~ poly(x, 8, raw=T))

xx <- x

lines(xx, predict(fit1, data.frame(x=xx))) # x must be passed in the data frame as the new x values
lines(xx, predict(fit2, data.frame(x=xx)))



x <- c(8,9,10,11,12,13,14,15,16,17,18,19,20,21)
y <- c(9, 5, 10, 23, 35, 60, 80, 60, 70, 66, 100, 120, 70, 44)
xx <- x
plot(x,y)
lines(xx, predict(lm(y ~ poly(x, 8, raw=T)), data.frame(x=xx)))
lines(xx, predict(lm(y ~ poly(x, 9, raw=T)), data.frame(x=xx)))

# if we want to predict y values for many more x points
xx <- seq(from=8, to=21, length.out=100)
lines(xx, predict(lm(y ~ poly(x, 9, raw=T)), data.frame(x=xx)))