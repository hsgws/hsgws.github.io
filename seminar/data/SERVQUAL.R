library(sem)

#データの読み込み#
cor <- readMoments(names = c("y1", "y2", "y3", "y4","y5", "y6","y7", "y8", "y9", "y10"
))
1.00
0.76 1.00
0.39 0.32 1.00
0.48 0.39 0.68 1.00
0.46 0.28 0.33 0.45 1.00
0.40 0.45 0.37 0.40 0.72 1.00
0.23 0.37 0.42 0.31 0.37 0.47 1.00
0.31 0.39 0.34 0.34 0.42 0.47 0.81 1.00
0.48 0.23 0.30 0.31 0.33 0.40 0.44 0.48 1.00
0.38 0.23 0.40 0.31 0.33 0.30 0.44 0.48 0.80 1.00

#モデルの作成#

#測定方程式
　　#ラベル
model <- specifyModel()
知覚品質 -> 信頼性, a1, NA #2次因子
知覚品質 -> 有形性, a2, NA
知覚品質 -> 応答性, a3, NA
知覚品質 -> 保証性, a4, NA
知覚品質 -> 共感性, a5, NA
信頼性 -> y1, NA, 1     #1次因子
信頼性 -> y2, b1, NA
有形性 -> y3, NA, 1
有形性 -> y4, b2, NA
応答性 -> y5, NA, 1
応答性 -> y6, b3, NA
保証性 -> y7, NA, 1
保証性 -> y8, b4, NA
共感性 -> y9, NA, 1
共感性 -> y10, b5, NA
知覚品質 <-> 知覚品質, NA, 1
信頼性   <-> 信頼性, d2, NA
有形性   <-> 有形性, d3, NA
応答性   <-> 応答性, d4, NA
保証性   <-> 保証性, d5, NA
共感性   <-> 共感性, d6, NA
y1 <-> y1, e1, NA
y2 <-> y2, e2, NA
y3 <-> y3, e3, NA
y4 <-> y4, e4, NA
y5 <-> y5, e5, NA
y6 <-> y6, e6, NA
y7 <-> y7, e7, NA
y8 <-> y8, e8, NA
y9 <-> y9, e9, NA
y10 <-> y10, e10, NA

#分析と出力#
y.sem <- sem(model, cor, N = 100)
summary(y.sem,
        fit.indices = c("GFI", "AGFI", "RMSEA","NFI", "NNFI",
                        "CFI", "RNI", "IFI", "SRMR", "AIC",
                        "AICc", "BIC", "CAIC"))

#パス図の作成#
pathDiagram(y.sem, out.file="servqual.txt", ignore.double=FALSE, 
edge.labels="values", digits=3,
node.font=c("C:/WINDOWS/Fonts/msgothic.ttc",10)) 

