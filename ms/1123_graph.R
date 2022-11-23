pnorm(-0.36, mean = 0, sd = sqrt(0.10))*2

-0.36/sqrt(0.10)

-0.36-1.96*sqrt(0.10)
-0.36+1.96*sqrt(0.10)

-0.36/sqrt(0.10)


x <- seq(from=-1.2,to=1.2,length.out=1000)
f <- dnorm(x, mean = 0, sd = sqrt(0.10))
nframe <- data.frame(x=x,y=f)

# line <- qnorm(-0.36, mean = 0, sd = sqrt(0.10))

nframep <- filter(nframe, nframe$x < -0.36 | nframe$x > 0.36)

nframe1 <- subset(nframe, nframe$x < -0.36)


# ggplot(nframe, aes(x=x,y=y)) + 
#   geom_line() +
#   geom_area(data = subset(nframe, nframe$x < -0.36), aes(x = x, y = y), fill="gray") +
#   geom_area(data = subset(nframe, nframe$x > 0.36), aes(x = x, y = y), fill="gray")
#   


ggplot(nframe, aes(x=x,y=y)) + 
  geom_area(data = subset(nframe, nframe$x < -0.36), aes(x = x, y = y), fill="gray") +
  geom_area(data = subset(nframe, nframe$x > 0.36), aes(x = x, y = y), fill="gray") +
  geom_line() +
  theme_classic() +
  ylab("") + xlab("") + 
  guides(y = "none")


x <- seq(from=-3,to=3,length.out=1000)
f <- dnorm(x, mean = 0, sd = 1)
nframe <- data.frame(x=x,y=f)

ggplot(nframe, aes(x=x,y=y)) + 
  geom_area(data = subset(nframe, nframe$x < -1.96), aes(x = x, y = y), fill="gray") +
  geom_area(data = subset(nframe, nframe$x > 1.96), aes(x = x, y = y), fill="gray") +
  geom_line() +
  theme_classic() +
  ylab("") + xlab("") + 
  guides(y = "none")
