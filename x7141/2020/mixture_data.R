data <- sec4_choice2
n <- nrow(data)
m <- 3

alt <- c("A","B","C")

data_long <- data.frame()
for (i in 1:100) {
  datai <- data.frame(rep(i,m),
                      rep(data$id[i],m),
                      rep(data$Date[i],m),
                      alt,
                      (alt == data$Choice[i]),
                      matrix(data[i,4:12], m, 3)
                      )
  data_long <- rbind(data_long, datai)
}

colnames(data_long) <- c("experiment", "id", "Date", "Brand", "Choice", "Price", "Display", "Ad")
data_long$Brand <- relevel(factor(data_long$Brand), "C")

data_long <- data.frame(data_long)

# library(mlogit)
# d <- mlogit.data(data_long, choice = "Choice", shape = "long", varying = 5:7)

library(flexmix)
flx <- flexmix(Choice ~ Price + Display + Ad | id,
               model = FLXMRcondlogit(strata = ~ experiment),
               data = data_long,
               k=1)
