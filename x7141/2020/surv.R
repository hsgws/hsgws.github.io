library(survival)
library(tidyverse)
# library(rms)

data_churn <- read.csv("data/data_churn.csv") 

# data_churn2 <- data_churn %>% 
#   mutate(Churn = 1*(Churn == "Yes")) %>% 
#   filter(tenure > 0)


result <- survreg(Surv(tenure, Churn) ~ gender + MonthlyCharges + Contract,
                  data = data_churn)
summary(result)
# fit <- survfit(result)



# pred <- predict(result, type = "quantile", p = seq(0.01, 0.99, by=.01))

# s <- with(data_churn, Surv(tenure, Churn))
# km.null <- survfit(data = data_churn, s ~ 1)
# survplot(km.null,conf ="none")
# 
# lines(x = predict(result, type = "quantile", p = seq(0.01, 0.99, by=.01))[1,],
#       y = rev(seq(0.01, 0.99, by = 0.01)),
#       col = "red",lty=2,lwd=2)

resultc <- coxph(Surv(tenure, Churn) ~ gender + MonthlyCharges + Contract,
                  data = data_churn)
summary(resultc)

fitc <- survfit(resultc)
summary(fitc)
