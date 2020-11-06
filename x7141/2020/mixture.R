# library(tidyverse)
# 
# n <- 3000
# xdata <- as.matrix(cbind(rep(1,n), runif(n,0.5,1), round(runif(n))))
# 
# theta <- c(0.4, 0.3, 0.3) %>% 
#   as.matrix()
# 
# beta <- cbind(c(2, 1.5, 3), c(-5, -3, -2), c(0.5, 0.9, 0.2)) %>% 
#   as.matrix() %>% 
#   t()
# 
# 
# ydata <- rep(0,n)
# xb <- rep(0,n)
# prob <- rep(0,n)
# k <- rep(0,n)
# 
# for (i in 1:n) {
#   k[i] <- t(rmultinom(1, 1, theta)) %*% c(1, 2, 3)
#   xb[i] <- xdata[i,] %*% beta[,k[i]]
#   prob[i] <- exp(xb[i])/(1+exp(xb[i]))
#   ydata[i] <- rbinom(1, 1, prob[i])
# }
# 
# data <- data.frame(y = ydata, price = xdata[,2], disp = xdata[,3], k)
# 
# coef <- matrix(0, 3, 3)
# for (j in 1:3) {
#   dataj <- data %>% 
#     filter(k == j)
#   out <- glm(y ~ price + disp, family = "binomial", data = dataj)
#   coef[j,] <- coefficients(out)
# } 
# 
# beta
# t(coef)
# 
# # write.csv(data, "mixdata.csv", row.names = F)
# 
# 
# library(flexmix)
# result0 <- glm(y ~ price + disp, family = "binomial", data = data)
# summary(result0)
# 
# 
# result1 <- flexmix(cbind(y, 1 - y) ~ price + disp,
#                    data = data,
#                    k = 3,
#                    model = FLXMRglm(family = "binomial"))
# summary(result1)
# parameters(result1, component = 1)
# parameters(result1, component = 2)
# parameters(result1, component = 3)
# 
# 
# result3 <- initFlexmix(cbind(y, 1 - y) ~ price + disp,
#                        data = data,
#                        k = 1:4,
#                        model = FLXMRglm(family = "binomial"))
# print(result3)
# 

library(flexmix)
