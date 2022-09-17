library(mlogit)

data <- read.csv("data/conjoint.csv")

d <- mlogit.data(
  data = data,
  choice = "choice",
  shape = "wide",
  varying = 3:14,
  sep = "."
)

result <- mlogit(
  choice ~ int + haccp + eco + price - 1,
  data = d
)

summary(result)
