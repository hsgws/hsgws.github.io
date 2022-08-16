library(KFAS)

# tea data
data_tea1 <- read.csv("data/data_tea1.csv")
data_tea2 <- read.csv("data/data_tea2.csv")


# df <- ts(data_tea1$num, start = c(2015,4,1), frequency = 365)

# estimation
model <- SSModel(num ~ SSMtrend(1, Q = NA) + 
                   SSMseasonal(7, sea.type = "dummy", Q = NA) +
                   SSMregression(~ holiday, Q = 0),
                 H = NA, data = data_tea1)
fit <- fitSSM(model, inits = rep(0,3))
out <- KFS(fit$model)

plotdf <- cbind(data_tea1$num, out$alphahat[,1:3])
colnames(plotdf) <- c("sales", "holiday", "trend", "day effect")
plot(plotdf, main = "Estimaion")

# prediction
newdata <- SSModel(rep(NA, 7) ~ SSMtrend(1, Q = NA) +
                     SSMseasonal(7, sea.type = "dummy", Q = NA) +
                     SSMregression(~ holiday, Q = 0),
                   H = NA, data = data_tea2)
newdata$Q <- fit$model$Q
newdata$H <- fit$model$H

pred <- predict(fit$model, newdata = newdata, interval = "prediction", level = 0.95)

plotdf <- cbind(data_tea2$num, pred)
plot(plotdf, plot.type = "single",
     col = c("black","red","red","red"),
     lty = c("solid","solid","dashed","dashed"),
     main = "1 week prediction")

library(Metrics)
mape <- mape(data_tea2$num, pred[, "fit"])
mae <- mae(data_tea2$num, pred[, "fit"])


# PI data
sec8_DLM <- read.csv("data/sec8_DLM.csv")
model <- SSModel(LogPI_A ~ SSMtrend(1, Q = NA) +
                   SSMregression(~ LogPriceIndex_A + LogPriceIndex_B + Display_A + Display_B,
                                 Q = diag(NA, 4)),
                 H = NA, data = sec8_DLM)
fit <- fitSSM(model, inits = rep(0,6))
out <- KFS(fit$model)

## 推定結果の図示
plot.df <- cbind(sec8_DLM$LogPI_A, out$alphahat)
colnames(plot.df) <- c("LogPI_A", "Price_A", "Price_B", "Display_A", "Display_B", "trend")
plot(plot.df, nc = 1, main = "Estimaion")


summary(lm(LogPI_A ~ LogPriceIndex_A + LogPriceIndex_B + Display_A + Display_B, data = sec8_DLM))
