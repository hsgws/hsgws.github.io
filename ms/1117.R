library(KFAS)


hokkaido <- read.csv("data/hokkaido.csv")

train_data <- hokkaido[1:84,]
test_data <- hokkaido[85:108,]

# モデル1 ----
# 推定
model <- SSModel(
  num ~ SSMtrend(1, Q = NA) + SSMseasonal(12, Q = NA) + leap,
  H = NA,
  data = train_data
)

fit <- fitSSM(model, inits = rep(0, 3))
result <- KFS(fit$model)

# 予測
newdata <- SSModel(
  rep(NA, 24) ~ SSMtrend(1, Q = NA) + SSMseasonal(12, sea.type = "dummy", Q = NA) + leap,
  H = NA, 
  data = test_data
)

newdata$H <- fit$model$H    # 観測モデルの分散
newdata$Q <- fit$model$Q    # システムモデルの分散

pred <- predict(fit$model, n.ahead = 24, newdata = newdata, interval = "prediction", level = 0.95)

# 予測力検証
library(Metrics)
mape(test_data$num, pred[, "fit"])
rmse(test_data$num, pred[, "fit"])

# モデル2
# 推定
model <- SSModel(
  num ~ SSMtrend(1, Q = NA) + SSMseasonal(12, Q = NA) + leap + holiday,
  H = NA,
  data = train_data
)

fit <- fitSSM(model, inits = rep(0, 3))
result <- KFS(fit$model)

# 予測
newdata <- SSModel(
  rep(NA, 24) ~ SSMtrend(1, Q = NA) + SSMseasonal(12, sea.type = "dummy", Q = NA) + leap + holiday,
  H = NA, 
  data = test_data
)

newdata$H <- fit$model$H    # 観測モデルの分散
newdata$Q <- fit$model$Q    # システムモデルの分散

pred <- predict(fit$model, n.ahead = 24, newdata = newdata, interval = "prediction", level = 0.95)

# 予測力検証
library(Metrics)
mape(test_data$num, pred[, "fit"])
rmse(test_data$num, pred[, "fit"])
