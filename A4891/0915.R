data <- read.csv("data2/学校データ.csv")

school1 <- subset(data, data$schoolID == 1)
school2 <- subset(data, data$schoolID == 2)
school3 <- subset(data, data$schoolID == 3)

data2 <- subset(data, schoolID <= 3)

lm(post1 ~ pre1, data = school1)$coef
lm(post1 ~ pre1, data = school2)$coef
lm(post1 ~ pre1, data = school3)$coef
lm(post1 ~ pre1, data = data2)$coef

plot(data2$pre1, data2$post2)
abline(lm(post1 ~ pre1, data = school1))
abline(lm(post1 ~ pre1, data = school2))
abline(lm(post1 ~ pre1, data = school3))


library(RColorBrewer)
cols <- brewer.pal(3, "Set1")
hist(school1$pre1, 15, col = adjustcolor(cols[1], alpha.f = 0.2), xlim = range(data$pre1))
hist(school2$pre1, 15, col = adjustcolor(cols[2], alpha.f = 0.2), add = T)
hist(school3$pre1, 15, col = adjustcolor(cols[3], alpha.f = 0.2), add = T)

plot(density(school1$pre1), xlim = range(data$pre1), ylim = c(0, 0.08))
par(new = T)
plot(density(school2$pre1), xlim = range(data$pre1), ylim = c(0, 0.08))
par(new = T)
plot(density(school3$pre1), xlim = range(data$pre1), ylim = c(0, 0.08))

plot(school1$pre1, school1$post1, col = adjustcolor(cols[1], alpha.f = 0.7), 
     pch = 15, cex = 1.5, ylim = range(data$post1), xlim = range(data$pre1))
abline(lm(post1 ~ pre1, data = school1), col = cols[1], lwd = 2)
par(new = T)
plot(school2$pre1, school2$post1, col = adjustcolor(cols[2], alpha.f = 0.7),
     pch = 16, cex = 1.5, ylim = range(data$post1), xlim = range(data$pre1))
abline(lm(post1 ~ pre1, data = school2), col = cols[2], lwd = 2)
par(new = T)
plot(school3$pre1, school3$post1, col = adjustcolor(cols[3], alpha.f = 0.7),
     pch = 17, cex = 1.5, ylim = range(data$post1), xlim = range(data$pre1))
abline(lm(post1 ~ pre1, data = school3), col = cols[3], lwd = 2)
abline(lm(post1 ~ pre1, data = data2), lwd = 2)

oneway.test(post1 ~ schoolID, data = data)
