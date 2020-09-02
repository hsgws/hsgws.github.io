data_csi <- read.csv("data/data_csi.csv")
library(lavaan)

# モデル（パス図）定義
model <- "
  # 測定方程式
    CE =~ CE1 + CE2 + CE3  # 顧客期待 (CE)
    PQ =~ PQ1 + PQ2 + PQ3  # 知覚品質 (PQ)
    CS =~ CS1 + CS2 + CS3  # 顧客満足 (CS)
  # 構造方程式
    PQ ~ CE
    CS ~ CE + PQ
"

# パラメータ推定
result <- sem(model, data = data_csi)

# 推定結果の表示
summary(result, fit.measures = TRUE, standardized = TRUE)


a <- summary(result, fit.measures = TRUE, standardized = TRUE)
