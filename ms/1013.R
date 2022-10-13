library(mlogit)

sec4_choice2 <- read.csv("data/sec4_choice2.csv")

soydata <- mlogit.data(
  sec4_choice2,
  choice = "Choice",
  shape = "wide",
  varying = 4:12,
  sep = "."
)

result <- mlogit(
  Choice ~ log(Price) + Display + Ad,
  data = soydata,
  reflevel = "C"
)

summary(result)
