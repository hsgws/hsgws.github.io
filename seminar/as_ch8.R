data_ice <- read.csv("data_assignment/data_ice.csv", header = TRUE)
out <- lm(utility ~ chocolate + vanilla + X.1.50 + X.2.00 + cone + yes, data = data_ice)
summary(out)

coef <- coef(out)
print(coef)

flavour <- c(coef[c("chocolate", "vanilla")], "strawberry" = 0)
flavour <- flavour - mean(flavour)
print(flavour)

library(conjoint)
data(ice)

con <- Conjoint(ipref,iprof,ilevn,y.type="rank")
summary(con)