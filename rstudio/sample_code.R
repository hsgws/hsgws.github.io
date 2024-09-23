# データの読み込み
sample_data <- read.csv("data/sample_data.csv")

# データの基礎集計
summary(sample_data)

# salesとpriceの散布図
plot(x = sample_data$price, y = sample_data$sales)
