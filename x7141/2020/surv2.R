library(survival)


resultc <- coxph(Surv(time, status) ~ line_ex + multi_br + br_ex + 
                  ave_disc + sum_disp + sum_flier	+ ave_PI + max_price,
                data = sec5_survival)

predc <- predict(resultc, newdata = sec5_survival[1,], type = "expected")


# ワイブル分布モデルの推定
result <- survreg(Surv(time, status) ~ line_ex + multi_br + br_ex + 
                    ave_disc + sum_disp + sum_flier	+ ave_PI + max_price,
                  data = sec5_survival, dist = "weibull")

# 推定結果の表示
summary(result)

# pred <- predict(result, newdata = sec5_survival[1,], type='quantile',
#                 p=pct, se=TRUE)
# 
# matplot(x = cbind(pred$fit, pred$fit + 2*pred$se.fit,
#               pred$fit - 2*pred$se.fit), 
#         y = 1-pct,
#         xlab="week", ylab="Survival", type='l', lty=c(1,2,2), col=1)

library(tidyverse)
data <- sec5_survival %>% 
  filter(max_price == 288)

preda <- predict(result, newdata = data, type='quantile', p=pct, se=TRUE)
matplot(x = t(preda$fit), 
        y = 1-pct,
        xlab="week", ylab="Survival", type='l')


# matplot(x = 1:100, y = runif(100),
#         xlab="week", ylab="Survival", type='l', lty=1, col=1)
# 
# 
# coefficients(result)
# a <- predict(result, newdata = sec5_survival[1,], type = "linear")
# 
# 
# fit <- survreg(Surv(time,status) ~ age + I(age^2), data=stanford2,
#                dist='lognormal')
# summary(fit)
# 
# head(stanford2)
# 
# with(stanford2, plot(age, time, xlab='Age', ylab='Days',
#                      xlim=c(0,65), ylim=c(.1, 10^5), log='y', type='n'))
# with(stanford2, points(age, time, pch=c(2,4)[status+1], cex=.7))
# pred <- predict(fit, newdata=list(age=1:65), type='quantile',
#                 p=c(.1, .5, .9))
# matlines(1:65, pred, lty=c(2,1,2), col=1)
# 
# lfit <- survreg(Surv(time, status) ~ ph.ecog, data=lung)
# pct <- 1:98/100 # The 100th percentile of predicted survival is at +infinity
# ptime <- predict(lfit, newdata=data.frame(ph.ecog=2), type='quantile',
#                  p=pct, se=TRUE)
# matplot(cbind(ptime$fit, ptime$fit + 2*ptime$se.fit,
#               ptime$fit - 2*ptime$se.fit)/30.5, 1-pct,
#         xlab="Months", ylab="Survival", type='l', lty=c(1,2,2), col=1)
