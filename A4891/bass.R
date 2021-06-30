data <- tokyo_covid19[1:412,]
nrow <- nrow(data)

n <- data$positive_cases
Nt <- c(0, cumsum(data$positive_cases[1:(nrow-1)]))
bass_data <- data.frame(n = data$positive_cases, Nt = Nt[1:nrow], Nt2 = Nt[1:nrow]^2)


# 1
## nls
result1_nls <- nls(n ~ p*(m - Nt) + q*Nt/m*(m - Nt),
                   start = list(p = 0.1, q = 0.1, m = 5000),
                   data = bass_data[1:119,]) 
summary(result1_nls)

ltys <- c("solid", "dashed")
cols <- c("black", "red")
plot.ts(cbind(bass_data$n[1:119], fitted(result1_nls)), plot.type = "single", 
        lty = ltys, col = cols, main = "1")

## lm
result1_lm <- lm(n ~ Nt + Nt2, data = bass_data[1:119,])
summary(result1_lm)
a <- result1_lm$coefficients[1]
b <- result1_lm$coefficients[2]
c <- result1_lm$coefficients[3]
m <- (-b-sqrt(b^2-4*a*c))/(2*c)
p <- a/m
q <- p+b

print(c(m, p, q))


# 2
result2 <- nls(n ~ p*(m - Nt) + q*Nt/m*(m - Nt),
               start = list(p = 0.1, q = 0.1, m = 5000),
               data =  bass_data[120:250,]) 
summary(result2)

plot.ts(cbind(bass_data$n[120:250], fitted(result2)), plot.type = "single", 
        lty = ltys, col = cols, main = 2)


# 3
result3 <- nls(n ~ p*(m - Nt) + q*Nt/m*(m - Nt),
               start = list(p = 0.1, q = 0.1, m = 5000),
               data =  bass_data[251:412,]) 
summary(result3)

plot.ts(cbind(bass_data$n[251:412], fitted(result3)), plot.type = "single", 
        lty = ltys, col = cols, main = 3)