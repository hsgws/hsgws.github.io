# パラメータの真値
gamma_00 <- 10
gamma_01 <- -10
gamma_10 <- 10
sigma2 <- sqrt(10)  # sqrt(10) = 3.162278
tau_00 <- sqrt(2)   # sqrt(2) = 1.414214
tau_11 <- sqrt(2)

tau_x00 <- sqrt(1.2)

N <- 50
n <- 100

# シミュレーションデータの作成
data <- data.frame()
data_mean <- data.frame()
for (j in 1:N) {
  xj <- rnorm(1, sd = sqrt(tau_x00)) + rnorm(n, sd = sqrt(sqrt(5)))
  xjbar <- mean(xj)
  xj_cwc <- xj - xjbar
  
  beta_0j <- gamma_00 + gamma_01 * xjbar + rnorm(1, sd = sqrt(tau_00))
  beta_1j <- gamma_10 + rnorm(1, sd = sqrt(tau_11))
  
  yj <- beta_0j + beta_1j * xj_cwc + rnorm(n, sd = sqrt(sigma2))
  
  dataj <- cbind(id = j, y = yj, x = xj, xbar = xjbar, x_cwc = xj_cwc)
  data <- rbind(data, dataj)
  
  dataj_mean <- cbind(id = j, ymean = mean(yj), xmean = xjbar)
  data_mean <- rbind(data_mean, dataj_mean)
}

# 推定
## 真のモデル
library(lmerTest)
true_model <- lmer(y ~ xbar + x_cwc + (1 + x_cwc|id), data = data, REML = FALSE)
summary(true_model)

## 単回帰 式(3.17)
linear_model1 <- lm(y ~ x, data = data)
summary(linear_model1)

## 単回帰 式(3.19)
linear_model2 <- lm(ymean ~ xmean, data = data_mean)
summary(linear_model2)


# シミュレーションの関数化
mlm_sim <- function(n, tau_x00) {
  
  # シミュレーションデータの作成
  data <- data.frame()
  data_mean <- data.frame()
  for (j in 1:N) {
    xj <- rnorm(1, sd = sqrt(tau_x00)) + rnorm(n, sd = sqrt(sqrt(5)))
    xjbar <- mean(xj)
    xj_cwc <- xj - xjbar
    
    beta_0j <- gamma_00 + gamma_01 * xjbar + rnorm(1, sd = sqrt(tau_00))
    beta_1j <- gamma_10 + rnorm(1, sd = sqrt(tau_11))
    
    yj <- beta_0j + beta_1j * xj_cwc + rnorm(n, sd = sqrt(sigma2))
    
    dataj <- cbind(id = j, y = yj, x = xj, xbar = xjbar, x_cwc = xj_cwc)
    data <- rbind(data, dataj)
    
    dataj_mean <- cbind(id = j, ymean = mean(yj), xmean = xjbar)
    data_mean <- rbind(data_mean, dataj_mean)
  }
  
  # 推定
  ## 真のモデル
  true_model <- lmer(y ~ xbar + x_cwc + (1 + x_cwc|id), data = data, REML = FALSE)

  ## 単回帰 式(3.17)
  linear_model1 <- lm(y ~ x, data = data)

  ## 単回帰 式(3.19)
  linear_model2 <- lm(ymean ~ xmean, data = data_mean)
  
  # 出力
  output <- cbind(true_model@beta[3], 
                  true_model@beta[2],
                  linear_model1$coefficients[2],
                  linear_model2$coefficients[2])
  return(output)
}


# シミュレーション（1000回）
R <- 100
sim_output <- matrix(0, nrow = R, ncol = 4)
for (i in 1:R) {
  sim_output[i,] <- mlm_sim(n = 100, tau_x00 = sqrt(1.2))
  if(i %% 10 == 0) {
    print(paste("finish", i))
  }
}


