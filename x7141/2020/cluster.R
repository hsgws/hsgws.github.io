library(tidyverse)

# make data 
data <- data_bigfive %>% 
  mutate(a = rowSums(data_bigfive==0)) %>% 
  filter(a == 0) %>% 
  select(-a) %>% 
  filter(age < 101, gender < 3)
data$gender <- data$gender - 1

write.csv(data, "d:/data_bf.csv", row.names = F)

# data_bf
fa <- factanal(data_bf[,8:57], factors = 5, scores = "regression")

# cluster
cluster <- kmeans(fa$scores, centers = 4)

## center
cluster$centers
cluster$size

data_bf <- data.frame(data_bf, k = cluster$cluster)
# xtabs(~gender+k, data = data_bf)

tapply(data_bf$age, data_bf$k, mean)
tapply(data_bf$gender, data_bf$k, mean)


proportions(xtabs(~race+k, data = data_bf),2)

