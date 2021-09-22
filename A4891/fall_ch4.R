data <- read.csv("data2/学校データ.csv")

# 4.2 ANOVA
library(lmerTest)
anovamodel <- lmer(post1 ~ (1|schoolID), data = data, REML = FALSE)
summary(anovamodel)

# 4.3 RANCOVA
