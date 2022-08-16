library(mlogit)

data <- mlogit.data(data_Fishing, choice = "mode", shape = "wide",
                    varying = c(2:9), sep = ".")
result <- mlogit(mode ~ price + catch, data = data)
summary(result)

data(Fishing)
data2 <- mlogit.data(Fishing, choice = "mode", shape = "wide",
                     varying = c(2:9), sep = ".")
result2 <- mlogit(mode ~ price + catch, data = data2)
summary(result2)