# データの読み込み
data <- read.csv("data/data.csv")

# データの図示と基礎集計
summary(data)
plot(x = data$price, y = data$sales)

# 回帰分析
reg <- lm(sales ~ price + promotion, data = data)
summary(reg)
