# データの読み込み
mydata <- read.csv("data/data.csv")

# データの基礎集計と散布図
summary(mydata)
plot(x = mydata$price, y = mydata$sales)

# 回帰分析
result <- lm(sales ~ price + promotion, data = mydata)
summary(result)
