seg <- read.csv("data/seg.csv")

# 因子分析
fa <- factanal(seg[,1:27], factors = 4, scores = "regression")

# 因子負荷量
print(fa, cutoff = 0.3, sort = TRUE)

# クラスター分析
result <- kmeans(fa$scores, centers = 5)

# 各セグメントの重心
result$centers

# 各回答者の所属セグメント
result$cluster


seg <- data.frame(seg, cluster = result$cluster)

print(result$size)  # 人数
print(result$size/nrow(seg))            # 人数比

mean(seg$age)   # 平均年齢（全体）
tapply(seg$age, seg$cluster, mean)    # 平均年齢（セグメント別）

mean(seg$gender)  # 女性比率（全体）
tapply(seg$gender, seg$cluster, mean) # 女性比率（セグメント別）