library(flexmix)

# logit glm
result1 <- glm(visit ~ recency + log(history) + segment + newbie,
               family = "binomial", data = data_email)
summary(result1)

# finite mixture
result2 <- flexmix(cbind(visit, 1 - visit) ~ recency + log(history) + segment + newbie,
                   data = data_email,
                   k = 2,
                   model = FLXMRglm(family = "binomial"))
summary(result2)
parameters(result2, component = 1)
parameters(result2, component = 2)


result3 <- initFlexmix(cbind(visit, 1 - visit) ~ recency + log(history) + segment + newbie,
                       data = data_email,
                       k = 1:4,
                       model = FLXMRglm(family = "binomial"))
print(result3)

