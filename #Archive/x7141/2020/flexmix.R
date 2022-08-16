library(flexmix)

# logit glm
result1 <- glm(visit ~ recency + log(history) + segment + newbie,
               family = "binomial", data = data_email)
summary(result1)

# finite mixture
result2 <- flexmix(cbind(visit, 1 - visit) ~ recency + log(history) + segment + newbie,
                   data = data_email,
                   k = 3,
                   model = FLXMRglm(family = "binomial"))

# rm <- refit(result2)
# summary(rm)
result2
summary(result2)
parameters(result2, component = 1)
parameters(result2, component = 2)
parameters(result2, component = 3)

# result3 <- initFlexmix(cbind(visit, 1 - visit) ~ recency + log(history) + segment + newbie,
#                        data = data_email,
#                        k = 1:4,
#                        model = FLXMRglm(family = "binomial"))
# print(result3)

result2 <- flexmix(cbind(visit, 1 - visit) ~ recency + log(history) + segment + newbie,
                   data = data_email,
                   k = 2,
                   model = FLXMRglm(family = "binomial"))

data <- data.frame(data_email, cluster = result2@cluster)

# xtabs(zip_code~as.factor(cluster), data = data)
# xtabs(cluster~zip_code+channel, data = data)

prop.table(xtabs(~zip_code+cluster, data = data), 2)

prop.table(data$zip_code, data$cluster)




